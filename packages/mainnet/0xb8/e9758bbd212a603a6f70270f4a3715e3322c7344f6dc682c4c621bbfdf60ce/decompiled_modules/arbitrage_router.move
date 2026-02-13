module 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::arbitrage_router {
    struct PricePoint has copy, drop {
        price: u64,
        pool_type: u8,
        fee_rate: u64,
    }

    struct VenueAnalysis has copy, drop {
        pool_type: u8,
        bid_price: u64,
        ask_price: u64,
        raw_price: u64,
        fee_rate: u64,
        is_available: bool,
    }

    struct IOCOrderResult has copy, drop {
        order_id: u128,
        filled_quantity: u64,
        unfilled_quantity: u64,
        success: bool,
    }

    public fun analyze_bluefin() : VenueAnalysis {
        let (v0, v1) = 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::bluefin_adapter::get_disabled_price_data();
        VenueAnalysis{
            pool_type    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::bluefin_adapter::venue_id(),
            bid_price    : v0,
            ask_price    : v1,
            raw_price    : 0,
            fee_rate     : 0,
            is_available : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::bluefin_adapter::is_enabled(),
        }
    }

    public fun analyze_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : VenueAnalysis {
        let v0 = 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::get_price_data<T0, T1>(arg0);
        VenueAnalysis{
            pool_type    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::venue_id(),
            bid_price    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_effective_bid(&v0),
            ask_price    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_effective_ask(&v0),
            raw_price    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_mid_price(&v0),
            fee_rate     : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_fee_rate(&v0),
            is_available : true,
        }
    }

    public fun analyze_mmt() : VenueAnalysis {
        let (v0, v1) = 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::mmt_adapter::get_disabled_price_data();
        VenueAnalysis{
            pool_type    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::mmt_adapter::venue_id(),
            bid_price    : v0,
            ask_price    : v1,
            raw_price    : 0,
            fee_rate     : 0,
            is_available : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::mmt_adapter::is_enabled(),
        }
    }

    public fun analyze_opportunities(arg0: u64, arg1: &VenueAnalysis, arg2: &VenueAnalysis, arg3: &VenueAnalysis, arg4: &VenueAnalysis, arg5: u64) : (u8, u64, u64, u8, u64, u64, bool, bool) {
        let v0 = 255;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        if (arg1.is_available && arg1.ask_price > 0) {
            let v4 = calculate_buy_profit_bps(arg1.ask_price, arg0);
            if (v4 > v2) {
                v0 = 0;
                v1 = arg1.ask_price;
                v3 = v4;
            };
        };
        let v5 = 255;
        let v6 = 0;
        let v7 = 0;
        let v8 = v7;
        if (arg1.is_available && arg1.bid_price > 0) {
            let v9 = calculate_sell_profit_bps(arg1.bid_price, arg0);
            if (v9 > v7) {
                v5 = 0;
                v6 = arg1.bid_price;
                v8 = v9;
            };
        };
        (v0, v1, v3, v5, v6, v8, v3 >= arg5, v8 >= arg5)
    }

    public fun analyze_turbos() : VenueAnalysis {
        let (v0, v1) = 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::turbos_adapter::get_disabled_price_data();
        VenueAnalysis{
            pool_type    : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::turbos_adapter::venue_id(),
            bid_price    : v0,
            ask_price    : v1,
            raw_price    : 0,
            fee_rate     : 0,
            is_available : 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::turbos_adapter::is_enabled(),
        }
    }

    public fun apply_fee(arg0: u64, arg1: u64, arg2: bool) : u64 {
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::apply_fee(arg0, arg1, arg2)
    }

    public fun calculate_buy_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            0
        } else {
            (arg1 - arg0) * 10000 / arg1
        }
    }

    public fun calculate_sell_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            0
        } else {
            (arg0 - arg1) * 10000 / arg1
        }
    }

    public fun disabled_venue(arg0: u8) : VenueAnalysis {
        VenueAnalysis{
            pool_type    : arg0,
            bid_price    : 0,
            ask_price    : 0,
            raw_price    : 0,
            fee_rate     : 0,
            is_available : false,
        }
    }

    public fun execute_arbitrage_analysis<T0>(arg0: 0x2::object::ID, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (bool, bool, u8, u64, u8, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (v0 < arg4 + arg5) {
            return (false, false, 255, 0, 255, 0)
        };
        let v1 = analyze_cetus<T0, 0x2::sui::SUI>(arg1);
        let v2 = analyze_turbos();
        let v3 = analyze_bluefin();
        let v4 = analyze_mmt();
        let (v5, v6, v7, v8, v9, v10, v11, v12) = analyze_opportunities(arg2, &v1, &v2, &v3, &v4, arg3);
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::events::emit_arbitrage_opportunity(arg0, v0, arg2, v1.bid_price, v1.ask_price, v2.bid_price, v2.ask_price, v3.bid_price, v3.ask_price, v4.bid_price, v4.ask_price, v5, v6, v7, v8, v9, v10, arg3, v11, v12);
        (v11, v12, v5, v6, v8, v9)
    }

    public fun execute_cetus_buy<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg2, true, false, arg4, 79226673515401279992447579055, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v8 = v6 <= arg4 * arg5 / 1000000000 * (10000 + arg7) / 10000;
        let v9 = if (v8) {
            0
        } else {
            3
        };
        let v10 = if (v7 > 0) {
            v6 * 1000000000 / v7
        } else {
            0
        };
        let v11 = if (v10 > arg5) {
            (v10 - arg5) * 10000 / arg5
        } else {
            0
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9), arg9);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v6, arg9);
        0x2::coin::join<T0>(&mut v12, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg2, 0x2::coin::into_balance<T0>(v12), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::events::emit_arbitrage_execution(arg0, 0x2::clock::timestamp_ms(arg8), 0, 0, v7, v6, arg5, v10, arg6, calculate_buy_profit_bps(arg5, arg6), calculate_buy_profit_bps(v10, arg6), v11, v6 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, 0x2::sui::SUI>(arg2) / 1000000, v8, v9);
        (v6, v7, v8)
    }

    public fun execute_cetus_sell<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg2, false, true, arg4, 4295048016, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = v7 >= arg4 * arg5 / 1000000000 * (10000 - arg7) / 10000;
        let v9 = if (v8) {
            0
        } else {
            3
        };
        let v10 = if (v6 > 0) {
            v7 * 1000000000 / v6
        } else {
            0
        };
        let v11 = if (arg5 > v10) {
            (arg5 - v10) * 10000 / arg5
        } else {
            0
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg9), arg9);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, v6, arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut v12, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(v12), v3);
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::events::emit_arbitrage_execution(arg0, 0x2::clock::timestamp_ms(arg8), 0, 1, v6, v7, arg5, v10, arg6, calculate_sell_profit_bps(arg5, arg6), calculate_sell_profit_bps(v10, arg6), v11, v6 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, 0x2::sui::SUI>(arg2) / 1000000, v8, v9);
        (v6, v7, v8)
    }

    public fun execute_deepbook_ioc<T0, T1>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: u64, arg5: u64, arg6: &0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::config::MMConfig, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (u64, bool) {
        let v0 = if (arg0) {
            place_ioc_buy<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::config::enable_deep_payment(arg6), arg7, arg8)
        } else {
            place_ioc_sell<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::config::enable_deep_payment(arg6), arg7, arg8)
        };
        let v1 = v0;
        (v1.filled_quantity, v1.success)
    }

    public fun ioc_filled_quantity(arg0: &IOCOrderResult) : u64 {
        arg0.filled_quantity
    }

    public fun ioc_order_id(arg0: &IOCOrderResult) : u128 {
        arg0.order_id
    }

    public fun ioc_success(arg0: &IOCOrderResult) : bool {
        arg0.success
    }

    public fun ioc_unfilled_quantity(arg0: &IOCOrderResult) : u64 {
        arg0.unfilled_quantity
    }

    public fun is_buy_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        calculate_buy_profit_bps(arg0, arg1) >= arg2
    }

    public fun is_sell_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        calculate_sell_profit_bps(arg0, arg1) >= arg2
    }

    public fun place_ioc_buy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : IOCOrderResult {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg4, true, arg5, v0 + 1000, arg6, arg7);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v1);
        let v4 = if (arg4 > v3) {
            arg4 - v3
        } else {
            0
        };
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::events::emit_ioc_order_result(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0), v2, true, arg3, arg4, v3, 0, v0);
        IOCOrderResult{
            order_id          : v2,
            filled_quantity   : v3,
            unfilled_quantity : v4,
            success           : v3 > 0,
        }
    }

    public fun place_ioc_sell<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : IOCOrderResult {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg4, false, arg5, v0 + 1000, arg6, arg7);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v1);
        let v4 = if (arg4 > v3) {
            arg4 - v3
        } else {
            0
        };
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::events::emit_ioc_order_result(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0), v2, false, arg3, arg4, v3, 0, v0);
        IOCOrderResult{
            order_id          : v2,
            filled_quantity   : v3,
            unfilled_quantity : v4,
            success           : v3 > 0,
        }
    }

    public fun pool_bluefin() : u8 {
        2
    }

    public fun pool_cetus() : u8 {
        0
    }

    public fun pool_mmt() : u8 {
        3
    }

    public fun pool_turbos() : u8 {
        1
    }

    public fun read_cetus_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::get_price_data<T0, T1>(arg0);
        (0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_mid_price(&v0), 0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::price_data_fee_rate(&v0))
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        0xb8e9758bbd212a603a6f70270f4a3715e3322c7344f6dc682c4c621bbfdf60ce::cetus_adapter::sqrt_price_to_price(arg0)
    }

    public fun venue_ask_price(arg0: &VenueAnalysis) : u64 {
        arg0.ask_price
    }

    public fun venue_bid_price(arg0: &VenueAnalysis) : u64 {
        arg0.bid_price
    }

    public fun venue_fee_rate(arg0: &VenueAnalysis) : u64 {
        arg0.fee_rate
    }

    public fun venue_is_available(arg0: &VenueAnalysis) : bool {
        arg0.is_available
    }

    public fun venue_pool_type(arg0: &VenueAnalysis) : u8 {
        arg0.pool_type
    }

    public fun venue_raw_price(arg0: &VenueAnalysis) : u64 {
        arg0.raw_price
    }

    // decompiled from Move bytecode v6
}

