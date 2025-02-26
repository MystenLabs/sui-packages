module 0xe8bbc1cbc9fa45076ec6dfc5be186851cec16571a35ec946468376a7cdc23e40::wrapper {
    struct DeepBookV3RouterWrapper has store, key {
        id: 0x2::object::UID,
        deep_reserves: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        charged_fees: 0x2::bag::Bag,
    }

    struct ChargedFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DeepBookV3FundCap has store, key {
        id: 0x2::object::UID,
        wrapper_id: 0x2::object::ID,
    }

    public fun join(arg0: &mut DeepBookV3RouterWrapper, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun get_quantity_out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        if (arg1 > 0) {
            v3 = v1 - calculate_fee_amount(v1, v5);
        } else if (arg2 > 0) {
            v4 = v0 - calculate_fee_amount(v0, v5);
        };
        (v4, v3, v2)
    }

    fun calculate_fee_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    fun charge_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_fee_amount(0x2::balance::value<T0>(v0), arg1))
    }

    public fun create_fund_cap(arg0: &0xe8bbc1cbc9fa45076ec6dfc5be186851cec16571a35ec946468376a7cdc23e40::admin::AdminCap, arg1: &DeepBookV3RouterWrapper, arg2: &mut 0x2::tx_context::TxContext) : DeepBookV3FundCap {
        DeepBookV3FundCap{
            id         : 0x2::object::new(arg2),
            wrapper_id : 0x2::object::uid_to_inner(&arg1.id),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookV3RouterWrapper{
            id            : 0x2::object::new(arg0),
            deep_reserves : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            charged_fees  : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<DeepBookV3RouterWrapper>(v0);
    }

    fun join_fee<T0>(arg0: &mut DeepBookV3RouterWrapper, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.charged_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.charged_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.charged_fees, v0, arg1);
        };
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut DeepBookV3RouterWrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), v0, arg3, arg4, arg5);
        let v4 = v2;
        join(arg0, v3);
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v8 = &mut v4;
        join_fee<T1>(arg0, charge_fee<T1>(v8, v5));
        (v1, v4)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut DeepBookV3RouterWrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, v0, arg3, arg4, arg5);
        let v4 = v1;
        join(arg0, v3);
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v8 = &mut v4;
        join_fee<T0>(arg0, charge_fee<T0>(v8, v5));
        (v4, v2)
    }

    public fun withdraw_charged_fee<T0>(arg0: &DeepBookV3FundCap, arg1: &mut DeepBookV3RouterWrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.wrapper_id == 0x2::object::uid_to_inner(&arg1.id), 9223372835718692865);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg1.charged_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.charged_fees, v0)), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    // decompiled from Move bytecode v6
}

