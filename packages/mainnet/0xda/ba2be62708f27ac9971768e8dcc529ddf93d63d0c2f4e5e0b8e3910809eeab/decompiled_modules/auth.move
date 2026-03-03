module 0xdaba2be62708f27ac9971768e8dcc529ddf93d63d0c2f4e5e0b8e3910809eeab::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

