module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::lock_manager {
    public fun add_lock<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg7: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg7);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::AddLockRecord>(arg6, 0x2::tx_context::sender(arg9)), 13835058682347454466);
        add_lock_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg8));
    }

    public(friend) fun add_lock_internal<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64) {
        assert!(arg2 > 0, 13836466181785714700);
        assert!(arg5 == 0 || arg5 > arg6, 13836747661057523726);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks_mut<T0>(arg0, arg1);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::locks_length(v0) < 30, 13835903253306867720);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::add_lock(v0, arg2, arg3, arg4, arg5);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_lock_added_event<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun compute_transferable<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks<T0>(arg0, arg1);
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_fully_locked(v0)) {
            return 0
        };
        let v1 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::compute_locked_sum(v0, arg3);
        if (v1 >= arg2) {
            0
        } else {
            arg2 - v1
        }
    }

    public fun is_investor_locked<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String) : bool {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_fully_locked(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks<T0>(arg0, arg1))
    }

    public fun is_liquidate_only<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String) : bool {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_liquidate_only(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks<T0>(arg0, arg1))
    }

    public fun lock_count<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String) : u64 {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::locks_length(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks<T0>(arg0, arg1))
    }

    public fun lock_investor<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::LockInvestor>(arg2, 0x2::tx_context::sender(arg4)), 13835058390289678338);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks_mut<T0>(arg0, arg1);
        assert!(!0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_fully_locked(v0), 13835339873856454660);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::set_fully_locked(v0, true);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_investor_fully_locked_event<T0>(arg1);
    }

    public(friend) fun new<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::LockInvestor>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::UnlockInvestor>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetLiquidateOnly>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::AddLockRecord>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RemoveLockRecord>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::LockInvestor>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::UnlockInvestor>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetLiquidateOnly>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::AddLockRecord>(arg0, arg1, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RemoveLockRecord>(arg0, arg1, arg2);
    }

    public fun remove_lock<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg4: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg4);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RemoveLockRecord>(arg3, 0x2::tx_context::sender(arg5)), 13835058918570655746);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks_mut<T0>(arg0, arg1);
        assert!(arg2 < 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::locks_length(v0), 13836184831362924554);
        let v1 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::remove_lock(v0, arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_lock_removed_event<T0>(arg1, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::lock_value(&v1), 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::lock_reason_code(&v1), 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::lock_reason_string(&v1), 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::lock_release_time_ms(&v1));
    }

    public fun set_liquidate_only<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: bool, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg4: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg4);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetLiquidateOnly>(arg3, 0x2::tx_context::sender(arg5)), 13835058566383337474);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::set_liquidate_only(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks_mut<T0>(arg0, arg1), arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_liquidate_only_set_event<T0>(arg1, arg2);
    }

    public fun unlock_investor<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::UnlockInvestor>(arg2, 0x2::tx_context::sender(arg4)), 13835058476189024258);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_locks_mut<T0>(arg0, arg1);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_fully_locked(v0), 13835621434732642310);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::set_fully_locked(v0, false);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_investor_fully_unlocked_event<T0>(arg1);
    }

    // decompiled from Move bytecode v7
}

