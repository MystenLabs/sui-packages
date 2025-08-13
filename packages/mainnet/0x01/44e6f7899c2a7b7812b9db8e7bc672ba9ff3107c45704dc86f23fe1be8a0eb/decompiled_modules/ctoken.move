module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::ctoken {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>() : CToken<T0, T1> {
        CToken<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

