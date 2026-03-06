module 0x12363208d961db2044cdfe3e3675f0d19158a93c9eb7d62fcb95e3381f2d3825::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

