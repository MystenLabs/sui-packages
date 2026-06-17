module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core {
    struct MarketCore<phantom T0> has key {
        id: 0x2::object::UID,
        asset_type: 0x1::type_name::TypeName,
        maturity_ms: u64,
        adapter_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        market_package_id: 0x2::object::ID,
        pt_type: 0x1::type_name::TypeName,
        yt_vault_type: 0x1::type_name::TypeName,
        pt_vault_id: 0x1::option::Option<0x2::object::ID>,
        yt_vault_id: 0x1::option::Option<0x2::object::ID>,
        treasury_id: 0x2::object::ID,
        yt_extract_ratio_bps: u16,
        claim_fee_bps: u16,
        redeem_fee_bps: u16,
        combine_fee_bps: u16,
        entry_pause: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::PauseState,
        hard_cap_breached: bool,
        watermark: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::Watermark,
    }

    public fun id<T0>(arg0: &MarketCore<T0>) : 0x2::object::ID {
        0x2::object::id<MarketCore<T0>>(arg0)
    }

    public fun new<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u64, arg10: u64, arg11: u64, arg12: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg13: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (MarketCore<T0>, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::treasury::Treasury<T0>) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt_with_payload(arg12, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_create_market(), arg0, create_market_payload_hash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg14);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg14), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_maturity_in_past());
        assert!(arg5 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::protocol_max_yt_ratio_bps(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_protocol_cap_exceeded());
        assert!(arg6 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::protocol_max_fee_bps(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_invalid_bps());
        assert!(arg7 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::protocol_max_fee_bps(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_invalid_bps());
        assert!(arg8 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::protocol_max_fee_bps(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_invalid_bps());
        let v0 = 0x2::object::new(arg15);
        let v1 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::auth_type_of<T1>();
        let v2 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::treasury::new<T0>(0x2::object::uid_to_inner(&v0), v1, arg15);
        let v3 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::treasury::id<T0>(&v2);
        let v4 = MarketCore<T0>{
            id                   : v0,
            asset_type           : 0x1::type_name::with_original_ids<T0>(),
            maturity_ms          : arg4,
            adapter_id           : arg0,
            adapter_auth_type    : v1,
            market_package_id    : arg1,
            pt_type              : arg2,
            yt_vault_type        : arg3,
            pt_vault_id          : 0x1::option::none<0x2::object::ID>(),
            yt_vault_id          : 0x1::option::none<0x2::object::ID>(),
            treasury_id          : v3,
            yt_extract_ratio_bps : arg5,
            claim_fee_bps        : arg6,
            redeem_fee_bps       : arg7,
            combine_fee_bps      : arg8,
            entry_pause          : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::new(),
            hard_cap_breached    : false,
            watermark            : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::new(arg9, arg10, arg11),
        };
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_market_created(0x2::object::id<MarketCore<T0>>(&v4), v4.asset_type, arg4, arg1, arg2, arg3, arg5, arg6, arg7, arg8, v3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_adapter_registered(arg0, v4.asset_type, 1);
        (v4, v2)
    }

    public fun adapter_auth_type<T0>(arg0: &MarketCore<T0>) : 0x1::type_name::TypeName {
        arg0.adapter_auth_type
    }

    public fun adapter_auth_type_ref<T0>(arg0: &MarketCore<T0>) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun adapter_id<T0>(arg0: &MarketCore<T0>) : 0x2::object::ID {
        arg0.adapter_id
    }

    public fun assert_entry_open<T0>(arg0: &MarketCore<T0>, arg1: u64) {
        assert!(!arg0.hard_cap_breached, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_hard_cap_breached());
        assert!(arg1 < arg0.maturity_ms, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_already_matured());
        assert!(!0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::is_paused(&arg0.entry_pause, arg1), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_entry_paused());
    }

    public fun assert_registered_pt_vault<T0>(arg0: &MarketCore<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pt_vault_id), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_vault_not_registered());
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.pt_vault_id) == arg1, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_market_core());
    }

    public fun assert_registered_yt_vault<T0>(arg0: &MarketCore<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.yt_vault_id), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_vault_not_registered());
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.yt_vault_id) == arg1, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_market_core());
    }

    public fun asset_type<T0>(arg0: &MarketCore<T0>) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun claim_fee_bps<T0>(arg0: &MarketCore<T0>) : u16 {
        arg0.claim_fee_bps
    }

    public fun clear_entry_pause<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg3: &0x2::clock::Clock) {
        let v0 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_kind(&arg0.entry_pause);
        assert!(v0 != 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_none() && 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::is_paused(&arg0.entry_pause, 0x2::clock::timestamp_ms(arg3)), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_not_paused());
        let v1 = if (v0 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_hard_cap()) {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_unpause_hard_cap()
        } else if (v0 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_watermark()) {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_unpause_after_watermark()
        } else {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_unpause_market()
        };
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt(arg2, v1, 0x2::object::id<MarketCore<T0>>(arg0), arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::clear(&mut arg0.entry_pause);
        if (v0 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_hard_cap()) {
            arg0.hard_cap_breached = false;
        };
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_unpaused(0, 0x2::object::id<MarketCore<T0>>(arg0));
    }

    public fun combine_fee_bps<T0>(arg0: &MarketCore<T0>) : u16 {
        arg0.combine_fee_bps
    }

    public fun create_market_payload_hash<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u64, arg10: u64, arg11: u64) : vector<u8> {
        let v0 = b"nemo:create_market:v1";
        let v1 = 0x1::type_name::with_original_ids<T0>();
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x1::type_name::TypeName>(&mut v0, &v1);
        let v2 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::auth_type_of<T1>();
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x1::type_name::TypeName>(&mut v0, &v2);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x2::object::ID>(&mut v0, &arg0);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x2::object::ID>(&mut v0, &arg1);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x1::type_name::TypeName>(&mut v0, &arg2);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x1::type_name::TypeName>(&mut v0, &arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg4);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u16>(&mut v0, &arg5);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u16>(&mut v0, &arg6);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u16>(&mut v0, &arg7);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u16>(&mut v0, &arg8);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg9);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg10);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg11);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::hash_payload(v0)
    }

    public fun emit_adapter_paused_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: vector<u8>) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg2 == arg0.adapter_id, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_adapter());
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_adapter_paused(arg2, arg3, arg4, arg5);
    }

    public fun emit_adapter_unpaused_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg2 == arg0.adapter_id, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_adapter());
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_adapter_unpaused(arg2);
    }

    public fun emit_combine_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_combine(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun emit_fee_collected_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_fee_collected(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5);
    }

    public fun emit_pt_redeemed_direct_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_pt_redeemed_direct(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5);
    }

    public fun emit_pt_redeemed_from_vault_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_pt_redeemed_from_vault(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun emit_split_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u128) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_split(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun emit_vault_collect_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_vault_collect(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun emit_watermark_violation_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_watermark_violation(arg0.adapter_id, arg0.asset_type, arg2, arg3, arg4, arg5, arg6);
    }

    public fun emit_yield_claimed_for_adapter<T0, T1: drop>(arg0: &MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u64) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_yield_claimed(0x2::object::id<MarketCore<T0>>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun entry_is_open<T0>(arg0: &MarketCore<T0>, arg1: u64) : bool {
        if (arg0.hard_cap_breached) {
            return false
        };
        if (arg1 >= arg0.maturity_ms) {
            return false
        };
        !0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::is_paused(&arg0.entry_pause, arg1)
    }

    public fun entry_pause_ref<T0>(arg0: &MarketCore<T0>) : &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::PauseState {
        &arg0.entry_pause
    }

    public fun hard_cap_breached<T0>(arg0: &MarketCore<T0>) : bool {
        arg0.hard_cap_breached
    }

    public(friend) fun hard_cap_pause_entry<T0>(arg0: &mut MarketCore<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        arg0.hard_cap_breached = true;
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::set_hard_cap(&mut arg0.entry_pause, arg4);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_paused(0, 0x2::object::id<MarketCore<T0>>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_hard_cap(), 0, b"hard-cap breached");
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_hard_cap_breached(0x2::object::id<MarketCore<T0>>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun market_package_id<T0>(arg0: &MarketCore<T0>) : 0x2::object::ID {
        arg0.market_package_id
    }

    public fun maturity_ms<T0>(arg0: &MarketCore<T0>) : u64 {
        arg0.maturity_ms
    }

    public fun pt_type<T0>(arg0: &MarketCore<T0>) : 0x1::type_name::TypeName {
        arg0.pt_type
    }

    public fun pt_vault_id<T0>(arg0: &MarketCore<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pt_vault_id
    }

    public fun redeem_fee_bps<T0>(arg0: &MarketCore<T0>) : u16 {
        arg0.redeem_fee_bps
    }

    public fun register_vault_payload_hash(arg0: 0x2::object::ID) : vector<u8> {
        let v0 = b"nemo:register_vault:v1";
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<0x2::object::ID>(&mut v0, &arg0);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::hash_payload(v0)
    }

    public fun scope_entry() : u8 {
        0
    }

    public fun set_entry_pause_global<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::PauseCap, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::set_global(&mut arg0.entry_pause, arg2, 0x2::clock::timestamp_ms(arg4));
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_paused(0, 0x2::object::id<MarketCore<T0>>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_global(), arg2, arg3);
    }

    public fun set_entry_pause_scoped<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::PauseCap, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::set_scoped(&mut arg0.entry_pause, arg2, 0x2::clock::timestamp_ms(arg4));
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_paused(0, 0x2::object::id<MarketCore<T0>>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_scoped(), arg2, arg3);
    }

    public(friend) fun set_entry_pause_watermark<T0>(arg0: &mut MarketCore<T0>, arg1: u64) {
        if (0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::set_watermark(&mut arg0.entry_pause, arg1)) {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_paused(0, 0x2::object::id<MarketCore<T0>>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_watermark(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::max_global_pause_ttl_ms(), b"watermark violation");
        } else {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_watermark_observed_during_pause(0, 0x2::object::id<MarketCore<T0>>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_kind(&arg0.entry_pause), arg1);
        };
    }

    public fun set_entry_pause_watermark_for_adapter<T0, T1: drop>(arg0: &mut MarketCore<T0>, arg1: &T1, arg2: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        set_entry_pause_watermark<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun set_pt_vault_id<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg5: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt_with_payload(arg4, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_register_pt_vault(), 0x2::object::id<MarketCore<T0>>(arg0), register_vault_payload_hash(arg2), arg5);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pt_vault_id), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_vault_already_registered());
        0x1::option::fill<0x2::object::ID>(&mut arg0.pt_vault_id, arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_pt_vault_registered(0x2::object::id<MarketCore<T0>>(arg0), arg3, arg0.pt_type);
    }

    public fun set_watermark_thresholds<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg6: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt_with_payload(arg5, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_set_watermark_thresholds(), 0x2::object::id<MarketCore<T0>>(arg0), set_watermark_thresholds_payload_hash(arg2, arg3, arg4), arg6);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_drop_bps(&mut arg0.watermark, arg2);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_spike_apy_e9(&mut arg0.watermark, arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_cumulative_apy_e9(&mut arg0.watermark, arg4);
    }

    public fun set_watermark_thresholds_payload_hash(arg0: u64, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"nemo:set_watermark_thresholds:v1";
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg0);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg1);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::append_bcs<u64>(&mut v0, &arg2);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::hash_payload(v0)
    }

    public fun set_yt_vault_id<T0>(arg0: &mut MarketCore<T0>, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg5: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt_with_payload(arg4, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_register_yt_vault(), 0x2::object::id<MarketCore<T0>>(arg0), register_vault_payload_hash(arg2), arg5);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.yt_vault_id), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_vault_already_registered());
        0x1::option::fill<0x2::object::ID>(&mut arg0.yt_vault_id, arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_yt_vault_registered(0x2::object::id<MarketCore<T0>>(arg0), arg3, arg0.yt_vault_type);
    }

    public fun share<T0>(arg0: MarketCore<T0>) {
        0x2::transfer::share_object<MarketCore<T0>>(arg0);
    }

    public fun treasury_id<T0>(arg0: &MarketCore<T0>) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun try_auto_expire_entry<T0>(arg0: &mut MarketCore<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let (v1, v2) = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::try_auto_expire(&mut arg0.entry_pause, v0);
        if (v1) {
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events::emit_pause_auto_expired(0, 0x2::object::id<MarketCore<T0>>(arg0), v2, v0);
        };
        v1
    }

    public fun watermark<T0>(arg0: &MarketCore<T0>) : &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::Watermark {
        &arg0.watermark
    }

    public(friend) fun watermark_mut<T0>(arg0: &mut MarketCore<T0>) : &mut 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::Watermark {
        &mut arg0.watermark
    }

    public fun yt_extract_ratio_bps<T0>(arg0: &MarketCore<T0>) : u16 {
        arg0.yt_extract_ratio_bps
    }

    public fun yt_vault_id<T0>(arg0: &MarketCore<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.yt_vault_id
    }

    public fun yt_vault_type<T0>(arg0: &MarketCore<T0>) : 0x1::type_name::TypeName {
        arg0.yt_vault_type
    }

    // decompiled from Move bytecode v7
}

