module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::guard_savings {
    struct GuardSavingsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SPState has store {
        pool_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        balance: u64,
        pending_collateral: bool,
        liquidation_nonce: u64,
        claimed_nonce: u64,
    }

    struct GuardSavingsVault has key {
        id: 0x2::object::UID,
        version: u64,
        gdori_supply: 0x2::balance::Supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>,
        total_staked: u64,
        allocations: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        sp_states: 0x2::table::Table<0x2::object::ID, SPState>,
        sp_ids: vector<0x2::object::ID>,
        stakers: 0x2::object_bag::ObjectBag,
    }

    struct DepositSnapshot has copy, drop, store {
        pool_id: 0x2::object::ID,
        expected_amount: u64,
    }

    struct DepositTicket {
        snapshots: vector<DepositSnapshot>,
        pools_remaining: u64,
        total_dori: u64,
        expected_gdori: u64,
        dori_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
    }

    struct DepositTicketV2 {
        vault_id: 0x2::object::ID,
        min_gdori_out: u64,
        snapshots: vector<DepositSnapshot>,
        total_dori: u64,
        dori_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
    }

    struct WithdrawSnapshot has copy, drop, store {
        pool_id: 0x2::object::ID,
        pro_rata_amount: u64,
    }

    struct WithdrawTicket {
        snapshots: vector<WithdrawSnapshot>,
        pools_remaining: u64,
        total_entitled: u64,
    }

    struct WithdrawSyncTicketV2 {
        vault_id: 0x2::object::ID,
        min_dori_out: u64,
        pool_ids: vector<0x2::object::ID>,
        gdori_balance: 0x2::balance::Balance<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>,
    }

    struct WithdrawTicketV2 {
        vault_id: 0x2::object::ID,
        snapshots: vector<WithdrawSnapshot>,
    }

    public fun admin_claim_collateral<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &GuardSavingsAdminCap, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsStakerNotFound());
        let v1 = 0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0);
        let (v2, v3) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::unstake_v5<T0>(v1, 0, arg1, arg2, arg3, arg4, arg5, true, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v5);
        if (v6 > 0) {
            let (v7, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::update_stake_v5<T0>(v1, v5, arg1, arg2, arg3, arg4, arg5, false, arg7);
            0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v7);
            0x2::coin::destroy_zero<T0>(v8);
        } else {
            0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v5);
        };
        sync_pool_balance_internal<T0>(arg0, arg1);
        let v9 = 0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, v0);
        v9.claimed_nonce = v9.liquidation_nonce;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_collateral_claimed_event(v0, 0x2::coin::value<T0>(&v4), v6);
        v4
    }

    public fun admin_restake_dori<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg7: &GuardSavingsAdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        let v1 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg6);
        assert!(v1 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsStakerNotFound());
        let (v2, v3) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::update_stake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), arg6, arg1, arg2, arg3, arg4, arg5, false, arg8);
        0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v2);
        0x2::coin::destroy_zero<T0>(v3);
        sync_pool_balance_internal<T0>(arg0, arg1);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, v0);
        assert!(v4.claimed_nonce == v4.liquidation_nonce, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsNonceMismatch());
        v4.pending_collateral = false;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_dori_restaked_event(v0, v1, arg0.total_staked);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_dori_restaked_enriched_event(v0, v1, arg0.total_staked, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply), get_exchange_rate(arg0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_settlement_completed_event(v0, 0x2::object::id<GuardSavingsVault>(arg0));
    }

    fun assert_flow(arg0: &GuardSavingsVault, arg1: u64) {
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg0.id, b"v32_flow"), 50);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"v32_flow") == arg1, 50);
    }

    fun assert_version(arg0: &GuardSavingsVault) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    fun begin_flow(arg0: &mut GuardSavingsVault, arg1: u64) {
        assert!(!0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg0.id, b"v32_flow"), 50);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"v32_flow", arg1);
    }

    public fun burn_gdori(arg0: &mut GuardSavingsVault, arg1: 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>, arg2: &0x2::tx_context::TxContext) : WithdrawTicket {
        abort 53
    }

    fun calculate_dori_for_gdori(arg0: &GuardSavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply);
        if (v0 == 0) {
            0
        } else {
            (((arg1 as u128) * (arg0.total_staked as u128) / (v0 as u128)) as u64)
        }
    }

    fun calculate_gdori_for_dori(arg0: &GuardSavingsVault, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply);
        if (v0 == 0) {
            arg1
        } else {
            assert!(arg2 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsNoStakedBalance());
            (((arg1 as u128) * (v0 as u128) / (arg2 as u128)) as u64)
        }
    }

    public fun deposit<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut DepositTicket, arg7: &mut 0x2::tx_context::TxContext) {
        abort 49
    }

    public fun deposit_v2<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut DepositTicketV2, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg6.vault_id == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, arg6.total_dori);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v1 < 0x1::vector::length<DepositSnapshot>(&arg6.snapshots)) {
            if (0x1::vector::borrow<DepositSnapshot>(&arg6.snapshots, v1).pool_id == v0) {
                let v4 = 0x1::vector::remove<DepositSnapshot>(&mut arg6.snapshots, v1);
                v3 = v4.expected_amount;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotInTicket());
        if (0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0)) {
            let (v5, v6) = if (v3 > 0) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::update_stake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg6.dori_balance, v3), arg7), arg1, arg2, arg3, arg4, arg5, false, arg7)
            } else {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::unstake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), 0, arg1, arg2, arg3, arg4, arg5, false, arg7)
            };
            0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v5);
            0x2::coin::destroy_zero<T0>(v6);
        } else if (v3 > 0) {
            0x2::object_bag::add<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::new_stake_v5<T0>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg6.dori_balance, v3), arg7), arg1, arg2, arg3, arg4, arg5, arg7));
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).balance == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsStakerNotFound());
        };
        sync_pool_balance_internal<T0>(arg0, arg1);
        if (v3 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_deposited_event(0x2::tx_context::sender(arg7), v3, v0);
        };
    }

    public fun emergency_reset_pending_collateral(arg0: &mut GuardSavingsVault, arg1: &GuardSavingsAdminCap) {
        assert_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v0)).pending_collateral = false;
            v0 = v0 + 1;
        };
    }

    fun end_flow(arg0: &mut GuardSavingsVault, arg1: u64) {
        assert_flow(arg0, arg1);
        0x2::dynamic_field::remove<vector<u8>, u64>(&mut arg0.id, b"v32_flow");
    }

    public fun finish_deposit(arg0: &mut GuardSavingsVault, arg1: DepositTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI> {
        abort 49
    }

    public fun finish_deposit_v2(arg0: &mut GuardSavingsVault, arg1: DepositTicketV2, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI> {
        assert_version(arg0);
        let DepositTicketV2 {
            vault_id      : v0,
            min_gdori_out : v1,
            snapshots     : v2,
            total_dori    : v3,
            dori_balance  : v4,
        } = arg1;
        let v5 = v4;
        let v6 = v2;
        assert!(v0 == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, v3);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        assert!(0x1::vector::is_empty<DepositSnapshot>(&v6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolsRemaining());
        0x1::vector::destroy_empty<DepositSnapshot>(v6);
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v5) == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        0x2::balance::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v5);
        assert!(arg0.total_staked >= v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        let v7 = calculate_gdori_for_dori(arg0, v3, arg0.total_staked - v3);
        assert!(v7 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsGdoriMintZero());
        assert!(v7 >= v1, 51);
        end_flow(arg0, v3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_gdori_minted_event(0x2::tx_context::sender(arg2), v7, v3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_deposit_rate_snapshot_event(arg0.total_staked, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply), get_exchange_rate(arg0));
        0x2::coin::from_balance<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(0x2::balance::increase_supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&mut arg0.gdori_supply, v7), arg2)
    }

    public fun finish_withdraw(arg0: WithdrawTicket) {
        abort 53
    }

    public fun finish_withdraw_v2(arg0: &GuardSavingsVault, arg1: WithdrawTicket) {
        abort 53
    }

    public fun finish_withdraw_v3(arg0: &mut GuardSavingsVault, arg1: WithdrawTicketV2) {
        assert_version(arg0);
        let WithdrawTicketV2 {
            vault_id  : v0,
            snapshots : v1,
        } = arg1;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, 0);
        assert!(0x1::vector::is_empty<WithdrawSnapshot>(&v2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolsRemaining());
        0x1::vector::destroy_empty<WithdrawSnapshot>(v2);
        end_flow(arg0, 0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_withdraw_rate_snapshot_event(arg0.total_staked, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply), get_exchange_rate(arg0));
    }

    public fun get_allocation<T0>(arg0: &GuardSavingsVault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.allocations, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.allocations, v0)
        } else {
            0
        }
    }

    public fun get_exchange_rate(arg0: &GuardSavingsVault) : u64 {
        let v0 = 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply);
        if (v0 == 0) {
            1000000000
        } else {
            (((arg0.total_staked as u128) * 1000000000 / (v0 as u128)) as u64)
        }
    }

    public fun get_pool_count(arg0: &GuardSavingsVault) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)
    }

    public fun get_sp_balance<T0>(arg0: &GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) : u64 {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        if (0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0)) {
            0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).balance
        } else {
            0
        }
    }

    public fun get_sp_state<T0>(arg0: &GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) : (u64, bool) {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        if (0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0);
            (v3.balance, v3.pending_collateral)
        } else {
            (0, false)
        }
    }

    public fun get_ticket_info(arg0: &WithdrawTicket) : (u64, u64) {
        (arg0.pools_remaining, arg0.total_entitled)
    }

    public fun get_total_gdori_supply(arg0: &GuardSavingsVault) : u64 {
        0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply)
    }

    public fun get_total_staked(arg0: &GuardSavingsVault) : u64 {
        arg0.total_staked
    }

    public fun has_pending_collateral<T0>(arg0: &GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) : bool {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0) && 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).pending_collateral
    }

    public(friend) fun init_guard_savings(arg0: 0x2::coin::TreasuryCap<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun is_any_pool_blocked(arg0: &GuardSavingsVault) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            if (0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v0)).pending_collateral) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    entry fun migrate(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap) {
        assert!(arg0.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        arg0.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    public entry fun migrate_v32(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap) {
        assert!(arg0.version == 31, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        arg0.version = 32;
    }

    public(friend) fun notify_liquidation<T0>(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        if (0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, v0);
            v1.pending_collateral = true;
            v1.liquidation_nonce = v1.liquidation_nonce + 1;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_liquidation_notified_event(v0, 0x2::object::id<GuardSavingsVault>(arg0));
        };
    }

    public fun quote_withdraw_v2(arg0: &mut GuardSavingsVault, arg1: WithdrawSyncTicketV2, arg2: &0x2::tx_context::TxContext) : WithdrawTicketV2 {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let WithdrawSyncTicketV2 {
            vault_id      : v0,
            min_dori_out  : v1,
            pool_ids      : v2,
            gdori_balance : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        assert!(v0 == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, 0);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolsRemaining());
        0x1::vector::destroy_empty<0x2::object::ID>(v5);
        let v6 = 0x2::balance::value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&v4);
        assert!(v6 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        let v7 = calculate_dori_for_gdori(arg0, v6);
        assert!(v7 > 0, 54);
        assert!(v7 >= v1, 55);
        let v8 = 0x1::vector::empty<WithdrawSnapshot>();
        let v9 = 0;
        let v10 = 0;
        let v11 = arg0.total_staked;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            let v12 = *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v9);
            let v13 = 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v12).balance;
            let v14 = if (v11 > 0 && v13 > 0) {
                (((v7 as u128) * (v13 as u128) / (v11 as u128)) as u64)
            } else {
                0
            };
            if (v13 > 0) {
                v10 = v10 + v14;
                let v15 = WithdrawSnapshot{
                    pool_id         : v12,
                    pro_rata_amount : v14,
                };
                0x1::vector::push_back<WithdrawSnapshot>(&mut v8, v15);
            };
            v9 = v9 + 1;
        };
        let v16 = if (v7 > v10) {
            v7 - v10
        } else {
            0
        };
        let v17 = v16;
        v9 = 0;
        let v18 = 0x1::vector::length<WithdrawSnapshot>(&v8);
        while (v17 > 0 && v9 < v18) {
            let v19 = 0x1::vector::borrow_mut<WithdrawSnapshot>(&mut v8, v9);
            if (v19.pro_rata_amount < 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v19.pool_id).balance) {
                v19.pro_rata_amount = v19.pro_rata_amount + 1;
                v17 = v17 - 1;
            };
            v9 = v9 + 1;
        };
        assert!(v17 == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        v8 = 0x1::vector::empty<WithdrawSnapshot>();
        v9 = 0;
        while (v9 < v18) {
            let v20 = *0x1::vector::borrow<WithdrawSnapshot>(&v8, v9);
            if (v20.pro_rata_amount > 0) {
                0x1::vector::push_back<WithdrawSnapshot>(&mut v8, v20);
            };
            v9 = v9 + 1;
        };
        0x1::vector::length<WithdrawSnapshot>(&v8);
        0x2::balance::decrease_supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&mut arg0.gdori_supply, v4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_gdori_burned_event(0x2::tx_context::sender(arg2), v6, v7);
        WithdrawTicketV2{
            vault_id  : v0,
            snapshots : v8,
        }
    }

    public fun register_pool<T0>(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap) {
        assert_version(arg0);
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.sp_ids, v0);
            let v2 = SPState{
                pool_id            : v0,
                type_name          : v1,
                balance            : 0,
                pending_collateral : false,
                liquidation_nonce  : 0,
                claimed_nonce      : 0,
            };
            0x2::table::add<0x2::object::ID, SPState>(&mut arg0.sp_states, v0, v2);
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_pool_registered_event(0x2::object::id<GuardSavingsVault>(arg0), v0, 0x1::type_name::into_string(v1), 0, arg0.sp_ids, 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids));
        };
    }

    public fun set_allocation<T0>(arg0: &mut GuardSavingsVault, arg1: u64, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap) {
        assert_version(arg0);
        assert!(arg1 <= 10000, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsInvalidAllocation());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.allocations, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.allocations, v0) = arg1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.allocations, v0, arg1);
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_allocation_set_event(0x2::object::id<GuardSavingsVault>(arg0), 0x1::type_name::into_string(v0), arg1, arg0.total_staked, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply));
    }

    public fun start_deposit(arg0: &GuardSavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>) : DepositTicket {
        abort 49
    }

    public fun start_deposit_v2(arg0: &mut GuardSavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: u64) : DepositTicketV2 {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        begin_flow(arg0, v0);
        let v1 = 0x1::vector::empty<DepositSnapshot>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = false;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v2);
            let v7 = 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v6);
            let v8 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.allocations, v7.type_name)) {
                *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.allocations, v7.type_name)
            } else {
                0
            };
            v4 = v4 + v8;
            let v9 = if (v8 > 0) {
                v5 = true;
                (((v0 as u128) * (v8 as u128) / (10000 as u128)) as u64)
            } else {
                0
            };
            v3 = v3 + v9;
            let v10 = DepositSnapshot{
                pool_id         : v6,
                expected_amount : v9,
            };
            0x1::vector::push_back<DepositSnapshot>(&mut v1, v10);
            v2 = v2 + 1;
        };
        assert!(v5 && v4 == 10000, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsInvalidAllocation());
        assert!(v3 <= v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsInvalidAllocation());
        if (v3 < v0) {
            let v11 = 0x1::vector::borrow_mut<DepositSnapshot>(&mut v1, 0);
            v11.expected_amount = v11.expected_amount + v0 - v3;
        };
        DepositTicketV2{
            vault_id      : 0x2::object::id<GuardSavingsVault>(arg0),
            min_gdori_out : arg2,
            snapshots     : v1,
            total_dori    : v0,
            dori_balance  : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1),
        }
    }

    public fun start_withdraw_v2(arg0: &mut GuardSavingsVault, arg1: 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>, arg2: u64) : WithdrawSyncTicketV2 {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        assert!(0x2::coin::value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg1) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        begin_flow(arg0, 0);
        WithdrawSyncTicketV2{
            vault_id      : 0x2::object::id<GuardSavingsVault>(arg0),
            min_dori_out  : arg2,
            pool_ids      : arg0.sp_ids,
            gdori_balance : 0x2::coin::into_balance<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(arg1),
        }
    }

    fun sync_pool_balance_internal<T0>(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        if (!0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0)) {
            return
        };
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::get_staker_balance_decimal_v2<T0>(0x2::object_bag::borrow<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&arg0.stakers, v0), arg1));
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, v0);
        if (v1 > v2.balance) {
            arg0.total_staked = arg0.total_staked + v1 - v2.balance;
        } else {
            let v3 = v2.balance - v1;
            assert!(arg0.total_staked >= v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
            arg0.total_staked = arg0.total_staked - v3;
        };
        v2.balance = v1;
    }

    public fun sync_pool_v2<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut WithdrawSyncTicketV2, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg6.vault_id == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, 0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg6.pool_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg6.pool_ids, v1) == v0) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotInTicket());
        if (0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0)) {
            let (v3, v4) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::unstake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), 0, arg1, arg2, arg3, arg4, arg5, false, arg7);
            0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v3);
            0x2::coin::destroy_zero<T0>(v4);
            sync_pool_balance_internal<T0>(arg0, arg1);
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).balance == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsStakerNotFound());
        };
        0x1::vector::remove<0x2::object::ID>(&mut arg6.pool_ids, v1);
    }

    public fun withdraw<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut WithdrawTicket, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        abort 53
    }

    public fun withdraw_v2<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut WithdrawTicketV2, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        assert_version(arg0);
        assert!(arg6.vault_id == 0x2::object::id<GuardSavingsVault>(arg0), 50);
        assert_flow(arg0, 0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v1 < 0x1::vector::length<WithdrawSnapshot>(&arg6.snapshots)) {
            if (0x1::vector::borrow<WithdrawSnapshot>(&arg6.snapshots, v1).pool_id == v0) {
                let v4 = 0x1::vector::remove<WithdrawSnapshot>(&mut arg6.snapshots, v1);
                v3 = v4.pro_rata_amount;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotInTicket());
        assert!(0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).balance >= v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        let (v5, v6) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::unstake_v6<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), v3, arg1, arg2, arg3, arg4, arg5, false, arg7);
        let v7 = v5;
        0x2::coin::destroy_zero<T0>(v6);
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7) == v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        sync_pool_balance_internal<T0>(arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_withdrawn_event(0x2::tx_context::sender(arg7), v3, v0);
        v7
    }

    // decompiled from Move bytecode v6
}

