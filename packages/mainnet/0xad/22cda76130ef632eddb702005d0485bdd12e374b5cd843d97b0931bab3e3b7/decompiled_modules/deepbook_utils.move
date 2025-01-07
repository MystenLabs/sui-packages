module 0xad22cda76130ef632eddb702005d0485bdd12e374b5cd843d97b0931bab3e3b7::deepbook_utils {
    struct PlaceLimitOrderEvent has copy, drop, store {
        is_bid: bool,
        base_filled: u64,
        quote_filled: u64,
        maker_injected: bool,
        maker_order_id: u64,
    }

    struct PlaceMarktetOrderEvent has copy, drop, store {
        is_bid: bool,
        base_input: u64,
        quote_input: u64,
        base_output: u64,
        quote_output: u64,
    }

    public fun place_limit_order<T0, T1>(arg0: &0xdee9::custodian_v2::AccountCap, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, 1107, arg2, arg3, 0, arg4, arg5, arg6, arg7, arg0, arg8);
        let v4 = PlaceLimitOrderEvent{
            is_bid         : arg4,
            base_filled    : v0,
            quote_filled   : v1,
            maker_injected : v2,
            maker_order_id : v3,
        };
        0x2::event::emit<PlaceLimitOrderEvent>(v4);
    }

    public fun place_market_order<T0, T1>(arg0: &0xdee9::custodian_v2::AccountCap, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, arg0, 1107, arg4, arg5, arg2, arg3, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        send_or_destory_coin<T0>(v3, arg7);
        send_or_destory_coin<T1>(v2, arg7);
        let v4 = PlaceMarktetOrderEvent{
            is_bid       : arg5,
            base_input   : 0x2::coin::value<T0>(&arg2),
            quote_input  : 0x2::coin::value<T1>(&arg3),
            base_output  : 0x2::coin::value<T0>(&v3),
            quote_output : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v4);
    }

    public fun create_deposit_then_place_limit_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee9::clob_v2::create_account(arg9);
        if (arg5) {
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg2, &v0);
            send_or_destory_coin<T0>(arg1, arg9);
        } else {
            0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg1, &v0);
            send_or_destory_coin<T1>(arg2, arg9);
        };
        let (v1, v2, v3, v4) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 1107, arg3, arg4, 0, arg5, arg6, arg7, arg8, &v0, arg9);
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(v0, 0x2::tx_context::sender(arg9));
        let v5 = PlaceLimitOrderEvent{
            is_bid         : arg5,
            base_filled    : v1,
            quote_filled   : v2,
            maker_injected : v3,
            maker_order_id : v4,
        };
        0x2::event::emit<PlaceLimitOrderEvent>(v5);
    }

    public fun create_then_place_market_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee9::clob_v2::create_account(arg6);
        let (v1, v2) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, &v0, 1107, arg3, arg4, arg1, arg2, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(v0, 0x2::tx_context::sender(arg6));
        send_or_destory_coin<T0>(v4, arg6);
        send_or_destory_coin<T1>(v3, arg6);
        let v5 = PlaceMarktetOrderEvent{
            is_bid       : arg4,
            base_input   : 0x2::coin::value<T0>(&arg1),
            quote_input  : 0x2::coin::value<T1>(&arg2),
            base_output  : 0x2::coin::value<T0>(&v4),
            quote_output : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v5);
    }

    public fun deposit_then_place_limit_order<T0, T1>(arg0: &0xdee9::custodian_v2::AccountCap, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, arg3, arg0);
            send_or_destory_coin<T0>(arg2, arg10);
        } else {
            0xdee9::clob_v2::deposit_base<T0, T1>(arg1, arg2, arg0);
            send_or_destory_coin<T1>(arg3, arg10);
        };
        let (v0, v1, v2, v3) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, 1107, arg4, arg5, 0, arg6, arg7, arg8, arg9, arg0, arg10);
        let v4 = PlaceLimitOrderEvent{
            is_bid         : arg6,
            base_filled    : v0,
            quote_filled   : v1,
            maker_injected : v2,
            maker_order_id : v3,
        };
        0x2::event::emit<PlaceLimitOrderEvent>(v4);
    }

    public fun send_or_destory_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

