module 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::mint_allowance {
    struct MintAllowance<phantom T0> has store {
        value: u64,
    }

    public(friend) fun decrease<T0>(arg0: &mut MintAllowance<T0>, arg1: u64) {
        assert!(arg0.value >= arg1, 1);
        arg0.value = arg0.value - arg1;
    }

    public(friend) fun destroy<T0>(arg0: MintAllowance<T0>) {
        let MintAllowance {  } = arg0;
    }

    public(friend) fun increase<T0>(arg0: &mut MintAllowance<T0>, arg1: u64) {
        assert!(arg1 < 18446744073709551615 - arg0.value, 0);
        arg0.value = arg0.value + arg1;
    }

    public(friend) fun new<T0>() : MintAllowance<T0> {
        MintAllowance<T0>{value: 0}
    }

    public(friend) fun set<T0>(arg0: &mut MintAllowance<T0>, arg1: u64) {
        arg0.value = arg1;
    }

    public(friend) fun value<T0>(arg0: &MintAllowance<T0>) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

