module 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils {
    struct Marker<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    public fun marker<T0, T1>() : Marker<T0, T1> {
        Marker<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

