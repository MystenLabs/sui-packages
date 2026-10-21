module 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth {
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

