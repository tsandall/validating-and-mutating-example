# 🛠 Validating and Mutating Admission Control Example 🛠

This repository contains a small example of how to combine validating and mutating admission control policies in OPA using the [entry point contributed to the open-policy-agent/library repostiory](https://github.com/open-policy-agent/library/blob/master/kubernetes/mutating-admission/main.rego).

## Examples

* 🔪 The mutating policy sets an annotation on objects that indicate a requirement.
* 🛡️ The validating policy example checks for a specific label.

There are four files:

* [main.rego](./main.rego) is the entry point from the library repository
  copied with minor changes.
* [main_test.rego](main_test.rego) shows an end-to-end test of the
  validating and mutating policies.
* [validating-deny-missing-label.rego](validating-deny-missing-label.rego) shows a trivial validation policy with unit testing.
* [patch-add-dummy-annotation.rego](patch-add-dummy-annotation.rego)
  shows a trivial mutating policy with unit testing.

## Running

You can run the tests on the command-line:

```
opa test -b . -v
```

You can evaluate the entire policy with an example input on the command-line:

```
opa eval -b . -i input.json 'data.system.main'
```

> Hint: check out the ['Open Policy Agent' extension for VS Code](https://github.com/open-policy-agent/vscode-opa). Try the `OPA: Test Workspace`, `OPA: Evaluate Selection`, and `OPA: Toggle Evaluation Coverage` commands on this project.