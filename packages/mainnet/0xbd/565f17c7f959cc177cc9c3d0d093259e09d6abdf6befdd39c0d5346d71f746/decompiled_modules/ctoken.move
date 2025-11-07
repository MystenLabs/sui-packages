module 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

