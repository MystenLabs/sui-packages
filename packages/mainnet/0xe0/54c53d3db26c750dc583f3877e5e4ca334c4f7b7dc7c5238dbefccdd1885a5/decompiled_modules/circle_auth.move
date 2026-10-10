module 0xe054c53d3db26c750dc583f3877e5e4ca334c4f7b7dc7c5238dbefccdd1885a5::circle_auth {
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

