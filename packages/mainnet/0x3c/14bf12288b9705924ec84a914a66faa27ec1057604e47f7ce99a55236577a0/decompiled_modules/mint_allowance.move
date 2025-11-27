module 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::mint_allowance {
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

