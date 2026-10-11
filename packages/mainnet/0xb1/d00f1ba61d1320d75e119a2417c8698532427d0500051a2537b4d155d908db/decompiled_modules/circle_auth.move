module 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::circle_auth {
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

