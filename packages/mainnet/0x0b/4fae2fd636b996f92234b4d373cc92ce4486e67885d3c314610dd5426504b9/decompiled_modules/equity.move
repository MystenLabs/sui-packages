module 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::equity {
    struct EquityShareBalance<phantom T0> has store {
        value_x64: u128,
    }

    struct EquityRegistry<phantom T0> has store {
        supply_x64: u128,
        underlying_value_x64: u128,
    }

    struct EquityTreasury<phantom T0> has store {
        registry: EquityRegistry<T0>,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun borrow_mut_registry<T0>(arg0: &mut EquityTreasury<T0>) : &mut EquityRegistry<T0> {
        &mut arg0.registry
    }

    public fun borrow_registry<T0>(arg0: &EquityTreasury<T0>) : &EquityRegistry<T0> {
        &arg0.registry
    }

    public fun calc_balance_redeem_for_amount<T0>(arg0: &EquityRegistry<T0>, arg1: u64) : (u64, u64) {
        let v0 = (0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_round_up_u128((arg1 as u128), arg0.supply_x64, arg0.underlying_value_x64) as u64);
        (v0, calc_redeem_lossy<T0>(arg0, (v0 as u128) * 18446744073709551616))
    }

    public fun calc_redeem_for_amount<T0>(arg0: &EquityRegistry<T0>, arg1: u64) : u128 {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_round_up_u128((arg1 as u128) * 18446744073709551616, arg0.supply_x64, arg0.underlying_value_x64)
    }

    public fun calc_redeem_for_amount_x64<T0>(arg0: &EquityRegistry<T0>, arg1: u128) : (u128, u128) {
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_round_up_u128(arg1, arg0.supply_x64, arg0.underlying_value_x64);
        (v0, calc_redeem_x64<T0>(arg0, v0))
    }

    public fun calc_redeem_lossy<T0>(arg0: &EquityRegistry<T0>, arg1: u128) : u64 {
        ((calc_redeem_x64<T0>(arg0, arg1) / 18446744073709551616) as u64)
    }

    public fun calc_redeem_x64<T0>(arg0: &EquityRegistry<T0>, arg1: u128) : u128 {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_u128(arg0.underlying_value_x64, arg1, arg0.supply_x64)
    }

    public fun create_registry<T0: drop>(arg0: T0) : EquityRegistry<T0> {
        EquityRegistry<T0>{
            supply_x64           : 0,
            underlying_value_x64 : 0,
        }
    }

    public fun create_treasury<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (EquityTreasury<T0>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = EquityRegistry<T0>{
            supply_x64           : 0,
            underlying_value_x64 : 0,
        };
        let v3 = EquityTreasury<T0>{
            registry : v2,
            cap      : v0,
        };
        (v3, v1)
    }

    public fun decrease_value<T0>(arg0: &mut EquityRegistry<T0>, arg1: u64) {
        decrease_value_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616);
    }

    public fun decrease_value_x64<T0>(arg0: &mut EquityRegistry<T0>, arg1: u128) {
        arg0.underlying_value_x64 = arg0.underlying_value_x64 - arg1;
    }

    public fun destroy_empty_registry<T0>(arg0: EquityRegistry<T0>) {
        let EquityRegistry {
            supply_x64           : v0,
            underlying_value_x64 : v1,
        } = arg0;
        assert!(v0 == 0, 0);
        assert!(v1 == 0, 0);
    }

    public fun destroy_zero<T0>(arg0: EquityShareBalance<T0>) {
        assert!(arg0.value_x64 == 0, 0);
        let EquityShareBalance {  } = arg0;
    }

    public fun from_balance<T0>(arg0: &mut EquityTreasury<T0>, arg1: 0x2::balance::Balance<T0>) : EquityShareBalance<T0> {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.cap), arg1);
        EquityShareBalance<T0>{value_x64: (0x2::balance::value<T0>(&arg1) as u128) * 18446744073709551616}
    }

    public fun increase_value<T0>(arg0: &mut EquityRegistry<T0>, arg1: u64) {
        increase_value_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616);
    }

    public fun increase_value_and_issue<T0>(arg0: &mut EquityRegistry<T0>, arg1: u64) : EquityShareBalance<T0> {
        increase_value_and_issue_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616)
    }

    public fun increase_value_and_issue_x64<T0>(arg0: &mut EquityRegistry<T0>, arg1: u128) : EquityShareBalance<T0> {
        if (arg0.underlying_value_x64 == 0) {
            arg0.underlying_value_x64 = arg1;
            arg0.supply_x64 = arg1;
            return EquityShareBalance<T0>{value_x64: arg1}
        };
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_u128(arg0.supply_x64, arg1, arg0.underlying_value_x64);
        arg0.underlying_value_x64 = arg0.underlying_value_x64 + arg1;
        arg0.supply_x64 = arg0.supply_x64 + v0;
        EquityShareBalance<T0>{value_x64: v0}
    }

    public fun increase_value_x64<T0>(arg0: &mut EquityRegistry<T0>, arg1: u128) {
        arg0.underlying_value_x64 = arg0.underlying_value_x64 + arg1;
    }

    public fun into_balance<T0>(arg0: &mut EquityShareBalance<T0>, arg1: &mut EquityTreasury<T0>) : 0x2::balance::Balance<T0> {
        let v0 = arg0.value_x64 / 18446744073709551616 * 18446744073709551616;
        into_balance_lossy<T0>(split_x64<T0>(arg0, v0), arg1)
    }

    public fun into_balance_lossy<T0>(arg0: EquityShareBalance<T0>, arg1: &mut EquityTreasury<T0>) : 0x2::balance::Balance<T0> {
        let EquityShareBalance { value_x64: v0 } = arg0;
        arg1.registry.supply_x64 = arg1.registry.supply_x64 - v0 % 18446744073709551616;
        0x2::coin::mint_balance<T0>(&mut arg1.cap, ((v0 / 18446744073709551616) as u64))
    }

    public fun join<T0>(arg0: &mut EquityShareBalance<T0>, arg1: EquityShareBalance<T0>) {
        let EquityShareBalance { value_x64: v0 } = arg1;
        arg0.value_x64 = arg0.value_x64 + v0;
    }

    public fun redeem_lossy<T0>(arg0: &mut EquityRegistry<T0>, arg1: EquityShareBalance<T0>) : u64 {
        let v0 = redeem_x64<T0>(arg0, arg1);
        arg0.underlying_value_x64 = arg0.underlying_value_x64 + v0 % 18446744073709551616;
        ((v0 / 18446744073709551616) as u64)
    }

    public fun redeem_x64<T0>(arg0: &mut EquityRegistry<T0>, arg1: EquityShareBalance<T0>) : u128 {
        let EquityShareBalance { value_x64: v0 } = arg1;
        let v1 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv_u128(arg0.underlying_value_x64, v0, arg0.supply_x64);
        arg0.underlying_value_x64 = arg0.underlying_value_x64 - v1;
        arg0.supply_x64 = arg0.supply_x64 - v0;
        v1
    }

    public fun split<T0>(arg0: &mut EquityShareBalance<T0>, arg1: u64) : EquityShareBalance<T0> {
        split_x64<T0>(arg0, (arg1 as u128) * 18446744073709551616)
    }

    public fun split_x64<T0>(arg0: &mut EquityShareBalance<T0>, arg1: u128) : EquityShareBalance<T0> {
        let v0 = EquityShareBalance<T0>{value_x64: arg1};
        arg0.value_x64 = arg0.value_x64 - arg1;
        v0
    }

    public fun supply_x64<T0>(arg0: &EquityRegistry<T0>) : u128 {
        arg0.supply_x64
    }

    public fun underlying_value_x64<T0>(arg0: &EquityRegistry<T0>) : u128 {
        arg0.underlying_value_x64
    }

    public fun value_x64<T0>(arg0: &EquityShareBalance<T0>) : u128 {
        arg0.value_x64
    }

    public fun withdraw_all<T0>(arg0: &mut EquityShareBalance<T0>) : EquityShareBalance<T0> {
        let v0 = arg0.value_x64;
        split_x64<T0>(arg0, v0)
    }

    public fun zero<T0>() : EquityShareBalance<T0> {
        EquityShareBalance<T0>{value_x64: 0}
    }

    // decompiled from Move bytecode v6
}

