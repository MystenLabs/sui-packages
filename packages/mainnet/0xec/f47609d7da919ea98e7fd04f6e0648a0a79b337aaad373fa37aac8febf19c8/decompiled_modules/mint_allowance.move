module 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance {
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

