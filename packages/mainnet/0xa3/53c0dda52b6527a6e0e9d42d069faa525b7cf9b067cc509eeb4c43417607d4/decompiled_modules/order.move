module 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::order {
    struct OrderRequest<phantom T0> has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        owner: address,
        requester: address,
        market_id: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        margin: u64,
        leverage: u64,
        position_id: u64,
        acceptable_price_wad: u128,
        min_factor_bps: u64,
        max_fee_bps: u64,
        builder_id: 0x1::option::Option<u32>,
        escrow: 0x2::balance::Balance<T0>,
        exec_fee: 0x2::balance::Balance<T0>,
        requested_ms: u64,
        fill_deadline_ms: u64,
        cancel_after_ms: u64,
        emergency_after_ms: u64,
    }

    struct Refund has copy, drop {
        order_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_delegate<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
    }

    public fun owner<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.owner
    }

    public fun emergency_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.emergency_after_ms
    }

    public fun fill_deadline_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.fill_deadline_ms
    }

    public fun market_id<T0>(arg0: &OrderRequest<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun acceptable_price_wad<T0>(arg0: &OrderRequest<T0>) : u128 {
        arg0.acceptable_price_wad
    }

    public fun account_id<T0>(arg0: &OrderRequest<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    fun assert_fill<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg3: &OrderRequest<T0>, arg4: &0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::assert_version<T0>(arg0);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13835061061759270913);
        assert!(arg3.account_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg1), 13835624016007921669);
        assert!(arg3.market_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg0), 13835905495279730695);
        assert!(0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::market_id(arg4) == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg0), 13835905499574697991);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3.fill_deadline_ms, 13837031403777032207);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(arg4);
        assert!(v0 > arg3.requested_ms, 13836468462413283339);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::order_params<T0>(arg0);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::fill_price_in_window(v0, arg3.requested_ms, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::fill_window_ms(&v1)), 13836749945980059661);
    }

    fun assert_request_prelude<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg3);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_version<T0>(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::assert_version<T0>(arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::assert_exchange<T0>(arg1, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>>(arg0));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_version<T0>(arg2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_exchange<T0>(arg2, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>>(arg0));
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::pending_orders<T0>(arg2) < 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::max_pending_orders(arg3), 13838156483345645591);
    }

    public fun cancel<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_cap<T0>(arg1, arg2);
        cancel_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun cancel_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.cancel_after_ms
    }

    public fun cancel_as_delegate<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_delegate<T0>(arg1, arg4, arg5);
        cancel_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun cancel_inner<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.account_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg1), 13835624093317332997);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg3.cancel_after_ms, 13837312947473350673);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg2));
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, arg5);
        emit_final(&v0, v1, arg3.kind, 2, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    fun create<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: 0x1::option::Option<u32>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg3));
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::order_params<T0>(arg1);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::exec_fee(&v1);
        let v3 = 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2);
        assert!((0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::free_balance<T0>(arg0, v3) as u128) >= (arg6 as u128) + (v2 as u128), 13839001290528260125);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::debit_account_free<T0>(&v0, arg0, v3, arg6 + v2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_identity<T0>(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::inc_pending_orders<T0>(&v0, arg2);
        let v4 = 0x2::clock::timestamp_ms(arg13);
        let v5 = if (arg4 == 0 || 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::emergency_after_ms(&v1) == 18446744073709551615) {
            18446744073709551615
        } else {
            v4 + 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::emergency_after_ms(&v1)
        };
        let v6 = OrderRequest<T0>{
            id                   : 0x2::object::new(arg14),
            account_id           : v3,
            owner                : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::owner<T0>(arg2),
            requester            : 0x2::tx_context::sender(arg14),
            market_id            : 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg1),
            kind                 : arg4,
            is_long              : arg5,
            margin               : arg6,
            leverage             : arg7,
            position_id          : arg8,
            acceptable_price_wad : arg9,
            min_factor_bps       : arg10,
            max_fee_bps          : arg11,
            builder_id           : arg12,
            escrow               : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::split_balance<T0>(&v0, arg0, arg6),
            exec_fee             : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::split_balance<T0>(&v0, arg0, v2),
            requested_ms         : v4,
            fill_deadline_ms     : v4 + 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::fill_deadline_ms(&v1),
            cancel_after_ms      : v4 + 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::cancel_delay_ms(&v1),
            emergency_after_ms   : v5,
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_order_requested_event(&v0, 0x2::object::id<OrderRequest<T0>>(&v6), v3, v6.owner, v6.requester, v6.market_id, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v2, v4, v6.fill_deadline_ms, v6.cancel_after_ms, v5);
        v6
    }

    fun deposit_top_up<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap, arg3: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::deposit<T0>(arg0, arg1, arg2, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
    }

    public fun emergency_close<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap, arg4: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg5: OrderRequest<T0>, arg6: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_cap<T0>(arg2, arg3);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun emergency_close_as_delegate<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket {
        assert_delegate<T0>(arg2, arg6, arg7);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emergency_close_inner<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket {
        assert!(arg4.kind == 1, 13836187124875395081);
        assert!(arg4.account_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2), 13835624179216678917);
        assert!(arg4.market_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg1), 13835905658488487943);
        assert!(arg4.emergency_after_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg6) >= arg4.emergency_after_ms, 13837875987621347349);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5);
        assert!(v0 > arg4.emergency_after_ms, 13837876004801216533);
        let v1 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg3));
        let v2 = arg4.position_id;
        let (v3, v4) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, arg7);
        emit_final(&v1, v3, 1, 11, v2, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::price_wad(&arg5), v0, v4, arg6, arg7);
        0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v2, arg5, arg4.acceptable_price_wad, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::mode_one_step(), arg6, arg7)
    }

    fun emit_final(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: Refund, arg2: u8, arg3: u8, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            0
        } else {
            arg1.amount
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_order_finalized_event(arg0, arg1.order_id, arg1.account_id, arg1.owner, arg1.market_id, arg2, arg3, arg4, arg5, arg6, v0, arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
    }

    public fun escrow_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun exec_fee_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.exec_fee)
    }

    public fun expire<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.account_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg1), 13835622886431522821);
        assert!(0x2::clock::timestamp_ms(arg4) > expires_after_ms<T0>(&arg3), 13837593215564382227);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg2));
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, arg5);
        emit_final(&v0, v1, arg3.kind, 3, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    public fun expires_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        if (arg0.kind == 0 || arg0.emergency_after_ms == 18446744073709551615) {
            arg0.fill_deadline_ms
        } else {
            arg0.emergency_after_ms + arg0.fill_deadline_ms - arg0.requested_ms
        }
    }

    public fun fill_close<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u8, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket, 0x2::coin::Coin<T0>) {
        assert!(arg4.kind == 1, 13836185445543182345);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg3));
        while (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::liq_book::pending_count(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::liq<T0>(arg1), 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2)) > 0) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::reconcile_inner<T0>(&v0, arg1, arg2);
        };
        let v1 = 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2);
        let v2 = arg4.position_id;
        let v3 = arg4.acceptable_price_wad;
        let v4 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::price_wad(&arg5);
        let (v5, v6) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, arg7);
        if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::has_position<T0>(arg2, v2)) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::discard_price(arg5);
            emit_final(&v0, v5, 1, 10, v2, v4, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
            return (10, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::ticket(0, v1), 0x2::coin::zero<T0>(arg7))
        };
        let v7 = if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::closes_paused(arg3) || 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::closes_paused<T0>(arg1)) {
            5
        } else if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            0
        };
        if (v7 != 0) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::discard_price(arg5);
            emit_final(&v0, v5, 1, v7, v2, v4, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
            return (v7, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::ticket(0, v1), 0x2::coin::zero<T0>(arg7))
        };
        if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::is_closed(&arg5) && 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::liquidatable_receipt<T0>(arg1, v2, &arg5)) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::reconcile_inner<T0>(&v0, arg1, arg2);
            emit_final(&v0, v5, 1, 1, v2, v4, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
            return (1, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::ticket(0, v1), 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::liquidate_receipt_mode<T0>(arg0, arg1, arg3, v2, arg5, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::mode_two_step(), arg7))
        };
        let v8 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::status<T0>(arg1);
        let v9 = if (0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::is_closed(&arg5)) {
            true
        } else {
            let v10 = v8 == 1 || v8 == 2;
            !v10
        };
        let v11 = if (v9) {
            7
        } else if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::in_band(&arg5)) {
            assert!(0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::conf_timestamp_ms(&arg5) > arg4.requested_ms, 13836467173923094539);
            12
        } else if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::exit_within(arg4.is_long, v4, v3)) {
            4
        } else {
            0
        };
        if (v11 != 0) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::discard_price(arg5);
            emit_final(&v0, v5, 1, v11, v2, v4, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
            return (v11, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::ticket(0, v1), 0x2::coin::zero<T0>(arg7))
        };
        0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::discard_zero_loss(0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::ticket(0, v1));
        emit_final(&v0, v5, 1, 0, v2, v4, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
        (0, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v2, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::to_mid(arg5), v3, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::mode_two_step(), arg6, arg7), 0x2::coin::zero<T0>(arg7))
    }

    public fun fill_open<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u8 {
        assert!(arg4.kind == 0, 13836185144895471625);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg3));
        while (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::liq_book::pending_count(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::liq<T0>(arg1), 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2)) > 0) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::reconcile_inner<T0>(&v0, arg1, arg2);
        };
        let v1 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::to_mid(arg5);
        let v2 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::price_wad(&v1);
        let v3 = arg4.is_long;
        let v4 = arg4.margin;
        let v5 = arg4.leverage;
        let v6 = arg4.acceptable_price_wad;
        let v7 = if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::is_paused(arg3) || 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::opens_paused<T0>(arg1)) {
            5
        } else if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            let v8 = if (0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::is_closed(&v1)) {
                true
            } else if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::status<T0>(arg1) != 1) {
                true
            } else {
                !0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::enabled<T0>(arg1)
            };
            if (v8) {
                7
            } else if (0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::taker_bps<T0>(arg1, arg3) > arg4.max_fee_bps) {
                8
            } else if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::entry_within(v3, v2, v6)) {
                4
            } else if (0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::open_risk_code<T0>(arg1, arg3, v4, v5) != 0) {
                9
            } else if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::account_notional_ok<T0>(arg0, arg1, arg2, arg3, v4, v5)) {
                9
            } else if (!0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::tx_notional_ok<T0>(arg0, arg1, arg2, arg3, v4, v5)) {
                9
            } else {
                0
            }
        };
        let (v9, v10) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, arg7);
        if (v7 != 0) {
            0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::discard_price(v1);
            emit_final(&v0, v9, 0, v7, 0, v2, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&v1), v10, arg6, arg7);
            return v7
        };
        emit_final(&v0, v9, 0, 0, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::open_inner<T0>(arg0, arg1, arg2, arg3, v1, v4, v5, v3, false, arg4.min_factor_bps, v6, arg4.builder_id, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::mode_two_step(), arg6, arg7), v2, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle::timestamp_ms(&v1), v10, arg6, arg7);
        0
    }

    fun finalize<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: OrderRequest<T0>, arg5: &mut 0x2::tx_context::TxContext) : (Refund, u64) {
        let OrderRequest {
            id                   : v0,
            account_id           : v1,
            owner                : v2,
            requester            : _,
            market_id            : v4,
            kind                 : v5,
            is_long              : _,
            margin               : _,
            leverage             : _,
            position_id          : v9,
            acceptable_price_wad : _,
            min_factor_bps       : _,
            max_fee_bps          : _,
            builder_id           : _,
            escrow               : v14,
            exec_fee             : v15,
            requested_ms         : _,
            fill_deadline_ms     : _,
            cancel_after_ms      : _,
            emergency_after_ms   : _,
        } = arg4;
        let v20 = v15;
        let v21 = v14;
        let v22 = v0;
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg3);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_version<T0>(arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_version<T0>(arg2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_exchange<T0>(arg2, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>>(arg1));
        0x2::object::delete(v22);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::dec_pending_orders<T0>(arg0, arg2);
        if (v5 == 1) {
            0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::remove_pending_close<T0>(arg0, arg2, v9);
        };
        let v23 = 0x2::balance::value<T0>(&v21);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::join_in<T0>(arg0, arg1, v21);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::credit_account_free<T0>(arg0, arg1, v1, v23);
        let v24 = 0x2::balance::value<T0>(&v20);
        if (v24 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg5), 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::exec_fee_recipient(arg3));
        } else {
            0x2::balance::destroy_zero<T0>(v20);
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_identity<T0>(arg1);
        let v25 = Refund{
            order_id   : 0x2::object::uid_to_inner(&v22),
            account_id : v1,
            owner      : v2,
            market_id  : v4,
            amount     : v23,
        };
        (v25, v24)
    }

    public fun is_long<T0>(arg0: &OrderRequest<T0>) : bool {
        arg0.is_long
    }

    public fun kind<T0>(arg0: &OrderRequest<T0>) : u8 {
        arg0.kind
    }

    public fun kind_close() : u8 {
        1
    }

    public fun kind_open() : u8 {
        0
    }

    public fun leverage<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.leverage
    }

    public fun margin<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.margin
    }

    public fun max_fee_bps<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.max_fee_bps
    }

    public fun outcome_cancelled() : u8 {
        2
    }

    public fun outcome_emergency_closed() : u8 {
        11
    }

    public fun outcome_expired() : u8 {
        3
    }

    public fun outcome_filled() : u8 {
        0
    }

    public fun outcome_liquidated() : u8 {
        1
    }

    public fun outcome_refund_band() : u8 {
        12
    }

    public fun outcome_refund_closed() : u8 {
        7
    }

    public fun outcome_refund_fee() : u8 {
        8
    }

    public fun outcome_refund_killed() : u8 {
        6
    }

    public fun outcome_refund_paused() : u8 {
        5
    }

    public fun outcome_refund_price() : u8 {
        4
    }

    public fun outcome_refund_risk() : u8 {
        9
    }

    public fun outcome_void() : u8 {
        10
    }

    public fun position_id<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.position_id
    }

    public fun request_close<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap, arg4: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg8, arg9))
    }

    public fun request_close_as_delegate<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg6, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun request_close_inner<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::status<T0>(arg1);
        let v1 = if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::closes_paused(arg3)) {
            if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::closes_paused<T0>(arg1)) {
                if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::oracle_killed<T0>(arg1)) {
                    v0 == 1 || v0 == 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13839282598001377311);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::has_position<T0>(arg2, arg4), 13839564081568153633);
        let (v2, v3, v4) = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::position_summary<T0>(arg2, arg4);
        assert!(v2 == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg1), 13839564090158088225);
        assert!(!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::liq_book::is_pending(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::liq<T0>(arg1), 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2), arg4), 13839564103042990113);
        let v5 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::timing<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg6) >= v4 + 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::min_hold_ms(&v5), 13839845582314799139);
        assert!(!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::has_pending_close<T0>(arg2, arg4), 13838438211725557785);
        let v6 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg3));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::add_pending_close<T0>(&v6, arg2, arg4);
        create<T0>(arg0, arg1, arg2, arg3, 1, v3, 0, 0, arg4, arg5, 0, 0, 0x1::option::none<u32>(), arg6, arg7)
    }

    public fun request_open<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap, arg4: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13))
    }

    public fun request_open_as_delegate<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg10, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11))
    }

    fun request_open_inner<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::is_paused(arg3)) {
            if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::opens_paused<T0>(arg1)) {
                if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::enabled<T0>(arg1)) {
                    if (!0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::oracle_killed<T0>(arg1)) {
                        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::status<T0>(arg1) == 1
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13839282473447325727);
        assert!(0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::open_risk_code<T0>(arg1, arg3, arg4, arg5) != 4, 13840408381944496165);
        0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::assert_open_risk<T0>(arg1, arg3, arg4, arg5);
        assert!(arg8 != 0, 13838719540673511451);
        let (_, _) = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::builder::snapshot<T0>(arg0, arg3, arg9);
        create<T0>(arg0, arg1, arg2, arg3, 0, arg6, arg4, arg5, 0, arg8, arg7, 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::trade::taker_bps<T0>(arg1, arg3), arg9, arg10, arg11)
    }

    public fun requested_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.requested_ms
    }

    public fun requester<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.requester
    }

    fun share<T0>(arg0: OrderRequest<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<OrderRequest<T0>>(arg0);
        0x2::object::id<OrderRequest<T0>>(&arg0)
    }

    // decompiled from Move bytecode v7
}

