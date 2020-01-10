package main_test

import data.system.main

test_main_with_no_input {
    main == {
      "apiVersion": "admission.k8s.io/v1beta1",
      "kind": "AdmissionReview",
      "response": {
        "allowed": true
      }
    }
}


test_main_with_input_requiring_patch {
    some encoded_patches

    main = {
      "apiVersion": "admission.k8s.io/v1beta1",
      "kind": "AdmissionReview",
      "response": {
        "allowed": true,
        "patchType": "JSONPatch",
        "patch": encoded_patches,
      }
    } with input.request.object as {
        "metadata": {
            "labels": {
                "test-opa-patch": "true",
            }
        }
    }

    patches := json.unmarshal(base64.decode(encoded_patches))

    patches == [
      {
        "op": "add",
        "path": "/metadata/annotations",
        "value": {}
      },
      {
        "op": "add",
        "path": "/metadata/annotations/test-key",
        "value": "test-value"
      }
    ]
}

test_main_with_input_failing_validation {

    main == {
      "apiVersion": "admission.k8s.io/v1beta1",
      "kind": "AdmissionReview",
      "response": {
          "allowed": false,
          "status": {
              "reason": "missing required label",
          },
      },
    } with input.request.object as {
        "metadata": {
            "labels": {
                "test-opa-validation": "true",
            }
        }
    }

}