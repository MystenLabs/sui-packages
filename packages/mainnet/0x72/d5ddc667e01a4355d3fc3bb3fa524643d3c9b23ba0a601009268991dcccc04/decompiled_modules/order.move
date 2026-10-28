module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::order {
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
        permit: 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::PendingPermit,
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

    public fun market_id<T0>(arg0: &OrderRequest<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun acceptable_price_wad<T0>(arg0: &OrderRequest<T0>) : u128 {
        arg0.acceptable_price_wad
    }

    public fun account_id<T0>(arg0: &OrderRequest<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    fun assert_close_delegate<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_close_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
    }

    fun assert_delegate<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_delegate<T0>(arg0, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
    }

    public fun assert_exec_fee_at_most<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::order_params<T0>(arg0);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::exec_fee(&v0) <= arg1, 13843224914124079157);
    }

    fun assert_fill<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &OrderRequest<T0>, arg4: &0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg0);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13835063492710760449);
        assert!(arg3.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg1), 13835626446959411205);
        assert!(arg3.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), 13835907926231220231);
        assert!(0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::market_id(arg4) == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), 13835907930526187527);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3.fill_deadline_ms, 13837033834728521743);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(arg4);
        assert!(v0 > arg3.requested_ms, 13836470897659740171);
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::fill_price_in_window(v0, arg3.requested_ms, arg3.signed_window_ms), 13836752381226516493);
        assert!(v0 <= 0x2::clock::timestamp_ms(arg5) + 0, 13842100410081083437);
    }

    fun assert_request_prelude<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_exchange<T0>(arg1, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_version<T0>(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg2, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
    }

    public fun cancel<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg1, arg2);
        cancel_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun cancel_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x1::u64::max(arg0.cancel_after_ms, arg0.requested_ms + 5000)
    }

    public fun cancel_as_delegate<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_delegate<T0>(arg1, arg4, arg5);
        cancel_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun cancel_inner<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: OrderRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_version<T0>(arg1);
        assert!(arg3.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg1), 13835626545743659013);
        assert!(0x2::clock::timestamp_ms(arg4) >= cancel_after_ms<T0>(&arg3), 13837315399899676689);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_refund<T0>(arg2, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg1, arg2, arg3, false, arg5);
        emit_final(&v0, v1, arg3.kind, 2, arg3.position_id, 0, 0, v2, arg4, arg5);
    }

    fun collect_fee_owed<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: FeeOwed, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let FeeOwed {
            account_id : v0,
            amount     : v1,
        } = arg3;
        if (v1 == 0) {
            return 0
        };
        let v2 = 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::fee_owed_take(v1, arg4, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::free_balance<T0>(arg1, v0));
        if (v2 == 0) {
            return 0
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::debit_account_free<T0>(arg0, arg1, v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::split_balance<T0>(arg0, arg1, v2), arg5), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::exec_fee_recipient(arg2));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg1);
        v2
    }

    fun create<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: 0x1::option::Option<u32>, arg13: u16, arg14: bool, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg3, arg0);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::order_params<T0>(arg1);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::exec_fee(&v1);
        let v3 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2);
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::free_balance<T0>(arg0, v3);
        let v5 = if (arg4 == 1 && v4 < v2) {
            v2 - v4
        } else {
            0
        };
        let v6 = v2 - v5;
        assert!((v4 as u128) >= (arg6 as u128) + (v6 as u128), 13839003313457725467);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::debit_account_free<T0>(&v0, arg0, v3, arg6 + v6);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg0);
        let v7 = if (arg4 == 1) {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::inc_pending_close<T0>(&v0, arg2, arg8)
        } else {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::inc_pending_orders<T0>(&v0, arg2)
        };
        let v8 = 0x2::clock::timestamp_ms(arg15);
        let v9 = v8 + 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::fill_deadline_ms(&v1);
        if (arg14) {
            assert!(arg4 == 0 && 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::is_live_delegate<T0>(arg2, 0x2::tx_context::sender(arg16), v9) || 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::is_live_close_delegate<T0>(arg2, 0x2::tx_context::sender(arg16), v9), 13842944053327560755);
        };
        let v10 = if (arg4 == 0) {
            18446744073709551615
        } else {
            v8 + 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::emergency_after_ms(&v1)
        };
        let v11 = OrderRequest<T0>{
            id                   : 0x2::object::new(arg16),
            account_id           : v3,
            owner                : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2),
            requester            : 0x2::tx_context::sender(arg16),
            via_delegate         : arg14,
            market_id            : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1),
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
            escrow               : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::split_balance<T0>(&v0, arg0, arg6),
            exec_fee             : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::split_balance<T0>(&v0, arg0, v6),
            fee_owed             : v5,
            requested_ms         : v8,
            signed_window_ms     : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::signed_window_ms(&v1),
            fill_deadline_ms     : v9,
            cancel_after_ms      : v8 + 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::cancel_delay_ms(&v1),
            emergency_after_ms   : v10,
            permit               : v7,
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_order_requested_event(&v0, 0x2::object::id<OrderRequest<T0>>(&v11), v3, v11.owner, v11.requester, v11.market_id, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v2, v8, v11.fill_deadline_ms, v11.cancel_after_ms, v10, v5);
        v11
    }

    fun delegate_not_live<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg1: &OrderRequest<T0>, arg2: u64) : bool {
        if (!arg1.via_delegate) {
            return false
        };
        arg1.kind == 0 && !0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::is_live_delegate<T0>(arg0, arg1.requester, arg2) || !0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::is_live_close_delegate<T0>(arg0, arg1.requester, arg2)
    }

    fun deposit_top_up<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::deposit<T0>(arg0, arg3, arg1, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    fun drain_bounded<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>) : bool {
        let v0 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2);
        let v1 = 0;
        while (v1 < 8 && 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::pending_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg1), v0) > 0) {
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::reconcile_inner<T0>(arg0, arg1, arg2);
            v1 = v1 + 1;
        };
        0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::pending_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg1), v0) == 0
    }

    public fun emergency_after_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.emergency_after_ms
    }

    public fun emergency_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: OrderRequest<T0>, arg6: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg2, arg3);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun emergency_close_as_delegate<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket {
        assert_close_delegate<T0>(arg2, arg6, arg7);
        emergency_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emergency_close_inner<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket {
        assert!(arg4.kind == 1, 13836189581596688393);
        assert!(arg4.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), 13835626635937972229);
        assert!(arg4.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13835908115209781255);
        assert!(arg4.emergency_after_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg6) >= arg4.emergency_after_ms, 13837878444342640661);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&arg5);
        assert!(v0 > arg4.emergency_after_ms, 13837878465817477141);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(arg5);
            let (v2, v3) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v2, 1, 15, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&arg5), v0, v3, arg6, arg7);
            return 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2))
        };
        let v4 = arg4.position_id;
        let (v5, v6, v7) = finalize_owing<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        let v8 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::free_balance<T0>(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2));
        let v9 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v4, arg5, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::no_price_bound(), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::mode_one_step(), arg6, arg7);
        let v10 = collect_fee_owed<T0>(&v1, arg0, arg3, v7, v8, arg7);
        emit_final(&v1, v5, 1, 11, v4, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&arg5), v0, v6 + v10, arg6, arg7);
        v9
    }

    fun emit_final(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: Refund, arg2: u8, arg3: u8, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            0
        } else {
            arg1.amount
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_order_finalized_event(arg0, arg1.order_id, arg1.account_id, arg1.owner, arg1.market_id, arg2, arg3, arg4, arg5, arg6, v0, arg7, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9), arg1.fee_refunded);
    }

    public fun escrow_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun exec_fee_value<T0>(arg0: &OrderRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.exec_fee)
    }

    public fun expire<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::ExpiryPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_version<T0>(arg2);
        assert!(arg4.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), 13835624123382104069);
        assert!(arg4.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13835905602653913095);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_exchange<T0>(arg1, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
        assert!(0x2::clock::timestamp_ms(arg6) > expires_after_ms<T0>(&arg4), 13837594461104898067);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::expiry_receipt(arg5);
        assert!(0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::market_id(&v0) == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13835905624128749575);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::hours_mode<T0>(arg1) == 1;
        let v2 = arg4.requested_ms;
        let v3 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0);
        let v4 = if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(&v0)) {
            if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::conf_timestamp_ms(&v0) <= v2) {
                0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::message_ms(&v0) > v2
            } else {
                false
            }
        } else {
            false
        };
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
        let v5 = v1 && (v3 <= v2 || v4);
        let v6 = 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::fill_price_in_window(v3, v2, arg4.signed_window_ms);
        let v7 = if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::expiry_is_signed(&arg5)) {
            true
        } else if (!v1) {
            true
        } else {
            !v6
        };
        assert!(v7, 13843505504337657911);
        let v8 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_refund<T0>(arg3, arg0);
        let v9 = arg4.kind;
        let v10 = if (v9 == 0) {
            if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_paused(arg3)) {
                true
            } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::opens_paused<T0>(arg1)) {
                true
            } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::closes_paused(arg3)) {
                true
            } else {
                0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closes_paused<T0>(arg1)
            }
        } else {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::closes_paused(arg3) || 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closes_paused<T0>(arg1)
        };
        let v11 = if (v5) {
            13
        } else if (v10) {
            5
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1)) {
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

    public fun fill_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::FillPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u8, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket, 0x2::coin::Coin<T0>) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::fill_receipt(arg5);
        assert!(arg4.kind == 1, 13836186240112132105);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &v0, arg6, arg7);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            let v2 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2);
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v3, v4) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v3, 1, 15, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v4, arg6, arg7);
            return (15, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v2), 0x2::coin::zero<T0>(arg7))
        };
        let v5 = if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1)) {
            6
        } else {
            0
        };
        if (v5 != 0) {
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v6, v7) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v6, 1, v5, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v7, arg6, arg7);
            return (v5, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v8 = drain_bounded<T0>(&v1, arg1, arg2);
        if (!v8) {
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v9, v10) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v9, 1, 14, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v10, arg6, arg7);
            return (14, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg7))
        };
        let v11 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2);
        let v12 = arg4.position_id;
        let v13 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0);
        let v14 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::has_position<T0>(arg2, v12);
        let v15 = if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_force_closed<T0>(arg1, v12)) {
            13
        } else {
            10
        };
        let v16 = if (v14) {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_pending<T0>(arg1)
        } else {
            false
        };
        let v17 = if (v14) {
            if (!v16) {
                if (!0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(&v0)) {
                    0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::liquidatable_at<T0>(arg1, v12, v13)
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
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, v15, v12, v13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (v15, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        if (v16) {
            forgive_fee_owed(v21);
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, 13, v12, v13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        if (v17) {
            forgive_fee_owed(v21);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::reconcile_inner<T0>(&v1, arg1, arg2);
            emit_final(&v1, v19, 1, 1, v12, v13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (1, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v11), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::liquidate_receipt_mode<T0>(arg0, arg1, arg3, v12, v0, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::mode_two_step(), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::liq_kind_keeper(), arg6, arg7))
        };
        let v22 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::status<T0>(arg1);
        let v23 = if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(&v0)) {
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
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            emit_final(&v1, v19, 1, v25, v12, v13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v20, arg6, arg7);
            return (v25, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v11), 0x2::coin::zero<T0>(arg7))
        };
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::discard_zero_loss(0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::ticket(0, v11));
        let v26 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::free_balance<T0>(arg0, v11);
        let v27 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::close_inner<T0>(arg0, arg1, arg2, arg3, v12, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::to_mid(v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::no_price_bound(), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::mode_two_step(), arg6, arg7);
        let v28 = collect_fee_owed<T0>(&v1, arg0, arg3, v21, v26, arg7);
        emit_final(&v1, v19, 1, 0, v12, v13, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v20 + v28, arg6, arg7);
        (0, v27, 0x2::coin::zero<T0>(arg7))
    }

    public fun fill_deadline_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.fill_deadline_ms
    }

    public fun fill_max_future_ms() : u64 {
        0
    }

    public fun fill_open<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::FillPrice, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::fill_receipt(arg5);
        assert!(arg4.kind == 0, 13836185729011023881);
        assert_fill<T0>(arg1, arg2, arg3, &arg4, &v0, arg6, arg7);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg3, arg0);
        if (revoked_at_cancel_point<T0>(arg2, &arg4, 0x2::clock::timestamp_ms(arg6))) {
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v2, v3) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
            emit_final(&v1, v2, 0, 15, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v3, arg6, arg7);
            return 15
        };
        let v4 = if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_paused(arg3)) {
            true
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::opens_paused<T0>(arg1)) {
            true
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::closes_paused(arg3)) {
            true
        } else {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closes_paused<T0>(arg1)
        };
        let v5 = if (v4) {
            5
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1)) {
            6
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_pending<T0>(arg1)) {
            13
        } else if (0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::pending_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg1), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2)) > 0 && 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::reconcile_halted<T0>(arg1, arg3)) {
            14
        } else {
            0
        };
        if (v5 != 0) {
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v6, v7) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v6, 0, v5, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v7, arg6, arg7);
            return v5
        };
        let v8 = drain_bounded<T0>(&v1, arg1, arg2);
        if (!v8) {
            observe_refund<T0>(&v1, arg1, &v0);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v0);
            let (v9, v10) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, true, arg7);
            emit_final(&v1, v9, 0, 14, arg4.position_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v0), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v0), v10, arg6, arg7);
            return 14
        };
        let v11 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::to_mid(v0);
        let v12 = arg4.margin;
        let v13 = arg4.leverage;
        let v14 = if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(&v11)) {
            true
        } else if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::status<T0>(arg1) != 1) {
            true
        } else {
            !0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::enabled<T0>(arg1)
        };
        let v15 = if (v14) {
            7
        } else if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::taker_bps<T0>(arg1, arg3) > arg4.max_fee_bps) {
            8
        } else if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::open_risk_code<T0>(arg1, arg3, v12, v13) != 0) {
            9
        } else if (!0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::account_notional_ok<T0>(arg0, arg1, arg2, arg3, v12, v13)) {
            9
        } else if (!0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::tx_notional_ok<T0>(arg0, arg1, arg2, arg3, v12, v13)) {
            9
        } else {
            0
        };
        let (v16, v17) = finalize<T0>(&v1, arg0, arg2, arg3, arg4, false, arg7);
        if (v15 != 0) {
            observe_refund<T0>(&v1, arg1, &v11);
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(v11);
            emit_final(&v1, v16, 0, v15, 0, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v11), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v11), v17, arg6, arg7);
            return v15
        };
        emit_final(&v1, v16, 0, 0, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::open_inner<T0>(arg0, arg1, arg2, arg3, v11, v12, v13, arg4.is_long, false, arg4.min_factor_bps, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::no_price_bound(), arg4.builder_id, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::mode_two_step(), arg4.builder_fee_bps, false, arg6, arg7), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(&v11), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(&v11), v17, arg6, arg7);
        0
    }

    fun finalize<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64) {
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
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_version<T0>(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg2, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1));
        0x2::object::delete(v26);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::dec_pending_orders<T0>(arg0, arg2, v24);
        let v27 = v16;
        let v28 = if (arg5) {
            0x2::balance::value<T0>(&v25)
        } else {
            0
        };
        let v29 = if (arg5) {
            0x2::balance::join<T0>(&mut v27, v25);
            0
        } else {
            let v30 = 0x2::balance::value<T0>(&v25);
            if (v30 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg6), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::exec_fee_recipient(arg3));
            } else {
                0x2::balance::destroy_zero<T0>(v25);
            };
            v30
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::refund_escrow<T0>(arg0, arg1, v1, v27);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg1);
        let v31 = Refund{
            order_id     : 0x2::object::uid_to_inner(&v26),
            account_id   : v1,
            owner        : v2,
            market_id    : v5,
            amount       : 0x2::balance::value<T0>(&v27),
            fee_refunded : v28,
            fee_owed     : v18,
        };
        (v31, v29)
    }

    fun finalize_owing<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (Refund, u64, FeeOwed) {
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

    fun fund_close_fee<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: 0x2::coin::Coin<T0>) {
        if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::deposits_paused(arg4)) {
            deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg5);
            return
        };
        let v0 = 0x2::coin::value<T0>(&arg5);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg5);
            return
        };
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::order_params<T0>(arg1);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::exec_fee(&v1);
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::free_balance<T0>(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2));
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v0 <= v4, 13842661783781769265);
        let v5 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg4, arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::credit_close_fee<T0>(&v5, arg0, arg2, arg3, arg5);
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

    fun observe_refund<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt) {
        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1) || 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(arg2)) {
            return
        };
        0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::observe(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq_mut<T0>(arg0, arg1), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::price_wad(arg2), 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::timestamp_ms(arg2));
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

    public fun owner<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.owner
    }

    public fun pending_open_orders<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::pending_orders<T0>(arg0) - 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::pending_close_count<T0>(arg0)
    }

    public fun position_id<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.position_id
    }

    public fun refund_blocked_cleanup<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u8 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg6)), 13835060898550513665);
        assert!(arg4.kind == 0, 13836186802752847881);
        assert!(arg4.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), 13835623857094131717);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4.fill_deadline_ms, 13837031236273307663);
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::pending_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg1), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2)) > 0 && 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::reconcile_halted<T0>(arg1, arg3), 13841816328059093035);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg3, arg0);
        let (v1, v2) = finalize<T0>(&v0, arg0, arg2, arg3, arg4, true, arg6);
        emit_final(&v0, v1, 0, 14, 0, 0, 0, v2, arg5, arg6);
        14
    }

    public fun request_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg2, arg3);
        fund_close_fee<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, false, arg8, arg9))
    }

    public fun request_close_as_delegate<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_close_delegate<T0>(arg2, arg6, arg7);
        share<T0>(request_close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, true, arg6, arg7))
    }

    public fun request_close_as_delegate_until<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 13843785166838300729);
        request_close_as_delegate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8)
    }

    fun request_close_inner<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::status<T0>(arg1);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1) && (v0 == 1 || v0 == 2), 13839284586571104285);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_pending<T0>(arg1), 13840691978635051045);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::has_position<T0>(arg2, arg4), 13839566083022782495);
        let (v1, v2, v3) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::position_summary<T0>(arg2, arg4);
        assert!(v1 == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13839566091612717087);
        assert!(!0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::is_pending(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg1), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), arg4), 13839566104497618975);
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::timing<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg7) >= v3 + 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::min_hold_ms(&v4), 13839847583769428001);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::has_pending_close<T0>(arg2, arg4), 13838440213180317721);
        create<T0>(arg0, arg1, arg2, arg3, 1, v2, 0, 0, arg4, arg5, 0, 0, 0x1::option::none<u32>(), 0, arg6, arg7, arg8)
    }

    public fun request_open<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: 0x1::option::Option<u32>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg2, arg3);
        deposit_top_up<T0>(arg0, arg2, arg3, arg4, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false, arg12, arg13))
    }

    public fun request_open_as_delegate<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_delegate<T0>(arg2, arg10, arg11);
        share<T0>(request_open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, arg10, arg11))
    }

    fun request_open_inner<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: 0x1::option::Option<u32>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : OrderRequest<T0> {
        assert_request_prelude<T0>(arg0, arg1, arg2, arg3);
        let v0 = if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_paused(arg3)) {
            if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::opens_paused<T0>(arg1)) {
                if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::closes_paused(arg3)) {
                    if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closes_paused<T0>(arg1)) {
                        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::enabled<T0>(arg1)) {
                            if (!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg1)) {
                                0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::status<T0>(arg1) == 1
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
        assert!(v0, 13839284436247248925);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_pending<T0>(arg1), 13840691819721261093);
        assert!(0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::open_risk_code<T0>(arg1, arg3, arg4, arg5) != 4, 13840410349039386659);
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::assert_open_risk<T0>(arg1, arg3, arg4, arg5);
        assert!(pending_open_orders<T0>(arg2) < 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::max_pending_orders(arg3), 13838158562109816855);
        assert!(arg7 <= 10000, 13842380691057016879);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::builder::request_fee_ceiling<T0>(arg0, arg3, arg9, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2));
        create<T0>(arg0, arg1, arg2, arg3, 0, arg6, arg4, arg5, 0, arg8, arg7, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::trade::taker_bps<T0>(arg1, arg3), arg9, v1, arg10, arg11, arg12)
    }

    public fun requested_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.requested_ms
    }

    public fun requester<T0>(arg0: &OrderRequest<T0>) : address {
        arg0.requester
    }

    fun revoked_at_cancel_point<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg1: &OrderRequest<T0>, arg2: u64) : bool {
        arg2 >= cancel_after_ms<T0>(arg1) && delegate_not_live<T0>(arg0, arg1, arg2)
    }

    public fun session_refund<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: OrderRequest<T0>, arg5: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_version<T0>(arg2);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg7)), 13835061465486196737);
        assert!(arg4.account_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), 13835624419734847493);
        assert!(arg4.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13835905899006656519);
        assert!(0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::market_id(&arg5) == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1), 13835905903301623815);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::SessionCloseV1>(&v0), 13840972461474447399);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::sc_ts_ms(0x1::option::borrow<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::SessionCloseV1>(&v0));
        let v2 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::conf_timestamp_ms(&arg5);
        let v3 = if (0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::is_closed(&arg5)) {
            if (v2 == v1) {
                if (arg4.requested_ms >= v1) {
                    0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::message_ms(&arg5) > arg4.requested_ms
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13841253970811027497);
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle::discard_price(arg5);
        let v4 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_refund<T0>(arg3, arg0);
        let (v5, v6) = finalize<T0>(&v4, arg0, arg2, arg3, arg4, true, arg7);
        emit_final(&v4, v5, arg4.kind, 13, arg4.position_id, 0, v2, v6, arg6, arg7);
    }

    fun share<T0>(arg0: OrderRequest<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<OrderRequest<T0>>(arg0);
        0x2::object::id<OrderRequest<T0>>(&arg0)
    }

    public fun signed_window_ms<T0>(arg0: &OrderRequest<T0>) : u64 {
        arg0.signed_window_ms
    }

    public fun via_delegate<T0>(arg0: &OrderRequest<T0>) : bool {
        arg0.via_delegate
    }

    // decompiled from Move bytecode v7
}

