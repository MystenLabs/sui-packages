module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

