package kubernetes.admission

# A trivial example that checks for a specific label.

# deny contains message "missing ..." if
deny["missing required label"] {
    input.request.object.metadata.labels["test-opa-validation"]  # user supplied test label, and
    not input.request.object.metadata.labels["required-label"]   # missing required-label label.
}

test_deny_positive {
    deny["missing required label"] with input.request.object as {
        "metadata": {
            "labels": {
                "test-opa-validation": "true",
            }
        }
    }
}

test_deny_negative {
    not deny["missing required label"] with input.request.object as {
        "metadata": {
            "labels": {
            }
        }
    }
    not deny["missing required label"] with input.request.object as {
        "metadata": {
            "labels": {
                "test-opa-validation": "true",
                "required-label": "true",
            }
        }
    }
}
