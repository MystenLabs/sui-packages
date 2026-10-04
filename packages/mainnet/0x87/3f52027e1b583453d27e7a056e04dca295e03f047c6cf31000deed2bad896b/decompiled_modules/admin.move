module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::admin {
    struct EmergencyExitReceipt {
        receipt: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::SwapReceipt,
    }

    entry fun accept_denomination<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::is_constituent(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v0), v1), 1601);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::accept_denomination(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), v1, arg2);
    }

    entry fun announce_emergency<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::announce(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::emergency_mut(v0), 0x1::type_name::with_defining_ids<T0>(), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::emergency_delay_ms(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v0)), arg2);
    }

    entry fun cancel_composition(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::CompositionCap, arg2: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_composition(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::cancel(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition_mut(v0), arg2);
    }

    entry fun cancel_emergency<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::cancel(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::emergency_mut(v0), 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    entry fun cancel_feed_binding<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::cancel_binding<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_mut(v0), arg2);
    }

    entry fun cancel_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_emergency(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let (_, _) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::cancel_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(v0));
    }

    entry fun cancel_supra_holder(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::cancel_supra_holder(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0));
    }

    entry fun drop_denomination<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::drop_denomination(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun emergency_exit_begin<T0, T1>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, EmergencyExitReceipt) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v3 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(v3, v1);
        let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v2);
        let v5 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_frozen(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v5), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::consume(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::emergency_mut(v5), v0, arg2);
        let v6 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::split_all<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody_mut(v5));
        let v7 = 0x2::balance::value<T0>(&v6);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::emit_executed(v0, v7, arg2);
        let v8 = EmergencyExitReceipt{receipt: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_receipt(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x1::option::none<0x2::object::ID>(), v0, v1, v7, ((((((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::nav::preview_value<T0>(arg0, arg2) as u128) * pow10((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(v4, v1) as u64)) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(v4, v3, v1, arg2) as u128)) as u64) as u128) * ((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() - 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_slippage_bps(v3)) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() as u128)) as u64))};
        (v6, v8)
    }

    public fun emergency_exit_settle<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0x2::balance::Balance<T0>, arg2: EmergencyExitReceipt) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_frozen(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v1), v0);
        let EmergencyExitReceipt { receipt: v2 } = arg2;
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::settle_receipt(v2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x1::option::none<0x2::object::ID>(), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::receipt_token_in(&v2), v0, 0x2::balance::value<T0>(&arg1));
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::join<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::reserve_mut(v1), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::invalidate_nav(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_mut(v1));
    }

    entry fun execute_composition(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition_mut_and_prices(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0));
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::execute(v0, v1, arg1);
    }

    entry fun execute_feed_binding<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0x2::clock::Clock) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::execute_binding<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0)), arg1);
    }

    entry fun execute_feed_rebind<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::OracleAdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_oracle(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::execute_rebind<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_mut(v0), arg2);
    }

    entry fun execute_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0x2::clock::Clock) {
        let (_, _, _) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::execute_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0)), arg1);
    }

    entry fun execute_supra_holder(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0x2::clock::Clock) {
        let (_, _) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::execute_supra_holder(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0)), arg1);
    }

    entry fun fast_root_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap, arg3: u8, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::is_root_target(arg3), 1603);
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_frozen(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_emergency(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::fast_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(v0), arg3, arg4, arg5);
    }

    entry fun fast_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap, arg2: u8, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::is_root_target(arg2), 1602);
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_frozen(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_emergency(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::fast_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(v0), arg2, arg3, arg4);
    }

    entry fun genesis(arg0: 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::mint_all(arg6);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::genesis(arg0, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::new(arg1, arg2, arg3, arg4, arg5), v7, arg6);
        let v8 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap>(v0, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap>(v1, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::PauseCap>(v2, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::OracleAdminCap>(v3, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::CompositionCap>(v4, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::KeeperCap>(v5, v8);
        0x2::transfer::public_transfer<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap>(v6, v8);
    }

    entry fun pause(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::PauseCap, arg2: u8) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_pause(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0)), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::tighten(arg0, arg2);
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    entry fun propose_composition(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::CompositionCap, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_composition(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let (v1, v2, v3) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition_policy_and_prices_mut(v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::propose(v1, v2, v3, arg2, arg3, arg4, arg5);
    }

    entry fun propose_feed_binding<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::OracleAdminCap, arg2: u32, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_oracle(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let (v1, v2) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_and_policy_mut(v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::propose_binding<T0>(v1, v2, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun propose_feed_rebind<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::OracleAdminCap, arg2: u32, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_oracle(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let (v1, v2) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_and_policy_mut(v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::propose_rebind<T0>(v1, v2, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun propose_root_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap, arg3: u8, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::is_root_target(arg3), 1603);
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_emergency(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::propose_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(v0), arg3, arg4, arg5);
    }

    entry fun propose_rotation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u8, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::is_root_target(arg2), 1602);
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::propose_rotation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities_mut(v0), arg2, arg3, arg4);
    }

    entry fun propose_supra_holder(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        let (_, _) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::propose_supra_holder(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2, arg3);
    }

    entry fun raise_composition_timelock(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::raise_composition_timelock(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun raise_emergency_delay(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::raise_emergency_delay(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun raise_feed_timelock(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::raise_feed_timelock(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun raise_holder_timelock(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::raise_holder_timelock(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun raise_reweight_timelock(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::raise_reweight_timelock(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun reset_breaker<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::OracleAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_oracle(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::reset_breaker<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_mut(v0), arg2, arg3, arg4);
    }

    entry fun set_drift_tolerance(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_drift_tolerance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun set_fee_collector(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: address) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_fee_collector(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun set_fees(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64, arg3: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_fees(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2, arg3);
    }

    entry fun set_genesis_composition(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::supply(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v0)) == 0, 1600);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::assert_empty(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody(v0));
        let (v1, v2) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition_and_policy_mut(v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::set_genesis(v1, v2, arg2, arg3, arg4, arg5);
    }

    entry fun set_max_deviation(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_max_deviation(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun set_max_price_age(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_max_price_age(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun set_max_slippage(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_max_slippage(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2);
    }

    entry fun set_rebalance_schedule(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u64, arg3: u64) {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(v0), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::set_rebalance_schedule(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy_mut(v0), arg2, arg3);
    }

    entry fun set_status(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg2: u8) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_config(arg0)), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::set_status(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

