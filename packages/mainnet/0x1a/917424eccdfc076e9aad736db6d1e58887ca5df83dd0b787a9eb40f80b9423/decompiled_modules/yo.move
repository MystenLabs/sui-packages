module 0x1a917424eccdfc076e9aad736db6d1e58887ca5df83dd0b787a9eb40f80b9423::yo {
    struct YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<YO>(arg0, 6, b"YO", b"happy yo's", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqoEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSMgDAAABoFVrb1Db+iVUQiQgoRJwcOvg4AAcLBxkOeA6qIRKiIRKyMPeO5SkvEfEBCAmrduHq4j+Kq1eny0veEcqn9Z1cK+fleaW1o/o443zrFKpXZ12XieUP11dC9Nc1qoBrzyNtIsGlTKHIhpY1ni5anCmWHTpBPdI/7pOUXIUqjrNPUbuOlGhALvOtRdv6dLp7r5IdMJXckSiU27kZuk6aSEnS9dpC7lYuk5cyAF1nbrQYyQ6+ZYeSqLT54cufcH9kV1f8b8HVn3HTsNIXkJbGsX6mp9BRV80DyF5E0kjWF/1GJD1XesAeRm5V/Rl2z15G75V9G3plrwN427RlxW61e4Jj26jGo/uozbcXfR+xehjkBBG10GC2xxug7Nyr0cTOGPcLhqteKN7VzSGM8btpNHImdC9NRrDWcF9DibkTGCkWpcfEqzA2WoR1QqANJbAGcNYVFUTUIKt3siQ5EcBzlgMZweMu/48gRqLnAkZSH+tgIY64KzAyL91LKGEnAmMi/5JOVSBs8Uif61bJIEzhrHo39sZafFGBhLDeQViODtg3NXINRAZUvEgyUBqrS3OAeN+eCgwskkkjMBI6kFgXNXWwxQLuyCL2LpGERizemAYi7p0QBbx0MlAMgeGsaiHA0bWKXQykHgQGElv9xgHjB/1UCx8T0IIjKQeGoxFb0uMYmEXZJF7rUaoMBb1wDD+0/v1G4Es4kHIQDLg/zMAw1jUwwEj68Bz8ydkIPEgMJKO3FZ/G4ysHoqlDsnkTmAk9XDBWHTogu6tWC4XZJEhHajOGMaiHhjGXYdW4HRGFvHAZKA+5gSKL4JxVw8EI+vYFUi+rCQurKSDCYAEYXUmgxoAnDFInRUdzD9yjOZNRuUfqUco6mzXwR2/fiOIM9LR/FsOsKszHpZ/Q3dH6mzR0YI/D3fsTYbxX+Qtq7N/Opz+QvVF4oz6MIYx+7rUVxIdni2onlh9pabDG8zZEauv1HR8saF6oaq+SHS84GZ2snb19a/rg/kOqodcdfig3PRJxm16LG1VHxyR9qbP0j0ctkbmJZdP1Wc/ZM7r9mn69IGBSUzTFwzNb0JjcL7HgcFJ3kIwnPo7dBqH8g4FT55vcODZa35fPJza7Fp6CiRzE8LzJDMTgkeSeQnBJ8mshOCVZE4twW+6ZvRNcH3M54D3rc+lF/gnmUkjhDzncSJqljlIRtx0TKAfCaHpG60Swq8SqWZMsUiUmjHNXCPUjKnSV3z1I2G+67d76Zwx6/xtz8mZMXdaz9pH9XqWhHdc8nZetclvIpXPbSXEBFZQOCC8AAAA8AwAnQEqgACAAD5lKJBFpCKhmb/EAEAGRLS3b+YA/QD9AP4B5AH0AfwAH3f8APoABk0tHNeSsPoVGqcfzWrM9JkJ+JyzWg31Zb1+JC/EuNHcVFzMPgWqapQItovNaFE54nc7a1r8FPPCn3weTtmsAAD+/F5ix8TjLkpQwj8TjLlOqT+lIg2uYBL/5WJE//KxDs3Xt/+VjRvGsdJf+UiV3/lIsm0PVtDe/Jl+q6o7E3w/kt/7m3L/vsgAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YO>>(v1);
    }

    // decompiled from Move bytecode v6
}

