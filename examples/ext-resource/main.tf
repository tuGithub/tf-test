data "external" "echo" {
  program = ["bash", "-c", "cat /dev/stdin"]

  query = {
    foo1 = "bar1"
  }
}

output "echo" {
  value = data.external.echo.result
}

output "echo_foo" {
  value = data.external.echo.result.foo1
}