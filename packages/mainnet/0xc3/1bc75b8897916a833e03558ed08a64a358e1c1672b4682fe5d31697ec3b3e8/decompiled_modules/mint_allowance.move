module 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::mint_allowance {
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

