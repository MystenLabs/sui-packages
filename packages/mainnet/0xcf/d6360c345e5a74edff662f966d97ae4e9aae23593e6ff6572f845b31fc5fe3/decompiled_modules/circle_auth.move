module 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth {
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

