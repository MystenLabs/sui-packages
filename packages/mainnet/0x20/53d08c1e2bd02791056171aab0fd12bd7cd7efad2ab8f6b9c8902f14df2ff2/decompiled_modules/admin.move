module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::admin {
    struct AdminConfig has drop, store {
        time_locked: bool,
    }

    struct RoleChangedEvent<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        is_authorized: bool,
        authorized_address: address,
    }

    public fun authorize_admin<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        internal_authorize_or_propose<T0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, AdminConfig>(arg0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(arg1), new_config(arg2), arg3, arg4);
    }

    public fun authorize_burner<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        internal_authorize_or_propose<T0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::burner::BurnerRole, bool>(arg0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::burner::BurnerRole>(arg1), true, arg2, arg3);
    }

    public fun authorize_freezer<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        internal_authorize_or_propose<T0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::freezer::FreezerRole, bool>(arg0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::freezer::FreezerRole>(arg1), true, arg2, arg3);
    }

    public fun authorize_minter<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        internal_authorize_or_propose<T0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::minter::MinterRole, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::minter::MintConfig>(arg0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::minter::MinterRole>(arg1), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::minter::new_config(arg2, arg3), arg4, arg5);
    }

    public fun authorize_pauser<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        internal_authorize_or_propose<T0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::pauser::PauserRole, bool>(arg0, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::pauser::PauserRole>(arg1), true, arg2, arg3);
    }

    public fun deauthorize<T0, T1: drop, T2: drop + store>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        let v0 = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<T1>(arg1);
        assert!(0x2::bag::contains_with_type<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::Role<T1>, T2>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::data(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0)), v0), 4);
        if (0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::config<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, AdminConfig>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3)).time_locked) {
            0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::add<T1, T2>(proposals_mut<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::new<T1, T2>(v0, 0x1::option::none<T2>(), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2)));
            return
        };
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::deauthorize<T1, T2>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0), v0);
        emit_role_change_event<T0, T1>(false, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::addr<T1>(&v0));
    }

    fun emit_role_change_event<T0, T1: drop>(arg0: bool, arg1: address) {
        let v0 = RoleChangedEvent<T0>{
            role               : 0x1::type_name::get<T1>(),
            is_authorized      : arg0,
            authorized_address : arg1,
        };
        0x2::event::emit<RoleChangedEvent<T0>>(v0);
    }

    public fun execute_proposal<T0, T1: drop, T2: drop + store>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        let v0 = proposals_mut<T0>(arg0);
        let v1 = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::remove<T1, T2>(v0, arg1);
        assert!(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::proposer<T1, T2>(&v1) == 0x2::tx_context::sender(arg3), 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::timestamp_ms<T1, T2>(&v1) + 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::constants::default_time_lock_period_ms(), 3);
        let (v2, v3) = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::destroy<T1, T2>(v1);
        let v4 = v3;
        let v5 = v2;
        if (0x1::option::is_none<T2>(&v4)) {
            0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::deauthorize<T1, T2>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0), v5);
            emit_role_change_event<T0, T1>(false, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::addr<T1>(&v5));
        } else {
            0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::authorize<T1, T2>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0), v5, 0x1::option::destroy_some<T2>(v4));
            emit_role_change_event<T0, T1>(true, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::addr<T1>(&v5));
        };
    }

    fun internal_authorize_or_propose<T0, T1: drop, T2: drop + store>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::Role<T1>, arg2: T2, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg4));
        let v0 = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::config<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, AdminConfig>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg4));
        assert!(!0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::is_authorized<T1>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::addr<T1>(&arg1)), 5);
        if (v0.time_locked) {
            0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::add<T1, T2>(proposals_mut<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::new<T1, T2>(arg1, 0x1::option::some<T2>(arg2), 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3)));
            return
        };
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::authorize<T1, T2>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0), arg1, arg2);
        emit_role_change_event<T0, T1>(true, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::addr<T1>(&arg1));
    }

    public(friend) fun new_config(arg0: bool) : AdminConfig {
        AdminConfig{time_locked: arg0}
    }

    public(friend) fun proposals<T0>(arg0: &0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>) : &0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::Proposals {
        0x2::dynamic_field::borrow<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::ProposalsKey, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::Proposals>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::uid<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::key())
    }

    fun proposals_mut<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>) : &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::Proposals {
        0x2::dynamic_field::borrow_mut<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::ProposalsKey, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::Proposals>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::uid_mut<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::key())
    }

    public fun reject_proposal<T0, T1: drop, T2: drop + store>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg2));
        let v0 = proposals_mut<T0>(arg0);
        let v1 = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::remove<T1, T2>(v0, arg1);
        if (0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::config<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, AdminConfig>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg2)).time_locked) {
            assert!(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::proposer<T1, T2>(&v1) == 0x2::tx_context::sender(arg2), 6);
        };
        let (_, _) = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::destroy<T1, T2>(v1);
    }

    public fun set_version<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg2));
        assert!(!0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::config<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, AdminConfig>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg2)).time_locked, 1);
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::set_version<T0>(arg0, arg1);
    }

    public(friend) fun setup<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::ProposalsKey, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::Proposals>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::uid_mut<T0>(arg0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::key(), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::proposals::new_registry(arg1));
    }

    // decompiled from Move bytecode v6
}

