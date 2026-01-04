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

    struct WithdrawSnapshot has copy, drop, store {
        pool_id: 0x2::object::ID,
        pro_rata_amount: u64,
    }

    struct WithdrawTicket {
        snapshots: vector<WithdrawSnapshot>,
        pools_remaining: u64,
        total_entitled: u64,
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

    fun assert_version(arg0: &GuardSavingsVault) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    public fun burn_gdori(arg0: &mut GuardSavingsVault, arg1: 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>, arg2: &0x2::tx_context::TxContext) : WithdrawTicket {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::coin::value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        let v1 = calculate_dori_for_gdori(arg0, v0);
        0x2::balance::decrease_supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&mut arg0.gdori_supply, 0x2::coin::into_balance<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_gdori_burned_event(0x2::tx_context::sender(arg2), v0, v1);
        let v2 = 0x1::vector::empty<WithdrawSnapshot>();
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v3);
            let v6 = 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v5);
            let v7 = if (arg0.total_staked > 0 && v6.balance > 0) {
                (((v1 as u128) * (v6.balance as u128) / (arg0.total_staked as u128)) as u64)
            } else {
                0
            };
            if (v7 > 0) {
                v4 = v4 + v7;
                let v8 = WithdrawSnapshot{
                    pool_id         : v5,
                    pro_rata_amount : v7,
                };
                0x1::vector::push_back<WithdrawSnapshot>(&mut v2, v8);
            };
            v3 = v3 + 1;
        };
        let v9 = if (v1 > v4) {
            v1 - v4
        } else {
            0
        };
        let v10 = v9;
        v3 = 0;
        while (v10 > 0 && v3 < 0x1::vector::length<WithdrawSnapshot>(&v2)) {
            let v11 = 0x1::vector::borrow_mut<WithdrawSnapshot>(&mut v2, v3);
            if (v11.pro_rata_amount < 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v11.pool_id).balance) {
                v11.pro_rata_amount = v11.pro_rata_amount + 1;
                v10 = v10 - 1;
            };
            v3 = v3 + 1;
        };
        WithdrawTicket{
            snapshots       : v2,
            pools_remaining : 0x1::vector::length<WithdrawSnapshot>(&v2),
            total_entitled  : v1,
        }
    }

    fun calculate_dori_for_gdori(arg0: &GuardSavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply);
        if (v0 == 0) {
            0
        } else {
            (((arg1 as u128) * (arg0.total_staked as u128) / (v0 as u128)) as u64)
        }
    }

    fun calculate_gdori_for_dori(arg0: &GuardSavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply);
        if (v0 == 0 || arg0.total_staked == 0) {
            arg1
        } else {
            (((arg1 as u128) * (v0 as u128) / (arg0.total_staked as u128)) as u64)
        }
    }

    public fun deposit<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut DepositTicket, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotRegistered());
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v1 < 0x1::vector::length<DepositSnapshot>(&arg6.snapshots)) {
            let v4 = 0x1::vector::borrow_mut<DepositSnapshot>(&mut arg6.snapshots, v1);
            if (v4.pool_id == v0) {
                assert!(v4.expected_amount > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolAlreadyClaimed());
                v3 = v4.expected_amount;
                v4.expected_amount = 0;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotInTicket());
        arg6.pools_remaining = arg6.pools_remaining - 1;
        if (0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0)) {
            let (v5, v6) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::update_stake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg6.dori_balance, v3), arg7), arg1, arg2, arg3, arg4, arg5, false, arg7);
            0x2::coin::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v5);
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            0x2::object_bag::add<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::new_stake_v5<T0>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg6.dori_balance, v3), arg7), arg1, arg2, arg3, arg4, arg5, arg7));
        };
        sync_pool_balance_internal<T0>(arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_deposited_event(0x2::tx_context::sender(arg7), v3, v0);
    }

    public fun emergency_reset_pending_collateral(arg0: &mut GuardSavingsVault, arg1: &GuardSavingsAdminCap) {
        assert_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v0)).pending_collateral = false;
            v0 = v0 + 1;
        };
    }

    public fun finish_deposit(arg0: &mut GuardSavingsVault, arg1: DepositTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI> {
        let DepositTicket {
            snapshots       : _,
            pools_remaining : v1,
            total_dori      : v2,
            expected_gdori  : v3,
            dori_balance    : v4,
        } = arg1;
        let v5 = v4;
        assert!(v1 == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolsRemaining());
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v5) == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        0x2::balance::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v5);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_gdori_minted_event(0x2::tx_context::sender(arg2), v3, v2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_deposit_rate_snapshot_event(arg0.total_staked, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&arg0.gdori_supply), get_exchange_rate(arg0));
        0x2::coin::from_balance<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(0x2::balance::increase_supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&mut arg0.gdori_supply, v3), arg2)
    }

    public fun finish_withdraw(arg0: WithdrawTicket) {
        abort 0
    }

    public fun finish_withdraw_v2(arg0: &GuardSavingsVault, arg1: WithdrawTicket) {
        let WithdrawTicket {
            snapshots       : _,
            pools_remaining : v1,
            total_entitled  : _,
        } = arg1;
        assert!(v1 == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolsRemaining());
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
        let v0 = GuardSavingsVault{
            id           : 0x2::object::new(arg1),
            version      : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            gdori_supply : 0x2::coin::treasury_into_supply<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(arg0),
            total_staked : 0,
            allocations  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            sp_states    : 0x2::table::new<0x2::object::ID, SPState>(arg1),
            sp_ids       : 0x1::vector::empty<0x2::object::ID>(),
            stakers      : 0x2::object_bag::new(arg1),
        };
        let v1 = GuardSavingsAdminCap{id: 0x2::object::new(arg1)};
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_vault_initialized_event(0x2::object::id<GuardSavingsVault>(&v0), v0.version, 0x2::balance::supply_value<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>(&v0.gdori_supply), v0.total_staked, v0.sp_ids);
        0x2::transfer::share_object<GuardSavingsVault>(v0);
        0x2::transfer::transfer<GuardSavingsAdminCap>(v1, 0x2::tx_context::sender(arg1));
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

    public(friend) fun notify_liquidation<T0>(arg0: &mut GuardSavingsVault, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>) {
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        if (0x2::table::contains<0x2::object::ID, SPState>(&arg0.sp_states, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, SPState>(&mut arg0.sp_states, v0);
            v1.pending_collateral = true;
            v1.liquidation_nonce = v1.liquidation_nonce + 1;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_liquidation_notified_event(v0, 0x2::object::id<GuardSavingsVault>(arg0));
        };
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
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsZeroAmount());
        let v1 = 0x1::vector::empty<DepositSnapshot>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg0.sp_ids)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg0.sp_ids, v2);
            let v5 = 0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v4);
            let v6 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.allocations, v5.type_name)) {
                *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.allocations, v5.type_name)
            } else {
                0
            };
            if (v6 > 0) {
                let v7 = (((v0 as u128) * (v6 as u128) / (10000 as u128)) as u64);
                if (v7 > 0) {
                    v3 = v3 + v7;
                    let v8 = DepositSnapshot{
                        pool_id         : v4,
                        expected_amount : v7,
                    };
                    0x1::vector::push_back<DepositSnapshot>(&mut v1, v8);
                };
            };
            v2 = v2 + 1;
        };
        let v9 = 0x1::vector::length<DepositSnapshot>(&v1);
        if (v9 > 0 && v3 < v0) {
            let v10 = 0x1::vector::borrow_mut<DepositSnapshot>(&mut v1, v9 - 1);
            v10.expected_amount = v10.expected_amount + v0 - v3;
        };
        DepositTicket{
            snapshots       : v1,
            pools_remaining : v9,
            total_dori      : v0,
            expected_gdori  : calculate_gdori_for_dori(arg0, v0),
            dori_balance    : 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1),
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
            if (arg0.total_staked >= v3) {
                arg0.total_staked = arg0.total_staked - v3;
            } else {
                arg0.total_staked = 0;
            };
        };
        v2.balance = v1;
    }

    public fun withdraw<T0>(arg0: &mut GuardSavingsVault, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut WithdrawTicket, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        assert_version(arg0);
        assert!(!is_any_pool_blocked(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPendingCollateral());
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>>(arg1);
        sync_pool_balance_internal<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v1 < 0x1::vector::length<WithdrawSnapshot>(&arg6.snapshots)) {
            let v4 = 0x1::vector::borrow_mut<WithdrawSnapshot>(&mut arg6.snapshots, v1);
            if (v4.pool_id == v0) {
                assert!(v4.pro_rata_amount > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolAlreadyClaimed());
                v3 = v4.pro_rata_amount;
                v4.pro_rata_amount = 0;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsPoolNotInTicket());
        assert!(0x2::table::borrow<0x2::object::ID, SPState>(&arg0.sp_states, v0).balance >= v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        arg6.pools_remaining = arg6.pools_remaining - 1;
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.stakers, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EGuardSavingsStakerNotFound());
        let (v5, v6) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::unstake_v5<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StakerV2<T0>>(&mut arg0.stakers, v0), v3, arg1, arg2, arg3, arg4, arg5, false, arg7);
        let v7 = v5;
        0x2::coin::destroy_zero<T0>(v6);
        sync_pool_balance_internal<T0>(arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_guard_savings_withdrawn_event(0x2::tx_context::sender(arg7), 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7), v0);
        v7
    }

    // decompiled from Move bytecode v6
}

