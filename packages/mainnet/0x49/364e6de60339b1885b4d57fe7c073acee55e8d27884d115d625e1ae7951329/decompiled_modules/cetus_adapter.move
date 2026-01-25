module 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_adapter {
    struct CetusPriceData has copy, drop {
        sqrt_price: u128,
        mid_price: u64,
        fee_rate: u64,
        effective_bid: u64,
        effective_ask: u64,
    }

    public fun apply_fee(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            arg0 - arg0 * arg1 / 1000000
        } else {
            arg0 + arg0 * arg1 / 1000000
        }
    }

    public fun flash_swap_buy<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, true, false, arg3, 79226673515401279992447579055, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<T0>(&v5);
        assert!(v6 <= arg4, 1001);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), arg6);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v6, arg6);
        0x2::coin::join<T0>(&mut v7, 0x2::coin::from_balance<T0>(v5, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::coin::into_balance<T0>(v7), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        (v6, 0x2::balance::value<0x2::sui::SUI>(&v4))
    }

    public fun flash_swap_buy_with_event<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        let v0 = arg4 * arg5 / 1000000000 * (10000 + arg6) / 10000;
        let (v1, v2) = flash_swap_buy<T0>(arg1, arg2, arg3, arg4, v0, arg7, arg8);
        let v3 = if (v2 > 0) {
            v1 * 1000000000 / v2
        } else {
            0
        };
        let v4 = if (v3 > arg5) {
            (v3 - arg5) * 10000 / arg5
        } else {
            0
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_venue_swap(0, arg0, 0x2::clock::timestamp_ms(arg7), 0, v1, v2, arg5, v3, v4, v1 * get_fee_rate<T0, 0x2::sui::SUI>(arg2) / 1000000, v0, 0, v4 > arg6);
        (v1, v2, true)
    }

    public fun flash_swap_sell<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, false, true, arg3, 4295048016, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v7 = 0x2::balance::value<T0>(&v5);
        assert!(v7 >= arg4, 1002);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::from_balance<T0>(v5, arg6), arg6);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, v6, arg6);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(v8), v3);
        (v6, v7)
    }

    public fun flash_swap_sell_with_event<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        let v0 = arg4 * arg5 / 1000000000 * (10000 - arg6) / 10000;
        let (v1, v2) = flash_swap_sell<T0>(arg1, arg2, arg3, arg4, v0, arg7, arg8);
        let v3 = if (v1 > 0) {
            v2 * 1000000000 / v1
        } else {
            0
        };
        let v4 = if (arg5 > v3) {
            (arg5 - v3) * 10000 / arg5
        } else {
            0
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_venue_swap(0, arg0, 0x2::clock::timestamp_ms(arg7), 1, v1, v2, arg5, v3, v4, v1 * get_fee_rate<T0, 0x2::sui::SUI>(arg2) / 1000000, 0, v0, v4 > arg6);
        (v1, v2, true)
    }

    public fun get_fee_rate<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)
    }

    public fun get_price_data<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : CetusPriceData {
        let v0 = get_sqrt_price<T0, T1>(arg0);
        let v1 = get_fee_rate<T0, T1>(arg0);
        let v2 = sqrt_price_to_price(v0);
        CetusPriceData{
            sqrt_price    : v0,
            mid_price     : v2,
            fee_rate      : v1,
            effective_bid : apply_fee(v2, v1, true),
            effective_ask : apply_fee(v2, v1, false),
        }
    }

    public fun get_price_range_with_fees<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = get_price_data<T0, T1>(arg0);
        (v0.effective_bid, v0.effective_ask)
    }

    public fun get_sqrt_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
    }

    public fun is_inverse_price() : bool {
        true
    }

    public fun price_data_effective_ask(arg0: &CetusPriceData) : u64 {
        arg0.effective_ask
    }

    public fun price_data_effective_bid(arg0: &CetusPriceData) : u64 {
        arg0.effective_bid
    }

    public fun price_data_fee_rate(arg0: &CetusPriceData) : u64 {
        arg0.fee_rate
    }

    public fun price_data_mid_price(arg0: &CetusPriceData) : u64 {
        arg0.mid_price
    }

    public fun price_data_sqrt_price(arg0: &CetusPriceData) : u128 {
        arg0.sqrt_price
    }

    public fun read_price_with_event<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x2::clock::Clock) {
        let v0 = get_sqrt_price<T0, 0x2::sui::SUI>(arg0);
        let v1 = get_fee_rate<T0, 0x2::sui::SUI>(arg0);
        let v2 = sqrt_price_to_price(v0);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_venue_price_read(0, b"Cetus", 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg0), 0x2::clock::timestamp_ms(arg1), v0, is_inverse_price(), v2, v1, apply_fee(v2, v1, true), apply_fee(v2, v1, false));
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        ((340282366920938463463374607431768211456000000000 / v0 / v0) as u64)
    }

    public fun supports_lp() : bool {
        true
    }

    public fun venue_id() : u8 {
        0
    }

    public fun venue_name() : vector<u8> {
        b"Cetus"
    }

    // decompiled from Move bytecode v6
}

