module 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

