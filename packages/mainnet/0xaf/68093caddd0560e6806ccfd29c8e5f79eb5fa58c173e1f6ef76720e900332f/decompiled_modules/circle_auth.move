module 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::circle_auth {
    struct CircleAuth has drop {
        dummy_field: bool,
    }

    public fun identifier() : address {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<CircleAuth>()
    }

    public(friend) fun new() : CircleAuth {
        CircleAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

