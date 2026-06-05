module 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::redemption {
    struct EpochState<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        opened_at_ms: u64,
        closed_at_ms: u64,
        finalized_at_ms: u64,
        total_shares_locked: u128,
        total_usdc_delivered: u64,
        payout_pool: 0x2::balance::Balance<T0>,
        requests_total: u64,
        requests_claimed: u64,
        status: u8,
    }

    struct RedemptionRequest has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        owner: address,
        shares_locked: u128,
        requested_at_ms: u64,
    }

    public fun bootstrap_genesis_epoch<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::VaultAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::assert_admin_cap<T0>(arg0, arg1);
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_id<T0>(arg0) == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_already_open());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::advance_epoch<T0>(arg0, v0) == 1, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        let v1 = EpochState<T0>{
            id                   : 0x2::object::new(arg3),
            vault_id             : 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::id<T0>(arg0),
            epoch_id             : 1,
            opened_at_ms         : v0,
            closed_at_ms         : 0,
            finalized_at_ms      : 0,
            total_shares_locked  : 0,
            total_usdc_delivered : 0,
            payout_pool          : 0x2::balance::zero<T0>(),
            requests_total       : 0,
            requests_claimed     : 0,
            status               : 0,
        };
        0x2::transfer::share_object<EpochState<T0>>(v1);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_opened(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_opened(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::id<T0>(arg0), 1, 0x2::object::id<EpochState<T0>>(&v1), v0));
    }

    fun build_and_record_request<T0>(arg0: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &mut EpochState<T0>, arg2: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::ShareReceipt, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : RedemptionRequest {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::deduct(arg2, arg3);
        arg1.total_shares_locked = arg1.total_shares_locked + arg3;
        arg1.requests_total = arg1.requests_total + 1;
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = RedemptionRequest{
            id              : 0x2::object::new(arg5),
            vault_id        : 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0),
            epoch_id        : arg1.epoch_id,
            owner           : v1,
            shares_locked   : arg3,
            requested_at_ms : v0,
        };
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_redemption_requested(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_redemption_requested(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x2::object::id<RedemptionRequest>(&v2), v1, arg3, arg1.epoch_id, v0));
        v2
    }

    public fun claim_redemption<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::registry::VaultRegistry, arg2: &mut EpochState<T0>, arg3: RedemptionRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::assert_registry_active<T0>(arg0, arg1);
        assert!(arg2.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg3.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg3.epoch_id == arg2.epoch_id, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        assert!(arg2.status == 2, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_finalized());
        assert!(0x2::tx_context::sender(arg5) == arg3.owner, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::not_request_owner());
        let RedemptionRequest {
            id              : v0,
            vault_id        : _,
            epoch_id        : _,
            owner           : v3,
            shares_locked   : v4,
            requested_at_ms : _,
        } = arg3;
        let v6 = v0;
        let v7 = (0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::mul_div((arg2.total_usdc_delivered as u128), v4, arg2.total_shares_locked) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.payout_pool, v7), arg5), v3);
        arg2.requests_claimed = arg2.requests_claimed + 1;
        0x2::object::delete(v6);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_claimed(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_claimed(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x2::object::uid_to_inner(&v6), arg2.epoch_id, v3, v4, v7, 0x2::clock::timestamp_ms(arg4)));
    }

    public fun close_current_epoch<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &mut EpochState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg1.epoch_id == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_id<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        assert!(arg1.status == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_open());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_started_at_ms<T0>(arg0) + 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::epoch_duration_ms<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_duration_not_elapsed());
        arg1.status = 1;
        arg1.closed_at_ms = v0;
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::set_current_epoch_closed_at_ms<T0>(arg0, v0);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_closed(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_closed(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), arg1.epoch_id, v0, arg1.total_shares_locked, arg1.requests_total));
    }

    public fun destroy_empty_epoch<T0>(arg0: EpochState<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg1), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        let v0 = arg0.status;
        assert!(v0 == 3 || v0 == 2 && arg0.requests_claimed == arg0.requests_total, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::requests_not_all_claimed());
        let EpochState {
            id                   : v1,
            vault_id             : _,
            epoch_id             : _,
            opened_at_ms         : _,
            closed_at_ms         : _,
            finalized_at_ms      : _,
            total_shares_locked  : _,
            total_usdc_delivered : _,
            payout_pool          : v9,
            requests_total       : _,
            requests_claimed     : _,
            status               : _,
        } = arg0;
        let v13 = v9;
        let v14 = 0x2::balance::value<T0>(&v13);
        if (v14 == 0) {
            0x2::balance::destroy_zero<T0>(v13);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg2), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::fee_recipient<T0>(arg1));
        };
        0x2::object::delete(v1);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_destroyed(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_destroyed(arg0.vault_id, arg0.epoch_id, v14));
    }

    public fun emergency_claim_locked<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &mut EpochState<T0>, arg2: RedemptionRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::emergency_mode<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::not_emergency_mode());
        assert!(arg1.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg2.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg2.epoch_id == arg1.epoch_id, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        assert!(arg1.status == 0 || arg1.status == 1, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_open());
        assert!(0x2::tx_context::sender(arg4) == arg2.owner, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::not_request_owner());
        let RedemptionRequest {
            id              : v0,
            vault_id        : _,
            epoch_id        : _,
            owner           : v3,
            shares_locked   : v4,
            requested_at_ms : _,
        } = arg2;
        let v6 = (0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::mul_div((0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::idle_usdc_value<T0>(arg0) as u128), v4, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::total_shares<T0>(arg0)) as u64);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::burn_shares_from_total<T0>(arg0, v4);
        arg1.total_shares_locked = arg1.total_shares_locked - v4;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::take_idle<T0>(arg0, v6), arg4), v3);
        };
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::reduce_nav_scaled_saturating<T0>(arg0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::usdc_to_nav_scaled((v6 as u128)));
        arg1.requests_total = arg1.requests_total - 1;
        0x2::object::delete(v0);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_emergency_withdraw(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_emergency_withdraw(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), v3, v4, v6, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::idle_usdc_value<T0>(arg0), 0x2::clock::timestamp_ms(arg3)));
    }

    public fun epoch_closed_at_ms<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.closed_at_ms
    }

    public fun epoch_finalized_at_ms<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.finalized_at_ms
    }

    public fun epoch_id<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.epoch_id
    }

    public fun epoch_opened_at_ms<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.opened_at_ms
    }

    public fun epoch_requests_claimed<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.requests_claimed
    }

    public fun epoch_requests_total<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.requests_total
    }

    public fun epoch_status<T0>(arg0: &EpochState<T0>) : u8 {
        arg0.status
    }

    public fun epoch_status_closed() : u8 {
        1
    }

    public fun epoch_status_empty() : u8 {
        3
    }

    public fun epoch_status_finalized() : u8 {
        2
    }

    public fun epoch_status_open() : u8 {
        0
    }

    public fun epoch_total_shares_locked<T0>(arg0: &EpochState<T0>) : u128 {
        arg0.total_shares_locked
    }

    public fun epoch_total_usdc_delivered<T0>(arg0: &EpochState<T0>) : u64 {
        arg0.total_usdc_delivered
    }

    public fun epoch_vault_id<T0>(arg0: &EpochState<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun finalize_empty_epoch<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &mut EpochState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg1.status == 1, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_closed());
        assert!(arg1.total_shares_locked == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_empty());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.status = 3;
        arg1.finalized_at_ms = v0;
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_finalized(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_finalized(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), arg1.epoch_id, 0, 0, v0));
    }

    public fun finalize_epoch<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::registry::VaultRegistry, arg2: &mut EpochState<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::assert_registry_active<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg5) == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::fulfiller_authority<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::not_fulfiller_authority());
        assert!(arg2.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg2.status == 1, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_closed());
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::is_ramping<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::vault_ramping_finalize());
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!((v0 as u128) <= 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::mul_div(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::nav_scaled_to_usdc(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::mul_div(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::last_reported_nav_scaled<T0>(arg0), arg2.total_shares_locked, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::total_shares<T0>(arg0))), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::bps_denominator() + (500 as u128), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::bps_denominator()), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::delivered_exceeds_fair_value());
        arg2.total_usdc_delivered = v0;
        0x2::balance::join<T0>(&mut arg2.payout_pool, 0x2::coin::into_balance<T0>(arg3));
        arg2.status = 2;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        arg2.finalized_at_ms = v1;
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::burn_shares_from_total<T0>(arg0, arg2.total_shares_locked);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::reduce_nav_scaled<T0>(arg0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::math::usdc_to_nav_scaled((v0 as u128)));
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_finalized(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_finalized(0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), arg2.epoch_id, v0, arg2.total_shares_locked, v1));
    }

    public fun finalize_tolerance_bps() : u64 {
        500
    }

    public fun open_next_epoch<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_closed_at_ms<T0>(arg0) != 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_closed());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::advance_epoch<T0>(arg0, v0);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::set_current_epoch_closed_at_ms<T0>(arg0, 0);
        let v2 = EpochState<T0>{
            id                   : 0x2::object::new(arg2),
            vault_id             : 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::id<T0>(arg0),
            epoch_id             : v1,
            opened_at_ms         : v0,
            closed_at_ms         : 0,
            finalized_at_ms      : 0,
            total_shares_locked  : 0,
            total_usdc_delivered : 0,
            payout_pool          : 0x2::balance::zero<T0>(),
            requests_total       : 0,
            requests_claimed     : 0,
            status               : 0,
        };
        0x2::transfer::share_object<EpochState<T0>>(v2);
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::emit_epoch_opened(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::events::new_epoch_opened(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::id<T0>(arg0), v1, 0x2::object::id<EpochState<T0>>(&v2), v0));
    }

    public fun request_epoch_id(arg0: &RedemptionRequest) : u64 {
        arg0.epoch_id
    }

    public fun request_owner(arg0: &RedemptionRequest) : address {
        arg0.owner
    }

    public fun request_redemption<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::registry::VaultRegistry, arg2: &mut EpochState<T0>, arg3: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::ShareReceipt, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::assert_registry_active<T0>(arg0, arg1);
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::emergency_mode<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::emergency_mode_active());
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::paused_redemptions<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::redemptions_paused());
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::is_ramping<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::vault_ramping_redeem());
        assert!(arg2.status == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_open());
        assert!(arg2.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg2.epoch_id == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_id<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::vault_id(arg3) == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg4 > 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::insufficient_shares());
        if (0x2::tx_context::sender(arg6) == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::creator<T0>(arg0)) {
            assert!(0x2::clock::timestamp_ms(arg5) >= 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::creator_lockup_until_ms<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::lockup_active());
        };
        let v0 = build_and_record_request<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<RedemptionRequest>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun request_redemption_returning<T0>(arg0: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>, arg1: &0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::registry::VaultRegistry, arg2: &mut EpochState<T0>, arg3: &mut 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::ShareReceipt, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : RedemptionRequest {
        0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::assert_registry_active<T0>(arg0, arg1);
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::emergency_mode<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::emergency_mode_active());
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::paused_redemptions<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::redemptions_paused());
        assert!(!0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::is_ramping<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::vault_ramping_redeem());
        assert!(arg2.status == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_not_open());
        assert!(arg2.vault_id == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg2.epoch_id == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::current_epoch_id<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::epoch_wrong_id());
        assert!(0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares::vault_id(arg3) == 0x2::object::id<0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::Vault<T0>>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        assert!(arg4 > 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::insufficient_shares());
        if (0x2::tx_context::sender(arg6) == 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::creator<T0>(arg0)) {
            assert!(0x2::clock::timestamp_ms(arg5) >= 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::vault::creator_lockup_until_ms<T0>(arg0), 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::lockup_active());
        };
        build_and_record_request<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_shares_locked(arg0: &RedemptionRequest) : u128 {
        arg0.shares_locked
    }

    public fun request_vault_id(arg0: &RedemptionRequest) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

