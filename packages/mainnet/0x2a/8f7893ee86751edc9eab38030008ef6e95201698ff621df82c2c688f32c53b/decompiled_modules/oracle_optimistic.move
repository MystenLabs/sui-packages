module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::oracle_optimistic {
    struct OptimisticResolver<phantom T0> has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        bond_e6: u64,
        challenge_window_ms: u64,
        phase: u8,
        proposed_outcome: u8,
        proposer: address,
        proposed_at_ms: u64,
        challenger: address,
        vault: 0x2::balance::Balance<T0>,
    }

    public fun arbitrate<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut OptimisticResolver<T0>, arg3: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(arg2.protocol_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert_resolver_market<T0>(arg2, arg3);
        assert!(arg2.phase == 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_phase());
        assert_outcome_valid(arg4);
        let (v0, v1) = payouts_for(arg4);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::set_resolution<T0>(arg3, arg4, v0, v1, arg5);
        let v2 = if (arg4 == arg2.proposed_outcome) {
            arg2.proposer
        } else {
            arg2.challenger
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.vault, arg2.bond_e6 + arg2.bond_e6 / 2), arg6), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.vault), arg6), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::fee_recipient<T0>(arg3));
        arg2.phase = 3;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_resolution_finalized(arg2.protocol_id, arg2.market_id, 0x2::object::id<OptimisticResolver<T0>>(arg2), arg4, true, v2, 0x2::balance::value<T0>(&arg2.vault));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_resolved(arg2.protocol_id, arg2.market_id, arg4, v0, v1, 0, false, 0, 0x2::clock::timestamp_ms(arg5));
    }

    fun assert_outcome_valid(arg0: u8) {
        let v0 = if (arg0 == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_yes()) {
            true
        } else if (arg0 == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_no()) {
            true
        } else {
            arg0 == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_invalid()
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_outcome());
    }

    fun assert_resolver_market<T0>(arg0: &OptimisticResolver<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>) {
        assert!(arg0.market_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_market_mismatch());
    }

    public fun bond_e6<T0>(arg0: &OptimisticResolver<T0>) : u64 {
        arg0.bond_e6
    }

    public fun challenge<T0>(arg0: &mut OptimisticResolver<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_phase());
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.proposed_at_ms + arg0.challenge_window_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::challenge_window_closed());
        assert!(0x2::coin::value<T0>(&arg1) == arg0.bond_e6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bond_mismatch());
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        arg0.phase = 2;
        arg0.challenger = 0x2::tx_context::sender(arg3);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_resolution_challenged(arg0.protocol_id, arg0.market_id, 0x2::object::id<OptimisticResolver<T0>>(arg0), 0x2::tx_context::sender(arg3), arg0.bond_e6);
    }

    public fun create_resolver<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg2) == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind<T0>(arg2) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind_optimistic(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::oracle_kind_mismatch());
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg4 <= 2592000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        let v1 = OptimisticResolver<T0>{
            id                  : 0x2::object::new(arg5),
            protocol_id         : 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1),
            market_id           : 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg2),
            bond_e6             : arg3,
            challenge_window_ms : arg4,
            phase               : 0,
            proposed_outcome    : 0,
            proposer            : @0x0,
            proposed_at_ms      : 0,
            challenger          : @0x0,
            vault               : 0x2::balance::zero<T0>(),
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::bind_resolver<T0>(arg2, 0x2::object::id<OptimisticResolver<T0>>(&v1));
        0x2::transfer::share_object<OptimisticResolver<T0>>(v1);
    }

    public fun finalize_unchallenged<T0>(arg0: &mut OptimisticResolver<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_resolver_market<T0>(arg0, arg1);
        assert!(arg0.phase == 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_phase());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.proposed_at_ms + arg0.challenge_window_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::challenge_window_open());
        let v0 = arg0.proposed_outcome;
        let (v1, v2) = payouts_for(v0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::set_resolution<T0>(arg1, v0, v1, v2, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg3), arg0.proposer);
        arg0.phase = 3;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_resolution_finalized(arg0.protocol_id, arg0.market_id, 0x2::object::id<OptimisticResolver<T0>>(arg0), v0, false, arg0.proposer, 0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_resolved(arg0.protocol_id, arg0.market_id, v0, v1, v2, 0, false, 0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun invalidate_after_deadline<T0>(arg0: &mut OptimisticResolver<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_resolver_market<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle<T0>(arg1);
        let v2 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_resolve_deadline_ms(&v1);
        assert!(v0 >= v2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_too_early());
        if (arg0.phase == 2) {
            assert!(v0 >= v2 + 604800000, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_invalidate_blocked());
        } else {
            assert!(arg0.phase == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_invalidate_blocked());
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::set_resolution<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_invalid(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6(), arg2);
        if (arg0.phase == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg0.bond_e6), arg3), arg0.proposer);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg3), arg0.challenger);
        };
        arg0.phase = 3;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_invalidated(arg0.protocol_id, arg0.market_id);
    }

    fun payouts_for(arg0: u8) : (u64, u64) {
        if (arg0 == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_yes()) {
            (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_full_e6(), 0)
        } else if (arg0 == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_no()) {
            (0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_full_e6())
        } else {
            (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6())
        }
    }

    public fun phase<T0>(arg0: &OptimisticResolver<T0>) : u8 {
        arg0.phase
    }

    public fun phase_challenged() : u8 {
        2
    }

    public fun phase_done() : u8 {
        3
    }

    public fun phase_idle() : u8 {
        0
    }

    public fun phase_proposed() : u8 {
        1
    }

    public fun propose<T0>(arg0: &mut OptimisticResolver<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_resolver_market<T0>(arg0, arg1);
        assert!(arg0.phase == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_phase());
        assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::is_terminal_status(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status<T0>(arg1)), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_terminal());
        assert_outcome_valid(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle<T0>(arg1);
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_target_timestamp_ms(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::propose_too_early());
        assert!(v0 < 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_resolve_deadline_ms(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::propose_too_late());
        assert!(0x2::coin::value<T0>(&arg3) == arg0.bond_e6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bond_mismatch());
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg3));
        arg0.phase = 1;
        arg0.proposed_outcome = arg2;
        arg0.proposer = 0x2::tx_context::sender(arg5);
        arg0.proposed_at_ms = v0;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_resolution_proposed(arg0.protocol_id, arg0.market_id, 0x2::object::id<OptimisticResolver<T0>>(arg0), arg2, 0x2::tx_context::sender(arg5), arg0.bond_e6, v0, arg0.challenge_window_ms);
    }

    public fun proposed_outcome<T0>(arg0: &OptimisticResolver<T0>) : u8 {
        arg0.proposed_outcome
    }

    public fun resolver_market_id<T0>(arg0: &OptimisticResolver<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun vault_value<T0>(arg0: &OptimisticResolver<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}

