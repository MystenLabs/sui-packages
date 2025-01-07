module 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool {
    struct IncentiveInjectInfo has copy, drop {
        strategy_id: 0x2::object::ID,
        amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>,
        entity: 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::Entity,
        shares: 0x2::balance::Balance<T1>,
        underlying_nominal_value_t: u64,
        collected_profit_t: 0x2::balance::Balance<T0>,
        version: u64,
    }

    public(friend) entry fun new<T0, T1>(arg0: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Strategy<T0, T1>{
            id                         : 0x2::object::new(arg1),
            admin_cap_id               : 0x2::object::id<AdminCap>(&v0),
            vault_access               : 0x1::option::none<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(),
            entity                     : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::create_entity(arg1),
            shares                     : 0x2::balance::zero<T1>(),
            underlying_nominal_value_t : 0,
            collected_profit_t         : 0x2::balance::zero<T0>(),
            version                    : 1,
        };
        0x2::transfer::share_object<Strategy<T0, T1>>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun assert_admin<T0, T1>(arg0: &AdminCap, arg1: &Strategy<T0, T1>) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 0);
    }

    fun assert_version<T0, T1>(arg0: &Strategy<T0, T1>) {
        assert!(arg0.version == 1, 2);
    }

    public fun collect_and_hand_over_profit<T0, T1, T2>(arg0: &mut Strategy<T0, T1>, arg1: &AdminCap, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg3: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg4: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg0);
        skim_base_profits<T0, T1>(arg0, arg3, arg4);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::strategy_hand_over_profit<T0, T2>(arg2, 0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::withdraw_all<T0>(&mut arg0.collected_profit_t), arg4);
    }

    public fun inject_incentives<T0, T1>(arg0: &mut Strategy<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = IncentiveInjectInfo{
            strategy_id : 0x2::object::uid_to_inner(&arg0.id),
            amount      : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<IncentiveInjectInfo>(v0);
        0x2::balance::join<T0>(&mut arg0.collected_profit_t, arg1);
    }

    public fun join_vault<T0, T1, T2>(arg0: &mut Strategy<T0, T1>, arg1: &AdminCap, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg3: &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_admin<T0, T1>(arg1, arg0);
        0x1::option::fill<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(&mut arg0.vault_access, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::add_strategy<T0, T2>(arg3, arg2, arg4));
    }

    entry fun migrate<T0, T1>(arg0: &AdminCap, arg1: &mut Strategy<T0, T1>) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg1.version < 1, 3);
        arg1.version = 1;
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Strategy<T0, T1>, arg1: &AdminCap, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg3: &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::RebalanceAmounts, arg4: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg5: &0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::Policy, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(&arg0.vault_access);
        let (v1, v2) = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::rebalance_amounts_get(arg3, v0);
        if (v2 > 0) {
            let v3 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::withdraw<T0, T1>(arg4, 0x2::balance::split<T1>(&mut arg0.shares, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::util::muldiv(0x2::balance::value<T1>(&arg0.shares), v2, arg0.underlying_nominal_value_t)), arg7);
            if (0x2::balance::value<T0>(&v3) > v2) {
                0x2::balance::join<T0>(&mut arg0.collected_profit_t, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) - v2));
            };
            0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::strategy_repay<T0, T2>(arg2, v0, v3);
            arg0.underlying_nominal_value_t = arg0.underlying_nominal_value_t - 0x2::balance::value<T0>(&v3);
        } else if (v1 > 0) {
            let v4 = 0x1::u64::min(v1, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::free_balance<T0, T2>(arg2));
            let (v5, v6) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::supply<T0, T1>(arg4, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::strategy_borrow<T0, T2>(arg2, v0, v4), arg7, arg8);
            0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::approve_request(v6, &arg0.entity, arg5, arg6);
            0x2::balance::join<T1>(&mut arg0.shares, v5);
            arg0.underlying_nominal_value_t = arg0.underlying_nominal_value_t + v4;
        };
    }

    public fun remove_from_vault<T0, T1, T2>(arg0: &mut Strategy<T0, T1>, arg1: &AdminCap, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg3: &0x2::clock::Clock) : 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::StrategyRemovalTicket<T0, T2> {
        assert_admin<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg0);
        assert!(0x2::balance::value<T0>(&arg0.collected_profit_t) == 0, 1);
        arg0.underlying_nominal_value_t = 0;
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::new_strategy_removal_ticket<T0, T2>(0x1::option::extract<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(&mut arg0.vault_access), 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::withdraw<T0, T1>(arg2, 0x2::balance::withdraw_all<T1>(&mut arg0.shares), arg3))
    }

    fun skim_base_profits<T0, T1>(arg0: &mut Strategy<T0, T1>, arg1: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::calc_withdraw_by_shares<T0, T1>(arg1, 0x2::balance::value<T1>(&arg0.shares), arg2);
        if (v0 > arg0.underlying_nominal_value_t) {
            let (v1, _) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::calc_withdraw_by_amount<T0, T1>(arg1, v0 - arg0.underlying_nominal_value_t, arg2);
            0x2::balance::join<T0>(&mut arg0.collected_profit_t, 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::withdraw<T0, T1>(arg1, 0x2::balance::split<T1>(&mut arg0.shares, 0x1::u64::max(v1, 1) - 1), arg2));
        };
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Strategy<T0, T1>, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::WithdrawTicket<T0, T2>, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::withdraw_ticket_to_withdraw<T0, T2>(arg1, v0);
        if (v1 == 0) {
            return
        };
        let v2 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::withdraw<T0, T1>(arg2, 0x2::balance::split<T1>(&mut arg0.shares, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::util::muldiv(0x2::balance::value<T1>(&arg0.shares), v1, arg0.underlying_nominal_value_t)), arg3);
        if (0x2::balance::value<T0>(&v2) > v1) {
            0x2::balance::join<T0>(&mut arg0.collected_profit_t, 0x2::balance::split<T0>(&mut v2, 0x2::balance::value<T0>(&v2) - v1));
        };
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::strategy_withdraw_to_ticket<T0, T2>(arg1, v0, v2);
        arg0.underlying_nominal_value_t = arg0.underlying_nominal_value_t - v1;
    }

    // decompiled from Move bytecode v6
}

