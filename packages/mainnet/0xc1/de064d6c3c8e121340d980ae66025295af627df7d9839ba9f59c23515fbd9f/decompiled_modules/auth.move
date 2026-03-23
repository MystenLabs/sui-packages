module 0xc1de064d6c3c8e121340d980ae66025295af627df7d9839ba9f59c23515fbd9f::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

