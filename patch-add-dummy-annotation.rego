package kubernetes.admission

# A trivial example that generates a JSON patch to set an annotation.

patch[p] {
    input.request.object.metadata.labels["test-opa-patch"]
    p := {
        "op": "add",
        "path": "/metadata/annotations/test-key",
        "value": "test-value",
    }
}

test_patch_positive {
    patch[{
        "op": "add",
        "path": "/metadata/annotations/test-key",
        "value": "test-value",
    }] with input.request.object as {
        "metadata": {
            "labels": {
                "test-opa-patch": "true",
            }
        }
    }
}

test_patch_negative {
    not patch[{
        "op": "add",
        "path": "/metadata/annotations/test-key",
        "value": "test-value",
    }] with input.request.object as {
        "metadata": {
            "labels": {
            }
        }
    }
}