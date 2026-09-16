module 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

