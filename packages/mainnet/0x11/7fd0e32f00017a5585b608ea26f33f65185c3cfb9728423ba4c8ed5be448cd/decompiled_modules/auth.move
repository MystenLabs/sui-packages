module 0x117fd0e32f00017a5585b608ea26f33f65185c3cfb9728423ba4c8ed5be448cd::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

