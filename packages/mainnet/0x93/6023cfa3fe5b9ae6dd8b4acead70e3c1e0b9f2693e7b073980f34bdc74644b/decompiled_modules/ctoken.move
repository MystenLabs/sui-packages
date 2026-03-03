module 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

