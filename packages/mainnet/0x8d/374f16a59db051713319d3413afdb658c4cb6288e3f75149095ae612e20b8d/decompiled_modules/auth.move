module 0x8d374f16a59db051713319d3413afdb658c4cb6288e3f75149095ae612e20b8d::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

