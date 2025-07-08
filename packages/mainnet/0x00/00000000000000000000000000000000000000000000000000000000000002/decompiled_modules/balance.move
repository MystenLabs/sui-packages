module 0x2::balance {
    struct Supply<phantom T0> has store {
        value: u64,
    }

    struct Balance<phantom T0> has store {
        value: u64,
    }

    fun create_staking_rewards<T0>(arg0: u64, arg1: &0x2::tx_context::TxContext) : Balance<T0> {
        assert!(0x2::tx_context::sender(arg1) == @0x0, 3);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI", 4);
        Balance<T0>{value: arg0}
    }

    public fun create_supply<T0: drop>(arg0: T0) : Supply<T0> {
        Supply<T0>{value: 0}
    }

    public fun decrease_supply<T0>(arg0: &mut Supply<T0>, arg1: Balance<T0>) : u64 {
        let Balance { value: v0 } = arg1;
        assert!(arg0.value >= v0, 1);
        arg0.value = arg0.value - v0;
        v0
    }

    fun destroy_storage_rebates<T0>(arg0: Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x0, 3);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI", 4);
        let Balance {  } = arg0;
    }

    public(friend) fun destroy_supply<T0>(arg0: Supply<T0>) : u64 {
        let Supply { value: v0 } = arg0;
        v0
    }

    public fun destroy_zero<T0>(arg0: Balance<T0>) {
        assert!(arg0.value == 0, 0);
        let Balance {  } = arg0;
    }

    public fun increase_supply<T0>(arg0: &mut Supply<T0>, arg1: u64) : Balance<T0> {
        assert!(arg1 < 18446744073709551615 - arg0.value, 1);
        arg0.value = arg0.value + arg1;
        Balance<T0>{value: arg1}
    }

    public fun join<T0>(arg0: &mut Balance<T0>, arg1: Balance<T0>) : u64 {
        let Balance { value: v0 } = arg1;
        arg0.value = arg0.value + v0;
        arg0.value
    }

    public fun split<T0>(arg0: &mut Balance<T0>, arg1: u64) : Balance<T0> {
        assert!(arg0.value >= arg1, 2);
        arg0.value = arg0.value - arg1;
        Balance<T0>{value: arg1}
    }

    public fun supply_value<T0>(arg0: &Supply<T0>) : u64 {
        arg0.value
    }

    public fun value<T0>(arg0: &Balance<T0>) : u64 {
        arg0.value
    }

    public fun withdraw_all<T0>(arg0: &mut Balance<T0>) : Balance<T0> {
        let v0 = arg0.value;
        split<T0>(arg0, v0)
    }

    public fun zero<T0>() : Balance<T0> {
        Balance<T0>{value: 0}
    }

    // decompiled from Move bytecode v6
}

