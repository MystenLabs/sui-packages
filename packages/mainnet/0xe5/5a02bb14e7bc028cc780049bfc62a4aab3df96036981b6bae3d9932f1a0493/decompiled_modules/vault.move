module 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault {
    struct PositionInfo has copy, drop, store {
        protocol: 0x1::string::String,
        state_id: 0x2::object::ID,
        pool_id: 0x1::option::Option<0x1::string::String>,
    }

    struct StrategyVault has key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        cap: 0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::StrategyVaultCap,
        balance: 0x2::bag::Bag,
        yield: 0x2::bag::Bag,
        positions: vector<PositionInfo>,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
    }

    struct VaultDeployEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct VaultReturnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct PositionRegisteredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        protocol: 0x1::string::String,
        state_id: 0x2::object::ID,
    }

    public(friend) fun add_balance<T0>(arg0: &mut StrategyVault, arg1: 0x2::balance::Balance<T0>) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::with_defining_ids<T0>()), arg1);
    }

    public(friend) fun add_yield<T0>(arg0: &mut StrategyVault, arg1: 0x2::balance::Balance<T0>) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.yield, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield, 0x1::type_name::with_defining_ids<T0>()), arg1);
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut StrategyVault) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun borrow_yield_mut<T0>(arg0: &mut StrategyVault) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun create_vault<T0, T1>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::config::GlobalConfig, arg2: &mut 0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::LBPair<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::id<0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::LBPair<T0, T1>>(arg2);
        let v3 = StrategyVault{
            id        : v0,
            pair_id   : v2,
            cap       : 0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::set_strategy_vault<T0, T1>(arg1, arg2, v1, arg3),
            balance   : 0x2::bag::new(arg3),
            yield     : 0x2::bag::new(arg3),
            positions : 0x1::vector::empty<PositionInfo>(),
        };
        let v4 = VaultCreatedEvent{
            vault_id : v1,
            pair_id  : v2,
        };
        0x2::event::emit<VaultCreatedEvent>(v4);
        0x2::transfer::share_object<StrategyVault>(v3);
    }

    public fun deposit_to_pair<T0, T1>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::RebalancerCap, arg1: &0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::config::GlobalConfig, arg2: &mut 0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::LBPair<T0, T1>, arg3: &mut StrategyVault, arg4: u64, arg5: u64) {
        assert!(arg4 > 0 || arg5 > 0, 500);
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T1>());
        0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::deposit_from_vault<T0, T1>(arg1, arg2, &arg3.cap, &mut v0, &mut v1, arg4, arg5);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T0>(), v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T1>(), v1);
        let v2 = VaultReturnEvent{
            vault_id : 0x2::object::id<StrategyVault>(arg3),
            pair_id  : arg3.pair_id,
            amount_x : arg4,
            amount_y : arg5,
        };
        0x2::event::emit<VaultReturnEvent>(v2);
    }

    public fun get_positions(arg0: &StrategyVault) : &vector<PositionInfo> {
        &arg0.positions
    }

    public fun position_count(arg0: &StrategyVault) : u64 {
        0x1::vector::length<PositionInfo>(&arg0.positions)
    }

    public fun position_pool_id(arg0: &PositionInfo) : 0x1::string::String {
        let v0 = &arg0.pool_id;
        if (0x1::option::is_some<0x1::string::String>(v0)) {
            *0x1::option::borrow<0x1::string::String>(v0)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun position_protocol(arg0: &PositionInfo) : 0x1::string::String {
        arg0.protocol
    }

    public fun position_state_id(arg0: &PositionInfo) : 0x2::object::ID {
        arg0.state_id
    }

    public(friend) fun register_position(arg0: &mut StrategyVault, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PositionInfo>(&arg0.positions)) {
            let v1 = 0x1::vector::borrow<PositionInfo>(&arg0.positions, v0);
            let v2 = v1.protocol == arg1 && v1.pool_id == arg3;
            assert!(!v2, 501);
            v0 = v0 + 1;
        };
        let v3 = PositionInfo{
            protocol : arg1,
            state_id : arg2,
            pool_id  : arg3,
        };
        0x1::vector::push_back<PositionInfo>(&mut arg0.positions, v3);
        let v4 = PositionRegisteredEvent{
            vault_id : 0x2::object::id<StrategyVault>(arg0),
            protocol : arg1,
            state_id : arg2,
        };
        0x2::event::emit<PositionRegisteredEvent>(v4);
    }

    public(friend) fun unregister_position(arg0: &mut StrategyVault, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PositionInfo>(&arg0.positions)) {
            let v1 = 0x1::vector::borrow<PositionInfo>(&arg0.positions, v0);
            if (v1.protocol == arg1 && v1.pool_id == arg2) {
                0x1::vector::swap_remove<PositionInfo>(&mut arg0.positions, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 502
    }

    public fun vault_balance<T0>(arg0: &StrategyVault) : u64 {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, 0x1::type_name::with_defining_ids<T0>()))
        } else {
            0
        }
    }

    public fun vault_pair_id(arg0: &StrategyVault) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun vault_yield<T0>(arg0: &StrategyVault) : u64 {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.yield, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.yield, 0x1::type_name::with_defining_ids<T0>()))
        } else {
            0
        }
    }

    public fun withdraw_from_pair<T0, T1>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::RebalancerCap, arg1: &0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::config::GlobalConfig, arg2: &mut 0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::LBPair<T0, T1>, arg3: &mut StrategyVault, arg4: u64, arg5: u64) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg3.balance, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::zero<T0>());
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg3.balance, 0x1::type_name::with_defining_ids<T1>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T1>(), 0x2::balance::zero<T1>());
        };
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T1>());
        0xc6d18f72fd9174c38b85cf2cbbdced0d7b34cbd8f3acb79c9ca482df8ee1c586::lb_pair::withdraw_to_vault<T0, T1>(arg1, arg2, &arg3.cap, &mut v0, &mut v1, arg4, arg5);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T0>(), v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg3.balance, 0x1::type_name::with_defining_ids<T1>(), v1);
        let v2 = VaultDeployEvent{
            vault_id : 0x2::object::id<StrategyVault>(arg3),
            pair_id  : arg3.pair_id,
            amount_x : arg4,
            amount_y : arg5,
        };
        0x2::event::emit<VaultDeployEvent>(v2);
    }

    public(friend) fun withdraw_yield<T0>(arg0: &mut StrategyVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 503);
        0x2::balance::split<T0>(v0, arg1)
    }

    // decompiled from Move bytecode v6
}

