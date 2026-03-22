module 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

