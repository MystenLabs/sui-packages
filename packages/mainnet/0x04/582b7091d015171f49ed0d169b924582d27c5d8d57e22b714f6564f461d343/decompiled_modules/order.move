module 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::order {
    struct CloseBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartialCloseRequestedEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        position_id: u64,
        close_bps: u64,
    }

    struct OrderRequest<phantom T0> has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        owner: address,
        requester: address,
        via_delegate: bool,
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
        builder_fee_bps: u16,
        escrow: 0x2::balance::Balance<T0>,
        exec_fee: 0x2::balance::Balance<T0>,
        fee_owed: u64,
        requested_ms: u64,
        signed_window_ms: u64,
        fill_deadline_ms: u64,
        cancel_after_ms: u64,
        emergency_after_ms: u64,
        permit: 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::PendingPermit,
    }

    struct Refund has copy, drop {
        order_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
        fee_refunded: u64,
        fee_owed: u64,
    }

    struct FeeOwed {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_close_delegate<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_close_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
    }

    fun assert_delegate<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
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

    public fun signed_window_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.signed_window_ms
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

    public fun assert_exec_fee_at_most<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg1: u64) {
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::order_params<T0>(arg0);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::exec_fee(&v0) <= arg1, 13843225670038323253);
    }

    fun assert_fill<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &OrderRequest<T0>, arg4: &0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_version<T0>(arg0);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13835064712481472513);
        assert!(arg3.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg1), 13835627666730123269);
        assert!(arg3.market_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg0), 13835909146001932295);
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::market_id(arg4) == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg0), 13835909150296899591);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3.fill_deadline_ms, 13837035054499233807);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(arg4);
        assert!(v0 > arg3.requested_ms, 13836472117430452235);
        assert!(0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::safety::fill_price_in_window(v0, arg3.requested_ms, arg3.signed_window_ms), 13836753600997228557);
        assert!(v0 <= 0x2::clock::timestamp_ms(arg5) + 0, 13842101629851795501);
    }

    fun assert_request_prelude<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_version<T0>(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_exchange<T0>(arg1, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_version<T0>(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg2, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0));
    }

    public fun cancel<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg1, arg2);
        cancel_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun cancel_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x1::u64::max(arg0.cancel_after_ms, arg0.requested_ms + 5000)
    }

    public fun cancel_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_delegate<T0>(arg1, arg4, arg5);
        cancel_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun cancel_inner<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_version<T0>(arg1);
        assert!(arg3.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg1), 13835627765514371077);
        assert!(0x2::clock::timestamp_ms(arg4) >= cancel_after_ms<T0>(&arg3), 13837316619670388753);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_refund<T0>(arg2, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, false, arg5);
        emit_final(&v0, v1, arg3.kind, 2, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    public fun card<T0>(arg0: &OrderRequest<T0>) : 0x1::option::Option<u16> {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::order_card(&arg0.id)
    }

    public fun close_bps<T0>(arg0: &OrderRequest<T0>) : u64 {
        let v0 = CloseBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CloseBpsKey>(&arg0.id, v0)) {
            let v2 = CloseBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CloseBpsKey, u64>(&arg0.id, v2)
        } else {
            10000
        }
    }

    fun collect_fee_owed<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: FeeOwed, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let FeeOwed {
            account_id : v0,
            amount     : v1,
        } = arg3;
        if (v1 == 0) {
            return 0
        };
        let v2 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::safety::fee_owed_take(v1, arg4, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::free_balance<T0>(arg1, v0));
        if (v2 == 0) {
            return 0
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::debit_account_free<T0>(arg0, arg1, v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::split_balance<T0>(arg0, arg1, v2), arg5), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::exec_fee_recipient(arg2));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_identity<T0>(arg1);
        v2
    }

    fun create<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: 0x1::option::Option<u32>, arg13: u16, arg14: bool, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg0);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::order_params<T0>(arg1);
        let v2 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::exec_fee(&v1);
        let v3 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2);
        let v4 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::free_balance<T0>(arg0, v3);
        let v5 = if (arg4 == 1 && v4 < v2) {
            v2 - v4
        } else {
            0
        };
        let v6 = v2 - v5;
        assert!((v4 as u128) >= (arg6 as u128) + (v6 as u128), 13839004086551838747);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::debit_account_free<T0>(&v0, arg0, v3, arg6 + v6);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_identity<T0>(arg0);
        let v7 = if (arg4 == 1) {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::inc_pending_close<T0>(&v0, arg2, arg8)
        } else {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::inc_pending_orders<T0>(&v0, arg2)
        };
        let v8 = 0x2::clock::timestamp_ms(arg15);
        let v9 = v8 + 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::fill_deadline_ms(&v1);
        if (arg14) {
            assert!(arg4 == 0 && 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::is_live_delegate<T0>(arg2, 0x2::tx_context::sender(arg16), v9) || 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::is_live_close_delegate<T0>(arg2, 0x2::tx_context::sender(arg16), v9), 13842944826421674035);
        };
        let v10 = if (arg4 == 0) {
            18446744073709551615
        } else {
            v8 + 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::emergency_after_ms(&v1)
        };
        let v11 = OrderRequest<T0>{
            id                   : 0x2::object::new(arg16),
            account_id           : v3,
            owner                : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg2),
            requester            : 0x2::tx_context::sender(arg16),
            via_delegate         : arg14,
            market_id            : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1),
            kind                 : arg4,
            is_long              : arg5,
            margin               : arg6,
            leverage             : arg7,
            position_id          : arg8,
            acceptable_price_wad : arg9,
            min_factor_bps       : arg10,
            max_fee_bps          : arg11,
            builder_id           : arg12,
            builder_fee_bps      : arg13,
            escrow               : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::split_balance<T0>(&v0, arg0, arg6),
            exec_fee             : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::split_balance<T0>(&v0, arg0, v6),
            fee_owed             : v5,
            requested_ms         : v8,
            signed_window_ms     : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::signed_window_ms(&v1),
            fill_deadline_ms     : v9,
            cancel_after_ms      : v8 + 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::cancel_delay_ms(&v1),
            emergency_after_ms   : v10,
            permit               : v7,
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_order_requested_event(&v0, 0x2::object::id<OrderRequest<T0>>(&v11), v3, v11.owner, v11.requester, v11.market_id, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v2, v8, v11.fill_deadline_ms, v11.cancel_after_ms, v10, v5);
        v11
    }

    fun delegate_not_live<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: &OrderRequest<T0>, arg2: u64) : bool {
        if (!arg1.via_delegate) {
            return false
        };
        arg1.kind == 0 && !0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::is_live_delegate<T0>(arg0, arg1.requester, arg2) || !0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::is_live_close_delegate<T0>(arg0, arg1.requester, arg2)
    }

    fun deposit_top_up<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::deposit<T0>(arg0, arg3, arg1, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    fun drain_bounded<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>) : bool {
        let v0 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2);
        let v1 = 0;
        while (v1 < 8 && 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::pending_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), v0) > 0) {
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::reconcile_inner<T0>(arg0, arg1, arg2);
            v1 = v1 + 1;
        };
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::pending_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), v0) == 0
    }

    public fun emergency_close<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: OrderRequest<T0>, arg6: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::LossTicket {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun emergency_close_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::LossTicket {
        assert_close_delegate<T0>(arg2, arg6, arg7);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emergency_close_inner<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::LossTicket {
        assert!(arg4.kind == 1, 13836190801367400457);
        assert!(arg4.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), 13835627855708684293);
        assert!(arg4.market_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13835909334980493319);
        assert!(arg4.emergency_after_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg6) >= arg4.emergency_after_ms, 13837879664113352725);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&arg5);
        assert!(v0 > arg4.emergency_after_ms, 13837879685588189205);
        let v1 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(arg5);
            let (v2, v3) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v2, 1, 15, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&arg5), v0, v3, arg6, arg7);
            return 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2))
        };
        let v4 = arg4.position_id;
        let (v5, v6, v7) = finalize_owing<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        let v8 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::free_balance<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2));
        let v9 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::close_part_inner<T0>(arg0, arg1, arg2, arg3, v4, arg5, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::no_price_bound(), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::mode_one_step(), close_bps<T0>(&arg4), arg6, arg7);
        let v10 = collect_fee_owed<T0>(&v1, arg0, arg3, v7, v8, arg7);
        emit_final(&v1, v5, 1, 11, v4, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&arg5), v0, v6 + v10, arg6, arg7);
        v9
    }

    fun emit_final(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: Refund, arg2: u8, arg3: u8, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            0
        } else {
            arg1.amount
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_order_finalized_event(arg0, arg1.order_id, arg1.account_id, arg1.owner, arg1.market_id, arg2, arg3, arg4, arg5, arg6, v0, arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9), arg1.fee_refunded);
    }

    public fun escrow_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun exec_fee_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.exec_fee)
    }

    public fun expire<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::ExpiryPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_version<T0>(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_version<T0>(arg2);
        assert!(arg4.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), 13835624844936609797);
        assert!(arg4.market_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13835906324208418823);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_exchange<T0>(arg1, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0));
        assert!(0x2::clock::timestamp_ms(arg6) > expires_after_ms<T0>(&arg4), 13837595182659403795);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::expiry_receipt(arg5);
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::market_id(&v0) == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13835906345683255303);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::hours_mode<T0>(arg1) == 1;
        let v2 = arg4.requested_ms;
        let v3 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0);
        let v4 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(&v0)) {
            if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::conf_timestamp_ms(&v0) <= v2) {
                0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::message_ms(&v0) > v2
            } else {
                false
            }
        } else {
            false
        };
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
        let v5 = v1 && (v3 <= v2 || v4);
        let v6 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::safety::fill_price_in_window(v3, v2, arg4.signed_window_ms);
        let v7 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::expiry_is_signed(&arg5)) {
            true
        } else if (!v1) {
            true
        } else {
            !v6
        };
        assert!(v7, 13843506225892163639);
        let v8 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_refund<T0>(arg3, arg0);
        let v9 = arg4.kind;
        let v10 = if (v9 == 0) {
            if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_paused(arg3)) {
                true
            } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::opens_paused<T0>(arg1)) {
                true
            } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::closes_paused(arg3)) {
                true
            } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::closes_paused<T0>(arg1)) {
                true
            } else {
                0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::event_guard::opens_blocked<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 0x2::clock::timestamp_ms(arg6))
            }
        } else {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::closes_paused(arg3) || 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::closes_paused<T0>(arg1)
        };
        let v11 = if (v5) {
            13
        } else if (v10) {
            5
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            3
        };
        let v12 = v11 != 3 || !v6;
        let (v13, v14) = finalize<T0>(&v8, arg0, arg2, arg3, arg4, v12, arg7);
        let v15 = if (v5) {
            v3
        } else {
            0
        };
        emit_final(&v8, v13, v9, v11, arg4.position_id, 0, v15, v14, arg6, arg7);
    }

    public fun expires_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        if (arg0.kind == 0 || arg0.emergency_after_ms == 18446744073709551615) {
            arg0.fill_deadline_ms
        } else {
            arg0.emergency_after_ms + arg0.fill_deadline_ms - arg0.requested_ms
        }
    }

    public fun fee_owed<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.fee_owed
    }

    public fun fill_close<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::FillPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u8, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::LossTicket, 0x2::coin::Coin<T0>) {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::fill_receipt(arg5);
        assert!(arg4.kind == 1, 13836186957371670537);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &v0, arg6, arg7);
        let v1 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            let v2 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2);
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v3, v4) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v3, 1, 15, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v4, arg6, arg7);
            return (15, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v2), 0x2::coin::zero<T0>(arg7))
        };
        let v5 = if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            0
        };
        if (v5 != 0) {
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v6, v7) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v6, 1, v5, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v7, arg6, arg7);
            return (v5, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v8 = drain_bounded<T0>(&v1, arg1, arg2);
        if (!v8) {
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v9, v10) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v9, 1, 14, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v10, arg6, arg7);
            return (14, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v11 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2);
        let v12 = arg4.position_id;
        let v13 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0);
        let v14 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::has_position<T0>(arg2, v12);
        let v15 = if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_force_closed<T0>(arg1, v12)) {
            13
        } else {
            10
        };
        let v16 = if (v14) {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_pending<T0>(arg1)
        } else {
            false
        };
        let v17 = if (v14) {
            if (!v16) {
                if (!0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(&v0)) {
                    0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::liquidatable_at<T0>(arg1, v12, v13)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v18 = v14 && v16 || v15 == 13;
        let (v19, v20, v21) = finalize_owing<T0>(&v1, arg0, arg2, arg3, arg4, v18, arg7);
        if (!v14) {
            forgive_fee_owed(v21);
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, v15, v12, v13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (v15, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        if (v16) {
            forgive_fee_owed(v21);
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, 13, v12, v13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        if (v17) {
            forgive_fee_owed(v21);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::reconcile_inner<T0>(&v1, arg1, arg2);
            emit_final(&v1, v19, 1, 1, v12, v13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (1, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v11), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::liquidate_receipt_mode<T0>(arg0, arg1, arg3, v12, v0, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::mode_two_step(), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::liq_kind_keeper(), arg6, arg7))
        };
        let v22 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::status<T0>(arg1);
        let v23 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(&v0)) {
            true
        } else {
            let v24 = v22 == 1 || v22 == 2;
            !v24
        };
        let v25 = if (v23) {
            7
        } else {
            0
        };
        if (v25 != 0) {
            forgive_fee_owed(v21);
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, v25, v12, v13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (v25, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::discard_zero_loss(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::ticket(0, v11));
        let v26 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::free_balance<T0>(arg0, v11);
        let v27 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::close_part_inner<T0>(arg0, arg1, arg2, arg3, v12, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::to_mid(v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::no_price_bound(), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::mode_two_step(), close_bps<T0>(&arg4), arg6, arg7);
        let v28 = collect_fee_owed<T0>(&v1, arg0, arg3, v21, v26, arg7);
        emit_final(&v1, v19, 1, 0, v12, v13, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v20 + v28, arg6, arg7);
        (0, v27, 0x2::coin::zero<T0>(arg7))
    }

    public fun fill_max_future_ms() : u64 {
        0
    }

    public fun fill_open<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::FillPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::fill_receipt(arg5);
        assert!(arg4.kind == 0, 13836186399025922057);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &v0, arg6, arg7);
        let v1 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v2, v3) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v2, 0, 15, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v3, arg6, arg7);
            return 15
        };
        let v4 = if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_paused(arg3)) {
            true
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::opens_paused<T0>(arg1)) {
            true
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::closes_paused(arg3)) {
            true
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::closes_paused<T0>(arg1)) {
            true
        } else {
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::event_guard::opens_blocked<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 0x2::clock::timestamp_ms(arg6))
        };
        let v5 = if (v4) {
            5
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1)) {
            6
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_pending<T0>(arg1)) {
            13
        } else if (0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::pending_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2)) > 0 && 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::reconcile_halted<T0>(arg1, arg3)) {
            14
        } else {
            0
        };
        if (v5 != 0) {
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v6, v7) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v6, 0, v5, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v7, arg6, arg7);
            return v5
        };
        let v8 = drain_bounded<T0>(&v1, arg1, arg2);
        if (!v8) {
            observe_refund<T0>(&v1, arg1, &v0);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v0);
            let (v9, v10) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v9, 0, 14, arg4.position_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v0), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v0), v10, arg6, arg7);
            return 14
        };
        let v11 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::to_mid(v0);
        let v12 = arg4.margin;
        let v13 = arg4.leverage;
        let v14 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(&v11)) {
            true
        } else if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::status<T0>(arg1) != 1) {
            true
        } else {
            !0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::enabled<T0>(arg1)
        };
        let v15 = if (v14) {
            7
        } else if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::taker_bps<T0>(arg1, arg3) > arg4.max_fee_bps) {
            8
        } else if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::open_risk_code<T0>(arg1, arg3, v12, v13) != 0) {
            9
        } else if (!0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::event_guard::leverage_ok<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), v13, 0x2::clock::timestamp_ms(arg6))) {
            9
        } else if (!0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::account_notional_ok<T0>(arg0, arg1, arg2, arg3, v12, v13)) {
            9
        } else if (!0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::tx_notional_ok<T0>(arg0, arg1, arg2, arg3, v12, v13)) {
            9
        } else {
            0
        };
        let v16 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::next_position_id<T0>(arg0);
        if (v15 == 0) {
            0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::bind_order_card<T0>(&v1, arg0, &mut arg4.id, arg4.owner, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), v16, 0x2::clock::timestamp_ms(arg6));
        };
        let (v17, v18) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        if (v15 != 0) {
            observe_refund<T0>(&v1, arg1, &v11);
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(v11);
            emit_final(&v1, v17, 0, v15, 0, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v11), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v11), v18, arg6, arg7);
            return v15
        };
        let v19 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::open_inner<T0>(arg0, arg1, arg2, arg3, v11, v12, v13, arg4.is_long, false, arg4.min_factor_bps, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::no_price_bound(), arg4.builder_id, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::mode_two_step(), arg4.builder_fee_bps, false, arg6, arg7);
        assert!(v19 == v16, 13906837056266436607);
        emit_final(&v1, v17, 0, 0, v19, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(&v11), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(&v11), v18, arg6, arg7);
        0
    }

    fun finalize<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64) {
        let OrderRequest {
            id                   : v0,
            account_id           : v1,
            owner                : v2,
            requester            : _,
            via_delegate         : _,
            market_id            : v5,
            kind                 : _,
            is_long              : _,
            margin               : _,
            leverage             : _,
            position_id          : _,
            acceptable_price_wad : _,
            min_factor_bps       : _,
            max_fee_bps          : _,
            builder_id           : _,
            builder_fee_bps      : _,
            escrow               : v16,
            exec_fee             : v17,
            fee_owed             : v18,
            requested_ms         : _,
            signed_window_ms     : _,
            fill_deadline_ms     : _,
            cancel_after_ms      : _,
            emergency_after_ms   : _,
            permit               : v24,
        } = arg4;
        let v25 = v17;
        let v26 = v0;
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_version<T0>(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg2, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1));
        let v27 = CloseBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CloseBpsKey>(&v26, v27)) {
            let v28 = CloseBpsKey{dummy_field: false};
            0x2::dynamic_field::remove<CloseBpsKey, u64>(&mut v26, v28);
        };
        let v29 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::order_card(&v26);
        if (0x1::option::is_some<u16>(&v29)) {
            let v30 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::live_on<T0>(arg3, arg1)) {
                0x1::option::some<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth>(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg1))
            } else {
                0x1::option::none<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth>()
            };
            0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::return_order_card<T0>(v30, arg1, &mut v26, v2, arg6);
        };
        0x2::object::delete(v26);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::dec_pending_orders<T0>(arg0, arg2, v24);
        let v31 = v16;
        let v32 = if (arg5) {
            0x2::balance::value<T0>(&v25)
        } else {
            0
        };
        let v33 = if (arg5) {
            0x2::balance::join<T0>(&mut v31, v25);
            0
        } else {
            let v34 = 0x2::balance::value<T0>(&v25);
            if (v34 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg6), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::exec_fee_recipient(arg3));
            } else {
                0x2::balance::destroy_zero<T0>(v25);
            };
            v34
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::refund_escrow<T0>(arg0, arg1, v1, v31);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_identity<T0>(arg1);
        let v35 = Refund{
            order_id     : 0x2::object::uid_to_inner(&v26),
            account_id   : v1,
            owner        : v2,
            market_id    : v5,
            amount       : 0x2::balance::value<T0>(&v31),
            fee_refunded : v32,
            fee_owed     : v18,
        };
        (v35, v33)
    }

    fun finalize_owing<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64, FeeOwed) {
        let v0 = FeeOwed{
            account_id : arg4.account_id,
            amount     : arg4.fee_owed,
        };
        let (v1, v2) = finalize<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (v1, v2, v0)
    }

    fun forgive_fee_owed(arg0: FeeOwed) {
        let FeeOwed {
            account_id : _,
            amount     : _,
        } = arg0;
    }

    fun fund_close_fee<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: 0x2::coin::Coin<T0>) {
        if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::deposits_paused(arg4)) {
            deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg5);
            return
        };
        let v0 = 0x2::coin::value<T0>(&arg5);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg5);
            return
        };
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::order_params<T0>(arg1);
        let v2 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::exec_fee(&v1);
        let v3 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::free_balance<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2));
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v0 <= v4, 13842662539696013361);
        let v5 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg4, arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::credit_close_fee<T0>(&v5, arg0, arg2, arg3, arg5);
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

    fun observe_refund<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt) {
        if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1) || 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(arg2)) {
            return
        };
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::observe(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq_mut<T0>(arg0, arg1), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::price_wad(arg2), 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::timestamp_ms(arg2));
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

    public fun outcome_refund_revoked() : u8 {
        15
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

    public fun pending_open_orders<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>) : u64 {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::pending_orders<T0>(arg0) - 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::pending_close_count<T0>(arg0)
    }

    public fun position_id<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.position_id
    }

    public fun refund_blocked_cleanup<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u8 {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_version<T0>(arg1);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg6)), 13835061620105019393);
        assert!(arg4.kind == 0, 13836187524307353609);
        assert!(arg4.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), 13835624578648637445);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4.fill_deadline_ms, 13837031957827813391);
        assert!(0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::pending_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2)) > 0 && 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::reconcile_halted<T0>(arg1, arg3), 13841817049613598763);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg3, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg6);
        emit_final(&v0, v1, 0, 14, 0, 0, 0, v2, arg5, arg6);
        14
    }

    public fun request_close<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        fund_close_fee<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, false, arg8, arg9))
    }

    public fun request_close_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_close_delegate<T0>(arg2, arg6, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, true, arg6, arg7))
    }

    public fun request_close_as_delegate_until<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 13843785265622548537);
        request_close_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8)
    }

    fun request_close_inner<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::status<T0>(arg1);
        assert!(!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1) && (v0 == 1 || v0 == 2), 13839285359665217565);
        assert!(!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_pending<T0>(arg1), 13840692751729164325);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::has_position<T0>(arg2, arg4), 13839566856116895775);
        let (v1, v2, v3) = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_summary<T0>(arg2, arg4);
        assert!(v1 == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13839566864706830367);
        assert!(!0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::is_pending(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), arg4), 13839566877591732255);
        let v4 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::timing<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg7) >= v3 + 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::min_hold_ms(&v4), 13839848356863541281);
        assert!(!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::has_pending_close<T0>(arg2, arg4), 13838440986274431001);
        create<T0>(arg0, arg1, arg2, arg3, 1, v2, 0, 0, arg4, arg5, 0, 0, 0x1::option::none<u32>(), 0, arg6, arg7, arg8)
    }

    public fun request_close_partial<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u64, arg7: u128, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        fund_close_fee<T0>(arg0, arg1, arg2, arg3, arg4, arg8);
        share<T0>(with_close_bps<T0>(arg4, arg1, request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg7, false, arg9, arg10), arg6))
    }

    public fun request_close_partial_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_close_delegate<T0>(arg2, arg7, arg8);
        let v0 = request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg6, true, arg7, arg8);
        if (0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::card_slice<T0>(arg0, arg2, 0x2::tx_context::sender(arg8), arg4, arg5)) {
            v0.fee_owed = 0;
        };
        share<T0>(with_close_bps<T0>(arg3, arg1, v0, arg5))
    }

    public fun request_close_partial_as_delegate_until<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 13843785592040063033);
        request_close_partial_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9)
    }

    public fun request_open<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false, arg12, arg13))
    }

    public fun request_open_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg10, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, arg10, arg11))
    }

    fun request_open_inner<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_paused(arg3)) {
            if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::opens_paused<T0>(arg1)) {
                if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::closes_paused(arg3)) {
                    if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::closes_paused<T0>(arg1)) {
                        if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::enabled<T0>(arg1)) {
                            if (!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle_killed<T0>(arg1)) {
                                0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::status<T0>(arg1) == 1
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
        assert!(v0, 13839285192161493021);
        assert!(!0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_pending<T0>(arg1), 13840692575635505189);
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::event_guard::assert_open_allowed<T0>(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), arg5, 0x2::clock::timestamp_ms(arg11));
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::open_risk_code<T0>(arg1, arg3, arg4, arg5) != 4, 13840411109248598051);
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::assert_open_risk<T0>(arg1, arg3, arg4, arg5);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::payout_cap::assert_admits<T0>(arg0, arg3, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), arg6, arg5, arg4);
        assert!(pending_open_orders<T0>(arg2) < 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::max_pending_orders(arg3), 13838159335203930135);
        assert!(arg7 <= 10000, 13842381464151130159);
        let v1 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::builder::request_fee_ceiling<T0>(arg0, arg3, arg9, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2));
        create<T0>(arg0, arg1, arg2, arg3, 0, arg6, arg4, arg5, 0, arg8, arg7, 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::taker_bps<T0>(arg1, arg3), arg9, v1, arg10, arg11, arg12)
    }

    public fun request_open_with_card<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: u16, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg11);
        let v0 = request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false, arg13, arg14);
        share<T0>(with_card<T0>(arg0, arg4, v0, arg12))
    }

    public fun request_open_with_card_as_delegate<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: u16, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg11, arg12);
        let v0 = request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, arg11, arg12);
        share<T0>(with_card<T0>(arg0, arg3, v0, arg10))
    }

    public fun requested_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.requested_ms
    }

    public fun requester<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.requester
    }

    fun revoked_at_cancel_point<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg1: &OrderRequest<T0>, arg2: u64) : bool {
        arg2 >= cancel_after_ms<T0>(arg1) && delegate_not_live<T0>(arg0, arg1, arg2)
    }

    public fun session_refund<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: OrderRequest<T0>, arg5: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::assert_version<T0>(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_version<T0>(arg2);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg7)), 13835062191335669761);
        assert!(arg4.account_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg2), 13835625145584320517);
        assert!(arg4.market_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13835906624856129543);
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::market_id(&arg5) == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg1), 13835906629151096839);
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::SessionCloseV1>(&v0), 13840973187323920423);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::sc_ts_ms(0x1::option::borrow<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::SessionCloseV1>(&v0));
        let v2 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::conf_timestamp_ms(&arg5);
        let v3 = if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::is_closed(&arg5)) {
            if (v2 == v1) {
                if (arg4.requested_ms >= v1) {
                    0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::message_ms(&arg5) > arg4.requested_ms
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13841254696660500521);
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::oracle::discard_price(arg5);
        let v4 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_refund<T0>(arg3, arg0);
        let (v5, v6) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, true, arg7);
        emit_final(&v4, v5, arg4.kind, 13, arg4.position_id, 0, v2, v6, arg6, arg7);
    }

    fun share<T0>(arg0: OrderRequest<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<OrderRequest<T0>>(arg0);
        0x2::object::id<OrderRequest<T0>>(&arg0)
    }

    public fun via_delegate<T0>(arg0: &OrderRequest<T0>) : bool {
        arg0.via_delegate
    }

    fun with_card<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: OrderRequest<T0>, arg3: u16) : OrderRequest<T0> {
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::sole_version(arg1), 13844633972635467839);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::attach_to_order<T0>(&v0, arg0, &mut arg2.id, arg2.owner, arg3);
        arg2
    }

    fun with_close_bps<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg2: OrderRequest<T0>, arg3: u64) : OrderRequest<T0> {
        assert!(arg3 >= 1 && arg3 <= 10000, 13844070966847209531);
        if (arg3 == 10000) {
            return arg2
        };
        assert!(arg2.fee_owed == 0, 13839004425854255131);
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::sole_version(arg0), 13844633929685794879);
        let v0 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::borrow_record(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::liq<T0>(arg1), arg2.position_id);
        assert!(0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::trade::partial_fits<T0>(arg1, 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_margin(v0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_notional(v0), arg3), 13844352463298887741);
        let v1 = CloseBpsKey{dummy_field: false};
        0x2::dynamic_field::add<CloseBpsKey, u64>(&mut arg2.id, v1, arg3);
        let v2 = PartialCloseRequestedEventV1{
            order_id    : 0x2::object::id<OrderRequest<T0>>(&arg2),
            position_id : arg2.position_id,
            close_bps   : arg3,
        };
        0x2::event::emit<PartialCloseRequestedEventV1>(v2);
        arg2
    }

    // decompiled from Move bytecode v7
}

