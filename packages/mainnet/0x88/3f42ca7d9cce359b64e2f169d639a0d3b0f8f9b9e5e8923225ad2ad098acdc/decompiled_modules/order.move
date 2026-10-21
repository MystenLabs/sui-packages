module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::order {
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
        permit: 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::PendingPermit,
    }

    struct Refund has copy, drop {
        order_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_delegate<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
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

    fun assert_fill<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &OrderRequest<T0>, arg4: &0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13835062397494099969);
        assert!(arg3.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg1), 13835625351742750725);
        assert!(arg3.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 13835906831014559751);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 13835906835309527047);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3.fill_deadline_ms, 13837032739511861263);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(arg4);
        assert!(v0 > arg3.requested_ms, 13836469798148112395);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::order_params<T0>(arg0);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::fill_price_in_window(v0, arg3.requested_ms, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::fill_window_ms(&v1)), 13836751281714888717);
        assert!(v0 <= 0x2::clock::timestamp_ms(arg5) + 0, 13842099310569586735);
    }

    fun assert_request_prelude<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
    }

    public fun cancel<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg1, arg2);
        cancel_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun cancel_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x1::u64::max(arg0.cancel_after_ms, arg0.requested_ms + 5000)
    }

    public fun cancel_as_delegate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_delegate<T0>(arg1, arg4, arg5);
        cancel_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun cancel_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg1);
        assert!(arg3.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg1), 13835625446232031237);
        assert!(0x2::clock::timestamp_ms(arg4) >= cancel_after_ms<T0>(&arg3), 13837314300388048913);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_refund<T0>(arg2, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, false, arg5);
        emit_final(&v0, v1, arg3.kind, 2, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    fun create<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: 0x1::option::Option<u32>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::order_params<T0>(arg1);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::exec_fee(&v1);
        let v3 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        assert!((0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::free_balance<T0>(arg0, v3) as u128) >= (arg6 as u128) + (v2 as u128), 13839002557543481371);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_account_free<T0>(&v0, arg0, v3, arg6 + v2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        let v4 = if (arg4 == 1) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::inc_pending_close<T0>(&v0, arg2, arg8)
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::inc_pending_orders<T0>(&v0, arg2)
        };
        let v5 = 0x2::clock::timestamp_ms(arg13);
        let v6 = if (arg4 == 0) {
            18446744073709551615
        } else {
            v5 + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::emergency_after_ms(&v1)
        };
        let v7 = OrderRequest<T0>{
            id                   : 0x2::object::new(arg14),
            account_id           : v3,
            owner                : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2),
            requester            : 0x2::tx_context::sender(arg14),
            market_id            : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1),
            kind                 : arg4,
            is_long              : arg5,
            margin               : arg6,
            leverage             : arg7,
            position_id          : arg8,
            acceptable_price_wad : arg9,
            min_factor_bps       : arg10,
            max_fee_bps          : arg11,
            builder_id           : arg12,
            escrow               : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::split_balance<T0>(&v0, arg0, arg6),
            exec_fee             : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::split_balance<T0>(&v0, arg0, v2),
            requested_ms         : v5,
            fill_deadline_ms     : v5 + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::fill_deadline_ms(&v1),
            cancel_after_ms      : v5 + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::cancel_delay_ms(&v1),
            emergency_after_ms   : v6,
            permit               : v4,
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_order_requested_event(&v0, 0x2::object::id<OrderRequest<T0>>(&v7), v3, v7.owner, v7.requester, v7.market_id, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v2, v5, v7.fill_deadline_ms, v7.cancel_after_ms, v6);
        v7
    }

    fun deposit_top_up<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::deposit<T0>(arg0, arg3, arg1, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    fun drain_bounded<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>) : bool {
        let v0 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        let v1 = 0;
        while (v1 < 8 && 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v0) > 0) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::reconcile_inner<T0>(arg0, arg1, arg2);
            v1 = v1 + 1;
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v0) == 0
    }

    public fun emergency_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg5: OrderRequest<T0>, arg6: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun emergency_close_as_delegate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        assert_delegate<T0>(arg2, arg6, arg7);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emergency_close_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        assert!(arg4.kind == 1, 13836188482085060617);
        assert!(arg4.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), 13835625536426344453);
        assert!(arg4.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13835907015698153479);
        assert!(arg4.emergency_after_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg6) >= arg4.emergency_after_ms, 13837877344831012885);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5);
        assert!(v0 > arg4.emergency_after_ms, 13837877366305849365);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let v2 = arg4.position_id;
        let (v3, v4) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        emit_final(&v1, v3, 1, 11, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), v0, v4, arg6, arg7);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v2, arg5, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::no_price_bound(), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::mode_one_step(), arg6, arg7)
    }

    fun emit_final(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: Refund, arg2: u8, arg3: u8, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            0
        } else {
            arg1.amount
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_order_finalized_event(arg0, arg1.order_id, arg1.account_id, arg1.owner, arg1.market_id, arg2, arg3, arg4, arg5, arg6, v0, arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
    }

    public fun escrow_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun exec_fee_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.exec_fee)
    }

    public fun expire<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        expire_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>(), arg5, arg6);
    }

    fun expire_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x1::option::Option<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        assert!(arg4.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), 13835623633755832325);
        assert!(arg4.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13835905113027641351);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x2::clock::timestamp_ms(arg6) > expires_after_ms<T0>(&arg4), 13837593971478626323);
        let v0 = 0;
        let v1 = if (0x1::option::is_some<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>(&arg5)) {
            let v2 = 0x1::option::destroy_some<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>(arg5);
            assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&v2) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13835905143092412423);
            let v3 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&v2);
            v0 = v3;
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(v2);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::hours_mode<T0>(arg1) == 1 && v3 <= arg4.requested_ms
        } else {
            0x1::option::destroy_none<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>(arg5);
            assert!(!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::hours_mode<T0>(arg1) == 1), 13841534668398788651);
            false
        };
        let v4 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_refund<T0>(arg3, arg0);
        let v5 = arg4.kind;
        let v6 = if (v5 == 0) {
            if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_paused(arg3)) {
                true
            } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::opens_paused<T0>(arg1)) {
                true
            } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::closes_paused(arg3)) {
                true
            } else {
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg1)
            }
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::closes_paused(arg3) || 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg1)
        };
        let v7 = if (v1) {
            13
        } else if (v6) {
            5
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            3
        };
        let (v8, v9) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, v7 != 3, arg7);
        let v10 = if (v1) {
            v0
        } else {
            0
        };
        emit_final(&v4, v8, v5, v7, arg4.position_id, 0, v10, v9, arg6, arg7);
    }

    public fun expire_with_price<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        expire_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt>(arg5), arg6, arg7);
    }

    public fun expires_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        if (arg0.kind == 0 || arg0.emergency_after_ms == 18446744073709551615) {
            arg0.fill_deadline_ms
        } else {
            arg0.emergency_after_ms + arg0.fill_deadline_ms - arg0.requested_ms
        }
    }

    public fun fill_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u8, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket, 0x2::coin::Coin<T0>) {
        assert!(arg4.kind == 1, 13836185784845598729);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let v1 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            0
        };
        if (v1 != 0) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            let (v2, v3) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v2, 1, v1, arg4.position_id, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v3, arg6, arg7);
            return (v1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v4 = drain_bounded<T0>(&v0, arg1, arg2);
        if (!v4) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            let (v5, v6) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v5, 1, 14, arg4.position_id, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v6, arg6, arg7);
            return (14, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v7 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        let v8 = arg4.position_id;
        let v9 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5);
        let v10 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::has_position<T0>(arg2, v8);
        let v11 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_force_closed<T0>(arg1, v8)) {
            13
        } else {
            10
        };
        let v12 = if (v10) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1)
        } else {
            false
        };
        let v13 = if (v10) {
            if (!v12) {
                if (!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg5)) {
                    0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::liquidatable_at<T0>(arg1, v8, v9)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v14 = v10 && v12 || v11 == 13;
        let (v15, v16) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, v14, arg7);
        if (!v10) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            emit_final(&v0, v15, 1, v11, v8, v9, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v16, arg6, arg7);
            return (v11, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, v7), 0x2::coin::zero<T0>(arg7))
        };
        if (v12) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            emit_final(&v0, v15, 1, 13, v8, v9, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v16, arg6, arg7);
            return (13, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, v7), 0x2::coin::zero<T0>(arg7))
        };
        if (v13) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::reconcile_inner<T0>(&v0, arg1, arg2);
            emit_final(&v0, v15, 1, 1, v8, v9, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v16, arg6, arg7);
            return (1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, v7), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::liquidate_receipt_mode<T0>(arg0, arg1, arg3, v8, arg5, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::mode_two_step(), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::liq_kind_keeper(), arg6, arg7))
        };
        let v17 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1);
        let v18 = if (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg5)) {
            true
        } else {
            let v19 = v17 == 1 || v17 == 2;
            !v19
        };
        let v20 = if (v18) {
            7
        } else {
            0
        };
        if (v20 != 0) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            emit_final(&v0, v15, 1, v20, v8, v9, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v16, arg6, arg7);
            return (v20, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, v7), 0x2::coin::zero<T0>(arg7))
        };
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::discard_zero_loss(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, v7));
        emit_final(&v0, v15, 1, 0, v8, v9, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v16, arg6, arg7);
        (0, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v8, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::to_mid(arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::no_price_bound(), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::mode_two_step(), arg6, arg7), 0x2::coin::zero<T0>(arg7))
    }

    public fun fill_max_future_ms() : u64 {
        0
    }

    public fun fill_open<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u8 {
        assert!(arg4.kind == 0, 13836185351053901833);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &arg5, arg6, arg7);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let v1 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_paused(arg3)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::opens_paused<T0>(arg1)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::closes_paused(arg3)) {
            true
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg1)
        };
        let v2 = if (v1) {
            5
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1)) {
            6
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1)) {
            13
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)) > 0 && 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::reconcile_halted<T0>(arg1, arg3)) {
            14
        } else {
            0
        };
        if (v2 != 0) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            let (v3, v4) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v3, 0, v2, arg4.position_id, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v4, arg6, arg7);
            return v2
        };
        let v5 = drain_bounded<T0>(&v0, arg1, arg2);
        if (!v5) {
            observe_refund<T0>(&v0, arg1, &arg5);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
            let (v6, v7) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v0, v6, 0, 14, arg4.position_id, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5), v7, arg6, arg7);
            return 14
        };
        let v8 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::to_mid(arg5);
        let v9 = arg4.margin;
        let v10 = arg4.leverage;
        let v11 = if (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&v8)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) != 1) {
            true
        } else {
            !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::enabled<T0>(arg1)
        };
        let v12 = if (v11) {
            7
        } else if (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::taker_bps<T0>(arg1, arg3) > arg4.max_fee_bps) {
            8
        } else if (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::open_risk_code<T0>(arg1, arg3, v9, v10) != 0) {
            9
        } else if (!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::account_notional_ok<T0>(arg0, arg1, arg2, arg3, v9, v10)) {
            9
        } else if (!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::tx_notional_ok<T0>(arg0, arg1, arg2, arg3, v9, v10)) {
            9
        } else {
            0
        };
        let (v13, v14) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, false, arg7);
        if (v12 != 0) {
            observe_refund<T0>(&v0, arg1, &v8);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(v8);
            emit_final(&v0, v13, 0, v12, 0, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&v8), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&v8), v14, arg6, arg7);
            return v12
        };
        emit_final(&v0, v13, 0, 0, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::open_inner<T0>(arg0, arg1, arg2, arg3, v8, v9, v10, arg4.is_long, false, arg4.min_factor_bps, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::no_price_bound(), arg4.builder_id, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::mode_two_step(), arg6, arg7), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&v8), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&v8), v14, arg6, arg7);
        0
    }

    fun finalize<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64) {
        let OrderRequest {
            id                   : v0,
            account_id           : v1,
            owner                : v2,
            requester            : _,
            market_id            : v4,
            kind                 : _,
            is_long              : _,
            margin               : _,
            leverage             : _,
            position_id          : _,
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
            permit               : v20,
        } = arg4;
        let v21 = v15;
        let v22 = v0;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1));
        0x2::object::delete(v22);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::dec_pending_orders<T0>(arg0, arg2, v20);
        let v23 = v14;
        let v24 = if (arg5) {
            0x2::balance::join<T0>(&mut v23, v21);
            0
        } else {
            let v25 = 0x2::balance::value<T0>(&v21);
            if (v25 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg6), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::exec_fee_recipient(arg3));
            } else {
                0x2::balance::destroy_zero<T0>(v21);
            };
            v25
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::refund_escrow<T0>(arg0, arg1, v1, v23);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg1);
        let v26 = Refund{
            order_id   : 0x2::object::uid_to_inner(&v22),
            account_id : v1,
            owner      : v2,
            market_id  : v4,
            amount     : 0x2::balance::value<T0>(&v23),
        };
        (v26, v24)
    }

    fun fund_close_fee<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg5: 0x2::coin::Coin<T0>) {
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::deposits_paused(arg4)) {
            deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg5);
            return
        };
        let v0 = 0x2::coin::value<T0>(&arg5);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg5);
            return
        };
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::order_params<T0>(arg1);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::exec_fee(&v1);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::free_balance<T0>(arg0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2));
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v0 <= v4, 13842661229731119155);
        let v5 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg4, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::credit_close_fee<T0>(&v5, arg0, arg2, arg3, arg5);
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

    fun observe_refund<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt) {
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1) || 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(arg2)) {
            return
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::observe(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(arg0, arg1), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(arg2), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(arg2));
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

    public fun pending_open_orders<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>) : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::pending_orders<T0>(arg0) - 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::pending_close_count<T0>(arg0)
    }

    public fun position_id<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.position_id
    }

    public fun refund_blocked_cleanup<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u8 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg6)), 13835060361679601665);
        assert!(arg4.kind == 0, 13836186265881935881);
        assert!(arg4.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), 13835623320223219717);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4.fill_deadline_ms, 13837030699402395663);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)) > 0 && 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::reconcile_halted<T0>(arg1, arg3), 13841815791188312109);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg6);
        emit_final(&v0, v1, 0, 14, 0, 0, 0, v2, arg5, arg6);
        14
    }

    public fun request_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        fund_close_fee<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg8, arg9))
    }

    public fun request_close_as_delegate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg6, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun request_close_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1) && (v0 == 1 || v0 == 2), 13839283860721631261);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13840691252785578021);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::has_position<T0>(arg2, arg4), 13839565357173309471);
        let (v1, v2, v3) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_summary<T0>(arg2, arg4);
        assert!(v1 == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839565365763244063);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::is_pending(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), arg4), 13839565378648145951);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::timing<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg6) >= v3 + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_hold_ms(&v4), 13839846857919954977);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::has_pending_close<T0>(arg2, arg4), 13838439487330844697);
        create<T0>(arg0, arg1, arg2, arg3, 1, v2, 0, 0, arg4, arg5, 0, 0, 0x1::option::none<u32>(), arg6, arg7)
    }

    public fun request_open<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13))
    }

    public fun request_open_as_delegate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg10, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11))
    }

    fun request_open_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_paused(arg3)) {
            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::opens_paused<T0>(arg1)) {
                if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::closes_paused(arg3)) {
                    if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg1)) {
                        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::enabled<T0>(arg1)) {
                            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1)) {
                                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) == 1
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
        assert!(v0, 13839283723282677789);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13840691106756689957);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::open_risk_code<T0>(arg1, arg3, arg4, arg5) != 4, 13840409636074815523);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::assert_open_risk<T0>(arg1, arg3, arg4, arg5);
        assert!(pending_open_orders<T0>(arg2) < 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::max_pending_orders(arg3), 13838157849145245719);
        assert!(arg7 <= 10000, 13842379978092576817);
        let (_, _) = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::snapshot<T0>(arg0, arg3, arg9);
        create<T0>(arg0, arg1, arg2, arg3, 0, arg6, arg4, arg5, 0, arg8, arg7, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade::taker_bps<T0>(arg1, arg3), arg9, arg10, arg11)
    }

    public fun requested_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.requested_ms
    }

    public fun requester<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.requester
    }

    public fun session_refund<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: OrderRequest<T0>, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg7)), 13835060958680055809);
        assert!(arg4.account_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), 13835623912928706565);
        assert!(arg4.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13835905392200515591);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg5) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13835905396495482887);
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(&v0), 13840971954668306471);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_ts_ms(0x1::option::borrow<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(&v0));
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5);
        let v3 = if (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg5)) {
            if (v2 == v1) {
                arg4.requested_ms >= v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13841253442530050089);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
        let v4 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_refund<T0>(arg3, arg0);
        let (v5, v6) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, true, arg7);
        emit_final(&v4, v5, arg4.kind, 13, arg4.position_id, 0, v2, v6, arg6, arg7);
    }

    fun share<T0>(arg0: OrderRequest<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<OrderRequest<T0>>(arg0);
        0x2::object::id<OrderRequest<T0>>(&arg0)
    }

    // decompiled from Move bytecode v7
}

