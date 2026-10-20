module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::order {
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

    fun assert_delegate<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
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

    fun assert_fill<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &OrderRequest<T0>, arg4: &0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg0);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13835062053896716289);
        assert!(arg3.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg1), 13835625008145367045);
        assert!(arg3.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), 13835906487417176071);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(arg4) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), 13835906491712143367);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3.fill_deadline_ms, 13837032395914477583);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(arg4);
        assert!(v0 > arg3.requested_ms, 13836469454550728715);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::order_params<T0>(arg0);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::fill_price_in_window(v0, arg3.requested_ms, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::fill_window_ms(&v1)), 13836750938117505037);
        assert!(v0 <= 0x2::clock::timestamp_ms(arg5) + 0, 13842098966972203055);
    }

    fun assert_request_prelude<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
    }

    public fun cancel<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg1, arg2);
        cancel_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun cancel_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x1::u64::max(arg0.cancel_after_ms, arg0.requested_ms + 5000)
    }

    public fun cancel_as_delegate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_delegate<T0>(arg1, arg4, arg5);
        cancel_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun cancel_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg1);
        assert!(arg3.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg1), 13835625102634647557);
        assert!(0x2::clock::timestamp_ms(arg4) >= cancel_after_ms<T0>(&arg3), 13837313956790665233);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, false, arg5);
        emit_final(&v0, v1, arg3.kind, 2, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    fun create<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: 0x1::option::Option<u32>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::order_params<T0>(arg1);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::exec_fee(&v1);
        let v3 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        assert!((0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::free_balance<T0>(arg0, v3) as u128) >= (arg6 as u128) + (v2 as u128), 13839002282665574427);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_account_free<T0>(&v0, arg0, v3, arg6 + v2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::inc_pending_orders<T0>(&v0, arg2);
        let v4 = 0x2::clock::timestamp_ms(arg13);
        let v5 = if (arg4 == 0 || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::emergency_after_ms(&v1) == 18446744073709551615) {
            18446744073709551615
        } else {
            v4 + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::emergency_after_ms(&v1)
        };
        let v6 = OrderRequest<T0>{
            id                   : 0x2::object::new(arg14),
            account_id           : v3,
            owner                : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2),
            requester            : 0x2::tx_context::sender(arg14),
            market_id            : 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1),
            kind                 : arg4,
            is_long              : arg5,
            margin               : arg6,
            leverage             : arg7,
            position_id          : arg8,
            acceptable_price_wad : arg9,
            min_factor_bps       : arg10,
            max_fee_bps          : arg11,
            builder_id           : arg12,
            escrow               : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::split_balance<T0>(&v0, arg0, arg6),
            exec_fee             : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::split_balance<T0>(&v0, arg0, v2),
            requested_ms         : v4,
            fill_deadline_ms     : v4 + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::fill_deadline_ms(&v1),
            cancel_after_ms      : v4 + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::cancel_delay_ms(&v1),
            emergency_after_ms   : v5,
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_order_requested_event(&v0, 0x2::object::id<OrderRequest<T0>>(&v6), v3, v6.owner, v6.requester, v6.market_id, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v2, v4, v6.fill_deadline_ms, v6.cancel_after_ms, v5);
        v6
    }

    fun deposit_top_up<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::deposit<T0>(arg0, arg3, arg1, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    public fun emergency_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg5: OrderRequest<T0>, arg6: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg2, arg3);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun emergency_close_as_delegate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        assert_delegate<T0>(arg2, arg6, arg7);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emergency_close_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        assert!(arg4.kind == 1, 13836188134192709641);
        assert!(arg4.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), 13835625188533993477);
        assert!(arg4.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13835906667805802503);
        assert!(arg4.emergency_after_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg6) >= arg4.emergency_after_ms, 13837876996938661909);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_force_close());
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5);
        assert!(v0 > arg4.emergency_after_ms, 13837877018413498389);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let v2 = arg4.position_id;
        let (v3, v4) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        emit_final(&v1, v3, 1, 11, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), v0, v4, arg6, arg7);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v2, arg5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::no_price_bound(), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::mode_one_step(), arg6, arg7)
    }

    fun emit_final(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: Refund, arg2: u8, arg3: u8, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            0
        } else {
            arg1.amount
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_order_finalized_event(arg0, arg1.order_id, arg1.account_id, arg1.owner, arg1.market_id, arg2, arg3, arg4, arg5, arg6, v0, arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
    }

    public fun escrow_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun exec_fee_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.exec_fee)
    }

    public fun expire<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        expire_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>(), arg5, arg6);
    }

    fun expire_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0x1::option::Option<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        assert!(arg4.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), 13835623569331322885);
        assert!(arg4.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13835905048603131911);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert!(0x2::clock::timestamp_ms(arg6) > expires_after_ms<T0>(&arg4), 13837593907054116883);
        let v0 = 0;
        let v1 = if (0x1::option::is_some<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>(&arg5)) {
            let v2 = 0x1::option::destroy_some<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>(arg5);
            assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&v2) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13835905078667902983);
            let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&v2);
            v0 = v3;
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(v2);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::hours_mode<T0>(arg1) == 1 && v3 <= arg4.requested_ms
        } else {
            0x1::option::destroy_none<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>(arg5);
            assert!(!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::hours_mode<T0>(arg1) == 1), 13841534603974279211);
            false
        };
        let v4 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let (v5, v6) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, v1, arg7);
        if (v1) {
            emit_final(&v4, v5, arg4.kind, 13, arg4.position_id, 0, v0, v6, arg6, arg7);
        } else {
            emit_final(&v4, v5, arg4.kind, 3, arg4.position_id, 0, 0, v6, arg6, arg7);
        };
    }

    public fun expire_with_price<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        expire_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt>(arg5), arg6, arg7);
    }

    public fun expires_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        if (arg0.kind == 0 || arg0.emergency_after_ms == 18446744073709551615) {
            arg0.fill_deadline_ms
        } else {
            arg0.emergency_after_ms + arg0.fill_deadline_ms - arg0.requested_ms
        }
    }

    public fun fill_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u8, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket, 0x2::coin::Coin<T0>) {
        assert!(arg4.kind == 1, 13836185673176449033);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let v1 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg3) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg1)) {
            5
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg1)) {
            6
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liquidations_paused(arg3) && 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) > 0) {
            14
        } else {
            0
        };
        if (v1 != 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            let (v2, v3) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v2, 1, v1, arg4.position_id, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v3, arg6, arg7);
            return (v1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        while (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) > 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::reconcile_inner<T0>(&v0, arg1, arg2);
        };
        let v4 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        let v5 = arg4.position_id;
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::has_position<T0>(arg2, v5);
        let v7 = if (session_force_closed<T0>(arg1, v5)) {
            13
        } else {
            10
        };
        let v8 = v6 && 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1);
        let v9 = if (v6) {
            if (!v8) {
                if (!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg5)) {
                    0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::liquidatable_receipt<T0>(arg1, v5, &arg5)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v10 = v9 && 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liquidations_paused(arg3);
        let v11 = v6 && (v10 || v8) || v7 == 13;
        let (v12, v13) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, v11, arg7);
        if (!v6) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            emit_final(&v0, v12, 1, v7, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
            return (v7, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4), 0x2::coin::zero<T0>(arg7))
        };
        if (v10) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            emit_final(&v0, v12, 1, 14, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
            return (14, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4), 0x2::coin::zero<T0>(arg7))
        };
        if (v8) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            emit_final(&v0, v12, 1, 13, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
            return (13, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4), 0x2::coin::zero<T0>(arg7))
        };
        if (v9) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::reconcile_inner<T0>(&v0, arg1, arg2);
            emit_final(&v0, v12, 1, 1, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
            return (1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::liquidate_receipt_mode<T0>(arg0, arg1, arg3, v5, arg5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::mode_two_step(), arg7))
        };
        let v14 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1);
        let v15 = if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg5)) {
            true
        } else {
            let v16 = v14 == 1 || v14 == 2;
            !v16
        };
        let v17 = if (v15) {
            7
        } else if (!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg5)) {
            assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::conf_timestamp_ms(&arg5) > arg4.requested_ms, 13836467517520478219);
            12
        } else {
            0
        };
        if (v17 != 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            emit_final(&v0, v12, 1, v17, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
            return (v17, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4), 0x2::coin::zero<T0>(arg7))
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::discard_zero_loss(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, v4));
        emit_final(&v0, v12, 1, 0, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v13, arg6, arg7);
        (0, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::to_mid(arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::no_price_bound(), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::mode_two_step(), arg6, arg7), 0x2::coin::zero<T0>(arg7))
    }

    public fun fill_max_future_ms() : u64 {
        0
    }

    public fun fill_open<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u8 {
        assert!(arg4.kind == 0, 13836185282334425097);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let v1 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_paused(arg3)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::opens_paused<T0>(arg1)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg3)) {
            true
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg1)
        };
        let v2 = if (v1) {
            5
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg1)) {
            6
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1)) {
            13
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) > 0 && 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::reconcile_halted<T0>(arg1, arg3)) {
            14
        } else {
            0
        };
        if (v2 != 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
            let (v3, v4) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v3, 0, v2, arg4.position_id, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5), v4, arg6, arg7);
            return v2
        };
        while (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) > 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::reconcile_inner<T0>(&v0, arg1, arg2);
        };
        let v5 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::to_mid(arg5);
        let v6 = arg4.margin;
        let v7 = arg4.leverage;
        let v8 = if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&v5)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) != 1) {
            true
        } else {
            !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::enabled<T0>(arg1)
        };
        let v9 = if (v8) {
            7
        } else if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::taker_bps<T0>(arg1, arg3) > arg4.max_fee_bps) {
            8
        } else if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::open_risk_code<T0>(arg1, arg3, v6, v7) != 0) {
            9
        } else if (!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::account_notional_ok<T0>(arg0, arg1, arg2, arg3, v6, v7)) {
            9
        } else if (!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::tx_notional_ok<T0>(arg0, arg1, arg2, arg3, v6, v7)) {
            9
        } else {
            0
        };
        let (v10, v11) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, false, arg7);
        if (v9 != 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(v5);
            emit_final(&v0, v10, 0, v9, 0, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&v5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&v5), v11, arg6, arg7);
            return v9
        };
        emit_final(&v0, v10, 0, 0, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::open_inner<T0>(arg0, arg1, arg2, arg3, v5, v6, v7, arg4.is_long, false, arg4.min_factor_bps, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::no_price_bound(), arg4.builder_id, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::mode_two_step(), arg6, arg7), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&v5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&v5), v11, arg6, arg7);
        0
    }

    fun finalize<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64) {
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1));
        0x2::object::delete(v22);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::dec_pending_orders<T0>(arg0, arg2);
        if (v5 == 1) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_pending_close<T0>(arg0, arg2, v9);
        };
        let v23 = 0x2::balance::value<T0>(&v21);
        let v24 = v23;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::join_in<T0>(arg0, arg1, v21);
        let v25 = if (arg5) {
            v24 = v23 + 0x2::balance::value<T0>(&v20);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::join_in<T0>(arg0, arg1, v20);
            0
        } else {
            let v26 = 0x2::balance::value<T0>(&v20);
            if (v26 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg6), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::exec_fee_recipient(arg3));
            } else {
                0x2::balance::destroy_zero<T0>(v20);
            };
            v26
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::credit_account_free<T0>(arg0, arg1, v1, v24);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg1);
        let v27 = Refund{
            order_id   : 0x2::object::uid_to_inner(&v22),
            account_id : v1,
            owner      : v2,
            market_id  : v4,
            amount     : v24,
        };
        (v27, v25)
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

    public fun min_cancel_delay_ms() : u64 {
        5000
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

    public fun outcome_refund_liq_paused() : u8 {
        14
    }

    public fun outcome_refund_paused() : u8 {
        5
    }

    public fun outcome_refund_risk() : u8 {
        9
    }

    public fun outcome_session_closed() : u8 {
        13
    }

    public fun outcome_void() : u8 {
        10
    }

    public fun pending_open_orders<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>) : u64 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::pending_orders<T0>(arg0) - 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::pending_close_count<T0>(arg0)
    }

    public fun position_id<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.position_id
    }

    public fun refund_blocked_cleanup<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u8 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg6)), 13835060310139994113);
        assert!(arg4.kind == 0, 13836186214342328329);
        assert!(arg4.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), 13835623268683612165);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4.fill_deadline_ms, 13837030647862788111);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) > 0 && 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::reconcile_halted<T0>(arg1, arg3), 13841815739648704557);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let (v1, v2) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg6);
        emit_final(&v0, v1, 0, 14, 0, 0, 0, v2, arg5, arg6);
        14
    }

    public fun request_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg8, arg9))
    }

    public fun request_close_as_delegate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg6, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun request_close_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1);
        let v1 = if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg3)) {
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg1)) {
                if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg1)) {
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
        assert!(v1, 13839283590138691613);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::has_position<T0>(arg2, arg4), 13839565073705467935);
        let (v2, v3, v4) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_summary<T0>(arg2, arg4);
        assert!(v2 == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839565082295402527);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::is_pending(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), arg4), 13839565095180304415);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::timing<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg6) >= v4 + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_hold_ms(&v5), 13839846574452113441);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::has_pending_close<T0>(arg2, arg4), 13838439203863003161);
        let v6 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::add_pending_close<T0>(&v6, arg2, arg4);
        create<T0>(arg0, arg1, arg2, arg3, 1, v3, 0, 0, arg4, arg5, 0, 0, 0x1::option::none<u32>(), arg6, arg7)
    }

    public fun request_open<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13))
    }

    public fun request_open_as_delegate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg10, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11))
    }

    fun request_open_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_paused(arg3)) {
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::opens_paused<T0>(arg1)) {
                if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg3)) {
                    if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg1)) {
                        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::enabled<T0>(arg1)) {
                            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg1)) {
                                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) == 1
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13839283452699738141);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13840690836173750309);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::open_risk_code<T0>(arg1, arg3, arg4, arg5) != 4, 13840409365491875875);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::assert_open_risk<T0>(arg1, arg3, arg4, arg5);
        assert!(pending_open_orders<T0>(arg2) < 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::max_pending_orders(arg3), 13838157578562306071);
        let (_, _) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::snapshot<T0>(arg0, arg3, arg9);
        create<T0>(arg0, arg1, arg2, arg3, 0, arg6, arg4, arg5, 0, arg8, arg7, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade::taker_bps<T0>(arg1, arg3), arg9, arg10, arg11)
    }

    public fun requested_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.requested_ms
    }

    public fun requester<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.requester
    }

    fun session_force_closed<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: u64) : bool {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg0);
        0x1::option::is_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v0) && 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_eligible(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_watermark(0x1::option::borrow<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v0)))
    }

    public fun session_refund<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: OrderRequest<T0>, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg7)), 13835060829831036929);
        assert!(arg4.account_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), 13835623784079687685);
        assert!(arg4.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13835905263351496711);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg5) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13835905267646464007);
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v0), 13840971825819287591);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_ts_ms(0x1::option::borrow<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v0));
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5);
        let v3 = if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg5)) {
            if (v2 == v1) {
                arg4.requested_ms >= v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13841253313681031209);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
        let v4 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let (v5, v6) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, true, arg7);
        emit_final(&v4, v5, arg4.kind, 13, arg4.position_id, 0, v2, v6, arg6, arg7);
    }

    fun share<T0>(arg0: OrderRequest<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<OrderRequest<T0>>(arg0);
        0x2::object::id<OrderRequest<T0>>(&arg0)
    }

    // decompiled from Move bytecode v7
}

