module 0x2::balance {
    struct Supply<phantom T0> has store {
        value: u64,
    }

    struct Balance<phantom T0> has store {
        value: u64,
    }

    fun create_staking_rewards<T0>(arg0: u64, arg1: &0x2::tx_context::TxContext) : Balance<T0> {
        assert!(0x2::tx_context::sender(arg1) == @0x0, 3);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI", 4);
        Balance<T0>{value: arg0}
    }

    public fun create_supply<T0: drop>(arg0: T0) : Supply<T0> {
        Supply<T0>{value: 0}
    }

    public(friend) fun create_supply_internal<T0>() : Supply<T0> {
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
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI", 4);
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
        assert!(arg1 <= 18446744073709551615 - arg0.value, 1);
        arg0.value = arg0.value + arg1;
        Balance<T0>{value: arg1}
    }

    public fun join<T0>(arg0: &mut Balance<T0>, arg1: Balance<T0>) : u64 {
        let Balance { value: v0 } = arg1;
        arg0.value = arg0.value + v0;
        arg0.value
    }

    public fun redeem_funds<T0>(arg0: 0x2::funds_accumulator::Withdrawal<Balance<T0>>) : Balance<T0> {
        0x2::funds_accumulator::redeem<Balance<T0>>(arg0, 0x1::internal::permit<Balance<T0>>())
    }

    public fun send_funds<T0>(arg0: Balance<T0>, arg1: address) {
        0x2::funds_accumulator::add_impl<Balance<T0>>(arg0, arg1);
    }

    public fun settled_funds_value<T0>(arg0: &0x2::accumulator::AccumulatorRoot, arg1: address) : u64 {
        if (!0x2::accumulator::accumulator_u128_exists<Balance<T0>>(arg0, arg1)) {
            return 0
        };
        (0x1::u128::min(18446744073709551615, 0x2::accumulator::accumulator_u128_read<Balance<T0>>(arg0, arg1)) as u64)
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

    public fun withdraw_funds_from_object<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::funds_accumulator::Withdrawal<Balance<T0>> {
        0x2::funds_accumulator::withdraw_from_object<Balance<T0>>(arg0, (arg1 as u256))
    }

    public fun zero<T0>() : Balance<T0> {
        Balance<T0>{value: 0}
    }

    // decompiled from Move bytecode v6
}

