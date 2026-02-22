module 0xd0f73c3931fe809ce6de699e59affa9e7ad26475b6ad81ac7c68a4a6557abc64::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

