module 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::deepbookv3 {
    struct BmLeg has copy, drop {
        pool: address,
        is_bid: bool,
        qty: u64,
        executed: u64,
        got: u64,
        kept: u64,
        deep_paid: u64,
    }

    struct Ticket<phantom T0> {
        plan: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan,
        loan: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>,
        principal: u64,
        change: 0x2::balance::Balance<T0>,
    }

    struct EmbeddedTicket<phantom T0> {
        inner: Ticket<T0>,
        settings: 0x2::object::ID,
    }

    fun bm_buy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg5), arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, true, true, arg4, arg5);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v4 = deep_value(&v2, v3, true);
        let v5 = if (v3 > v4) {
            0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v3 - v4, arg5))
        } else {
            0x2::balance::zero<T0>()
        };
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v7 = if (v6 > 0) {
            0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v6, arg5))
        } else {
            0x2::balance::zero<T1>()
        };
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let v9 = if (v0 > v8) {
            v0 - v8
        } else {
            0
        };
        let v10 = BmLeg{
            pool      : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            is_bid    : true,
            qty       : arg3,
            executed  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v2),
            got       : v3,
            kept      : v4,
            deep_paid : v9,
        };
        0x2::event::emit<BmLeg>(v10);
        (v5, v7)
    }

    public fun bm_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let (v0, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v4 = if (v0 == 0) {
            true
        } else if (0x1::type_name::with_defining_ids<T0>() == v3) {
            true
        } else {
            0x1::type_name::with_defining_ids<T1>() == v3
        };
        if (v4) {
            return 0
        };
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) != 0x2::tx_context::sender(arg3) || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) < 50000000) {
            return 0
        };
        if (v2 == 0 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg0, arg1)) {
            return v0
        };
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::total_volume(&v5);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::active_stake(&v5) < v2 || v6 == 0) {
            return v0
        };
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        let v8 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v7)) {
            v6 * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v7) as u128) / 1000000000
        } else {
            v6 * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg2) as u128) / 1000000000 * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v7) as u128) / 1000000000
        };
        if (v8 >= (v2 as u128)) {
            v0 / 2
        } else {
            v0
        }
    }

    fun bm_sell<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, false, true, arg4, arg5);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v4 = deep_value(&v2, v3, false);
        let v5 = if (v3 > v4) {
            0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v3 - v4, arg5))
        } else {
            0x2::balance::zero<T1>()
        };
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v7 = if (v6 > 0) {
            0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v6, arg5))
        } else {
            0x2::balance::zero<T0>()
        };
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let v9 = if (v0 > v8) {
            v0 - v8
        } else {
            0
        };
        let v10 = BmLeg{
            pool      : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            is_bid    : false,
            qty       : arg3,
            executed  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v2),
            got       : v3,
            kept      : v4,
            deep_paid : v9,
        };
        0x2::event::emit<BmLeg>(v10);
        (v5, v7)
    }

    fun buy_qty<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        if (bm_fee<T0, T1>(arg0, arg1, arg3, arg4) == 0) {
            return 0
        };
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, arg2, arg3);
        let v6 = v3 - v3 % v1;
        if (v6 < v2) {
            0
        } else {
            v6
        }
    }

    public fun check_bm_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_qty<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2), arg3, arg4);
        assert!(v0 > 0, 920);
        let (v1, v2) = bm_sell<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), v0, arg3, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T1>(v1, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T0>(v2, arg4);
    }

    public fun check_bm_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_qty<T0, T1>(arg0, arg1, 0x2::coin::value<T1>(&arg2), arg3, arg4);
        assert!(v0 > 0, 920);
        let (v1, v2) = bm_buy<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), v0, arg3, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T0>(v1, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T1>(v2, arg4);
    }

    fun deep_value(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(arg0), 920);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_deep_price(arg0);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v2);
        assert!(v3 > 0, 920);
        let v4 = div_down(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(arg0), v1);
        let v5 = if (arg2) {
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v2)) {
                div_up(v0, v3)
            } else if (v4 == 0) {
                arg1
            } else {
                div_up(div_up(v0, v3), v4)
            }
        } else if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v2)) {
            mul_up(div_up(v0, v3), v4)
        } else {
            div_up(v0, v3)
        };
        if (v5 > arg1) {
            arg1
        } else {
            v5
        }
    }

    fun div_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    fun div_up(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 1000000000 + (arg1 as u128) - 1) / (arg1 as u128)) as u64)
    }

    public fun finish_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: Ticket<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            loan      : v1,
            principal : v2,
            change    : v3,
        } = arg2;
        let v4 = v1;
        let v5 = v0;
        0x2::balance::join<T0>(&mut arg1, v3);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v4)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T0>(v5, arg1, 0, arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay<T0>(&v5, &mut arg1, v2), arg3), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4));
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T0>(v5, arg1, v2, arg3);
    }

    public fun finish_a2b_embedded<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: EmbeddedTicket<T0>, arg3: &0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::settings::Settings, arg4: &mut 0x2::tx_context::TxContext) {
        let EmbeddedTicket {
            inner    : v0,
            settings : v1,
        } = arg2;
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::check_settings(v1, arg3);
        let Ticket {
            plan      : v2,
            loan      : v3,
            principal : v4,
            change    : v5,
        } = v0;
        let v6 = v3;
        0x2::balance::join<T0>(&mut arg1, v5);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v6)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v6);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T0>(v2, arg1, 0, arg3, arg4);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay_embedded<T0>(&mut arg1, v4), arg4), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v6));
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T0>(v2, arg1, v4, arg3, arg4);
    }

    public fun finish_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: Ticket<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            loan      : v1,
            principal : v2,
            change    : v3,
        } = arg2;
        let v4 = v1;
        let v5 = v0;
        0x2::balance::join<T1>(&mut arg1, v3);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v4)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T1>(v5, arg1, 0, arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay<T1>(&v5, &mut arg1, v2), arg3), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4));
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T1>(v5, arg1, v2, arg3);
    }

    public fun finish_b2a_embedded<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: EmbeddedTicket<T1>, arg3: &0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::settings::Settings, arg4: &mut 0x2::tx_context::TxContext) {
        let EmbeddedTicket {
            inner    : v0,
            settings : v1,
        } = arg2;
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::check_settings(v1, arg3);
        let Ticket {
            plan      : v2,
            loan      : v3,
            principal : v4,
            change    : v5,
        } = v0;
        let v6 = v3;
        0x2::balance::join<T1>(&mut arg1, v5);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v6)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v6);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T1>(v2, arg1, 0, arg3, arg4);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay_embedded<T1>(&mut arg1, v4), arg4), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v6));
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T1>(v2, arg1, v4, arg3, arg4);
    }

    fun mul_up(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000) as u64)
    }

    public fun quote<T0, T1>(arg0: &mut 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2);
        let v0 = 0;
        while (v0 < 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::count(arg0)) {
            let v1 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let (v3, v4) = if (arg2) {
                    let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                    (v5, v6)
                } else {
                    let (v8, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                    (v8, v9)
                };
                if (arg2) {
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T0>(arg0, v0, v3);
                } else {
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T1>(arg0, v0, v4);
                };
                if (arg2) {
                    v4
                } else {
                    v3
                }
            };
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun quote_bm<T0, T1>(arg0: &mut 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = bm_fee<T0, T1>(arg1, arg2, arg4, arg5);
        if (v0 == 0) {
            quote<T0, T1>(arg0, arg1, arg3, arg4);
            return
        };
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg3);
        let v1 = 0;
        while (v1 < 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::count(arg0)) {
            let v2 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::input(arg0, v1);
            let v3 = if (v2 == 0) {
                0
            } else if (arg3) {
                let v4 = sell_qty<T0, T1>(arg1, arg2, v2, arg4, arg5);
                if (v4 == 0) {
                    let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v2, arg4);
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T0>(arg0, v1, v5);
                    v6
                } else {
                    let (v8, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, v4, 0, arg4);
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T0>(arg0, v1, v2 - v4 + v8);
                    v9 - mul_up(v9, v0)
                }
            } else {
                let v11 = buy_qty<T0, T1>(arg1, arg2, v2, arg4, arg5);
                if (v11 == 0) {
                    let (v12, v13, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v2, arg4);
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T1>(arg0, v1, v13);
                    v12
                } else {
                    let (_, v16, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0, v2, arg4);
                    0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::first_input_change<T1>(arg0, v1, v16);
                    v11 - mul_up(v11, v0)
                }
            };
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::output(arg0, v1, v3);
            v1 = v1 + 1;
        };
    }

    public fun quote_embedded<T0, T1>(arg0: &mut 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::deactivate(arg0);
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::embedded_inner(arg0);
        quote<T0, T1>(v0, arg1, arg2, arg3);
    }

    fun sell_qty<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        if (bm_fee<T0, T1>(arg0, arg1, arg3, arg4) == 0) {
            return 0
        };
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = arg2 - arg2 % v1;
        if (v3 < v2) {
            0
        } else {
            v3
        }
    }

    public fun start_a2b<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T0>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T0>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, v0, arg3);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, v2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = Ticket<T0>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v3),
            principal : v0,
            change    : 0x2::coin::into_balance<T0>(v4),
        };
        (0x2::coin::into_balance<T1>(v5), v7)
    }

    public fun start_a2b_bm<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T0>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T0>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let v2 = sell_qty<T0, T1>(arg1, arg2, v0, arg3, arg4);
        let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, v0, arg4);
        if (v2 == 0) {
            let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, v3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            let v8 = Ticket<T0>{
                plan      : arg0,
                loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4),
                principal : v0,
                change    : 0x2::coin::into_balance<T0>(v5),
            };
            return (0x2::coin::into_balance<T1>(v6), v8)
        };
        let (v9, v10) = bm_sell<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v3), v2, arg3, arg4);
        let v11 = Ticket<T0>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4),
            principal : v0,
            change    : v10,
        };
        (v9, v11)
    }

    public fun start_a2b_embedded<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, EmbeddedTicket<T0>) {
        let (v0, v1) = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::unpack_embedded(arg0);
        let (v2, v3) = start_a2b<T0, T1>(v0, arg1, arg2, arg3);
        let v4 = EmbeddedTicket<T0>{
            inner    : v3,
            settings : v1,
        };
        (v2, v4)
    }

    public fun start_b2a<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T1>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T1>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T1>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, v0, arg3);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, v2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = Ticket<T1>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v3),
            principal : v0,
            change    : 0x2::coin::into_balance<T1>(v5),
        };
        (0x2::coin::into_balance<T0>(v4), v7)
    }

    public fun start_b2a_bm<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T1>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T1>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T1>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let v2 = buy_qty<T0, T1>(arg1, arg2, v0, arg3, arg4);
        let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, v0, arg4);
        if (v2 == 0) {
            let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, v3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            let v8 = Ticket<T1>{
                plan      : arg0,
                loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4),
                principal : v0,
                change    : 0x2::coin::into_balance<T1>(v6),
            };
            return (0x2::coin::into_balance<T0>(v5), v8)
        };
        let (v9, v10) = bm_buy<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v3), v2, arg3, arg4);
        let v11 = Ticket<T1>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4),
            principal : v0,
            change    : v10,
        };
        (v9, v11)
    }

    public fun start_b2a_embedded<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, EmbeddedTicket<T1>) {
        let (v0, v1) = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::unpack_embedded(arg0);
        let (v2, v3) = start_b2a<T0, T1>(v0, arg1, arg2, arg3);
        let v4 = EmbeddedTicket<T1>{
            inner    : v3,
            settings : v1,
        };
        (v2, v4)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T0>(0x2::coin::into_balance<T0>(v0), arg3);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun swap_a2b_bm<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v1 = sell_qty<T0, T1>(arg0, arg1, v0, arg3, arg4);
        if (v1 == 0) {
            return swap_a2b<T0, T1>(arg0, arg2, arg3, arg4)
        };
        let (v2, v3) = bm_sell<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T0>(v3, arg4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T1>(0x2::coin::into_balance<T1>(v1), arg3);
        0x2::coin::into_balance<T0>(v0)
    }

    public fun swap_b2a_bm<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v1 = buy_qty<T0, T1>(arg0, arg1, v0, arg3, arg4);
        if (v1 == 0) {
            return swap_b2a<T0, T1>(arg0, arg2, arg3, arg4)
        };
        let (v2, v3) = bm_buy<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::bank<T1>(v3, arg4);
        v2
    }

    // decompiled from Move bytecode v7
}

