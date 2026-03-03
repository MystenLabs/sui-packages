module 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

