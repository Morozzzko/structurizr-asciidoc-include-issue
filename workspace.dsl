workspace "Sample" "This workspace illustrates issues that have been found while using include" {
    !docs docs/arc42

    model {
    }

    views {
    }

    !script scripts/allow-import-in-asciidoc.rb
}
