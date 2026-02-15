module 0x2f8d3faa014e1cd5b84cf1e6d09dd4d3e135372c641af28ed93a5007be824a11::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

