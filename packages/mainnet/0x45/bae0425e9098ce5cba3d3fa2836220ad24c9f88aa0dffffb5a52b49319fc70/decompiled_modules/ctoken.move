module 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

