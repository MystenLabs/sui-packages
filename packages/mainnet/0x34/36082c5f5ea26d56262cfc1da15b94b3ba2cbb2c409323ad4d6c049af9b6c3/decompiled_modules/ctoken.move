module 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

