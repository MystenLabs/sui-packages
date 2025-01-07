module 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::debt {
    struct DebtShareBalance<phantom T0> has store {
        value_x64: u128,
    }

    struct DebtRegistry<phantom T0> has store {
        supply_x64: u128,
        liability_value_x64: u128,
    }

    struct DebtTreasury<phantom T0> has store {
        registry: DebtRegistry<T0>,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun borrow_mut_registry<T0>(arg0: &mut DebtTreasury<T0>) : &mut DebtRegistry<T0> {
        &mut arg0.registry
    }

    public fun borrow_registry<T0>(arg0: &DebtTreasury<T0>) : &DebtRegistry<T0> {
        &arg0.registry
    }

    public fun calc_balance_repay_for_amount<T0>(arg0: &DebtRegistry<T0>, arg1: u64) : (u64, u64) {
        let v0 = (0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_u128((arg1 as u128), arg0.supply_x64, arg0.liability_value_x64) as u64);
        (v0, calc_repay_lossy<T0>(arg0, (v0 as u128) * 18446744073709551616))
    }

    public fun calc_repay_for_amount<T0>(arg0: &DebtRegistry<T0>, arg1: u64) : u128 {
        0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_u128((arg1 as u128) * 18446744073709551616, arg0.supply_x64, arg0.liability_value_x64)
    }

    public fun calc_repay_for_amount_x64<T0>(arg0: &DebtRegistry<T0>, arg1: u128) : (u128, u128) {
        let v0 = 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_u128(arg1, arg0.supply_x64, arg0.liability_value_x64);
        (v0, calc_repay_x64<T0>(arg0, v0))
    }

    public fun calc_repay_lossy<T0>(arg0: &DebtRegistry<T0>, arg1: u128) : u64 {
        (0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::divide_and_round_up_u128(calc_repay_x64<T0>(arg0, arg1), 18446744073709551616) as u64)
    }

    public fun calc_repay_x64<T0>(arg0: &DebtRegistry<T0>, arg1: u128) : u128 {
        0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_round_up_u128(arg0.liability_value_x64, arg1, arg0.supply_x64)
    }

    public fun create_registry<T0: drop>(arg0: T0) : DebtRegistry<T0> {
        DebtRegistry<T0>{
            supply_x64          : 0,
            liability_value_x64 : 0,
        }
    }

    public fun create_treasury<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (DebtTreasury<T0>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = DebtRegistry<T0>{
            supply_x64          : 0,
            liability_value_x64 : 0,
        };
        let v3 = DebtTreasury<T0>{
            registry : v2,
            cap      : v0,
        };
        (v3, v1)
    }

    public fun decrease_liability<T0>(arg0: &mut DebtRegistry<T0>, arg1: u64) {
        decrease_liability_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616);
    }

    public fun decrease_liability_x64<T0>(arg0: &mut DebtRegistry<T0>, arg1: u128) {
        arg0.liability_value_x64 = arg0.liability_value_x64 - arg1;
    }

    public fun destroy_empty_registry<T0>(arg0: DebtRegistry<T0>) {
        let DebtRegistry {
            supply_x64          : v0,
            liability_value_x64 : v1,
        } = arg0;
        assert!(v0 == 0, 0);
        assert!(v1 == 0, 0);
    }

    public fun destroy_zero<T0>(arg0: DebtShareBalance<T0>) {
        assert!(arg0.value_x64 == 0, 0);
        let DebtShareBalance {  } = arg0;
    }

    public fun from_balance<T0>(arg0: &mut DebtTreasury<T0>, arg1: 0x2::balance::Balance<T0>) : DebtShareBalance<T0> {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.cap), arg1);
        DebtShareBalance<T0>{value_x64: (0x2::balance::value<T0>(&arg1) as u128) * 18446744073709551616}
    }

    public fun increase_liability<T0>(arg0: &mut DebtRegistry<T0>, arg1: u64) {
        increase_liability_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616);
    }

    public fun increase_liability_and_issue<T0>(arg0: &mut DebtRegistry<T0>, arg1: u64) : DebtShareBalance<T0> {
        increase_liability_and_issue_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616)
    }

    public fun increase_liability_and_issue_x64<T0>(arg0: &mut DebtRegistry<T0>, arg1: u128) : DebtShareBalance<T0> {
        if (arg0.liability_value_x64 == 0) {
            arg0.liability_value_x64 = arg1;
            arg0.supply_x64 = arg1;
            return DebtShareBalance<T0>{value_x64: arg1}
        };
        let v0 = 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_round_up_u128(arg0.supply_x64, arg1, arg0.liability_value_x64);
        arg0.liability_value_x64 = arg0.liability_value_x64 + arg1;
        arg0.supply_x64 = arg0.supply_x64 + v0;
        DebtShareBalance<T0>{value_x64: v0}
    }

    public fun increase_liability_x64<T0>(arg0: &mut DebtRegistry<T0>, arg1: u128) {
        arg0.liability_value_x64 = arg0.liability_value_x64 + arg1;
    }

    public fun into_balance<T0>(arg0: &mut DebtShareBalance<T0>, arg1: &mut DebtTreasury<T0>) : 0x2::balance::Balance<T0> {
        let v0 = arg0.value_x64 / 18446744073709551616 * 18446744073709551616;
        into_balance_lossy<T0>(split_x64<T0>(arg0, v0), arg1)
    }

    public fun into_balance_lossy<T0>(arg0: DebtShareBalance<T0>, arg1: &mut DebtTreasury<T0>) : 0x2::balance::Balance<T0> {
        let DebtShareBalance { value_x64: v0 } = arg0;
        let v1 = if (v0 % 18446744073709551616 == 0) {
            0
        } else {
            18446744073709551616 - v0 % 18446744073709551616
        };
        arg1.registry.supply_x64 = arg1.registry.supply_x64 + v1;
        0x2::coin::mint_balance<T0>(&mut arg1.cap, (0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::divide_and_round_up_u128(v0, 18446744073709551616) as u64))
    }

    public fun join<T0>(arg0: &mut DebtShareBalance<T0>, arg1: DebtShareBalance<T0>) {
        let DebtShareBalance { value_x64: v0 } = arg1;
        arg0.value_x64 = arg0.value_x64 + v0;
    }

    public fun liability_value_x64<T0>(arg0: &DebtRegistry<T0>) : u128 {
        arg0.liability_value_x64
    }

    public fun repay_lossy<T0>(arg0: &mut DebtRegistry<T0>, arg1: DebtShareBalance<T0>) : u64 {
        let v0 = repay_x64<T0>(arg0, arg1);
        let v1 = if (v0 % 18446744073709551616 == 0) {
            0
        } else {
            18446744073709551616 - v0 % 18446744073709551616
        };
        arg0.liability_value_x64 = arg0.liability_value_x64 - v1;
        (0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::divide_and_round_up_u128(v0, 18446744073709551616) as u64)
    }

    public fun repay_x64<T0>(arg0: &mut DebtRegistry<T0>, arg1: DebtShareBalance<T0>) : u128 {
        let DebtShareBalance { value_x64: v0 } = arg1;
        let v1 = 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_round_up_u128(arg0.liability_value_x64, v0, arg0.supply_x64);
        arg0.liability_value_x64 = arg0.liability_value_x64 - v1;
        arg0.supply_x64 = arg0.supply_x64 - v0;
        v1
    }

    public fun split<T0>(arg0: &mut DebtShareBalance<T0>, arg1: u64) : DebtShareBalance<T0> {
        split_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616)
    }

    public fun split_x64<T0>(arg0: &mut DebtShareBalance<T0>, arg1: u128) : DebtShareBalance<T0> {
        let v0 = DebtShareBalance<T0>{value_x64: arg1};
        arg0.value_x64 = arg0.value_x64 - arg1;
        v0
    }

    public fun supply_x64<T0>(arg0: &DebtRegistry<T0>) : u128 {
        arg0.supply_x64
    }

    public fun value_x64<T0>(arg0: &DebtShareBalance<T0>) : u128 {
        arg0.value_x64
    }

    public fun withdraw_all<T0>(arg0: &mut DebtShareBalance<T0>) : DebtShareBalance<T0> {
        let v0 = arg0.value_x64;
        split_x64<T0>(arg0, v0)
    }

    public fun zero<T0>() : DebtShareBalance<T0> {
        DebtShareBalance<T0>{value_x64: 0}
    }

    // decompiled from Move bytecode v6
}

