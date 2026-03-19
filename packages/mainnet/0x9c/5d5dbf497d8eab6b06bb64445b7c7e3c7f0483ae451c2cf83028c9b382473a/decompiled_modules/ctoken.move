module 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

