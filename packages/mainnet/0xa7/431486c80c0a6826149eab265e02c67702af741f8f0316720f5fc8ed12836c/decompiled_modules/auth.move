module 0xa7431486c80c0a6826149eab265e02c67702af741f8f0316720f5fc8ed12836c::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

