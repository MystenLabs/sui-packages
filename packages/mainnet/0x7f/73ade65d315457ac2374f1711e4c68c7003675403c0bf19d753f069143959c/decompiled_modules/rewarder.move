module 0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        points_released: u128,
        points_growth_global: u128,
        last_updated_time: u64,
    }

    struct Rewarder has copy, drop, store {
        reward_coin: 0x1::type_name::TypeName,
        emissions_per_second: u128,
        growth_global: u128,
    }

    struct RewarderGlobalVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct EmergentWithdrawEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{
            rewarders            : 0x1::vector::empty<Rewarder>(),
            points_released      : 0,
            points_growth_global : 0,
            last_updated_time    : 0,
        }
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager) {
        let v0 = rewarder_index<T0>(arg0);
        assert!(0x1::option::is_none<u64>(&v0), 2);
        let v1 = &mut arg0.rewarders;
        assert!(0x1::vector::length<Rewarder>(v1) <= 3 - 1, 1);
        let v2 = Rewarder{
            reward_coin          : 0x1::type_name::get<T0>(),
            emissions_per_second : 0,
            growth_global        : 0,
        };
        0x1::vector::push_back<Rewarder>(v1, v2);
    }

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun balances(arg0: &RewarderGlobalVault) : &0x2::bag::Bag {
        &arg0.balances
    }

    public(friend) fun borrow_mut_rewarder<T0>(arg0: &mut RewarderManager) : &mut Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public fun borrow_rewarder<T0>(arg0: &RewarderManager) : &Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public fun deposit_reward<T0>(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: 0x2::balance::Balance<T0>) : u64 {
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>()), arg2);
        let v2 = DepositEvent{
            reward_type    : 0x1::type_name::get<T0>(),
            deposit_amount : 0x2::balance::value<T0>(&arg2),
            after_amount   : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        v1
    }

    public fun emergent_withdraw<T0>(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::AdminCap, arg1: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg2: &mut RewarderGlobalVault, arg3: u64) : 0x2::balance::Balance<T0> {
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg1);
        let v0 = withdraw_reward<T0>(arg2, arg3);
        let v1 = EmergentWithdrawEvent{
            reward_type     : 0x1::type_name::get<T0>(),
            withdraw_amount : arg3,
            after_amount    : balance_of<T0>(arg2),
        };
        0x2::event::emit<EmergentWithdrawEvent>(v1);
        v0
    }

    public fun emissions_per_second(arg0: &Rewarder) : u128 {
        arg0.emissions_per_second
    }

    public fun growth_global(arg0: &Rewarder) : u128 {
        arg0.growth_global
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderGlobalVault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<RewarderGlobalVault>(v0);
        let v1 = RewarderInitEvent{global_vault_id: 0x2::object::id<RewarderGlobalVault>(&v0)};
        0x2::event::emit<RewarderInitEvent>(v1);
    }

    public fun last_update_time(arg0: &RewarderManager) : u64 {
        arg0.last_updated_time
    }

    public fun points_growth_global(arg0: &RewarderManager) : u128 {
        arg0.points_growth_global
    }

    public fun points_released(arg0: &RewarderManager) : u128 {
        arg0.points_released
    }

    public fun reward_coin(arg0: &Rewarder) : 0x1::type_name::TypeName {
        arg0.reward_coin
    }

    public fun rewarder_index<T0>(arg0: &RewarderManager) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun rewarders(arg0: &RewarderManager) : vector<Rewarder> {
        arg0.rewarders
    }

    public fun rewards_growth_global(arg0: &RewarderManager) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            0x1::vector::push_back<u128>(&mut v1, 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).growth_global);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun settle(arg0: &mut RewarderManager, arg1: u128, arg2: u64) {
        let v0 = arg0.last_updated_time;
        arg0.last_updated_time = arg2;
        assert!(v0 <= arg2, 3);
        if (arg1 == 0 || arg2 == v0) {
            return
        };
        let v1 = arg2 - v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v2).growth_global = 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v2).growth_global + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v1 as u128), 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v2).emissions_per_second, arg1);
            v2 = v2 + 1;
        };
        arg0.points_released = arg0.points_released + (v1 as u128) * 18446744073709551616000000;
        arg0.points_growth_global = arg0.points_growth_global + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v1 as u128), 18446744073709551616000000, arg1);
    }

    public(friend) fun update_emission<T0>(arg0: &RewarderGlobalVault, arg1: &mut RewarderManager, arg2: u128, arg3: u128, arg4: u64) {
        settle(arg1, arg2, arg4);
        let v0 = borrow_mut_rewarder<T0>(arg1);
        if (arg3 > 0) {
            let v1 = 0x1::type_name::get<T0>();
            assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1), 4);
            assert!((0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v1)) as u128) << 64 >= 86400 * arg3, 4);
        };
        v0.emissions_per_second = arg3;
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg1)
    }

    // decompiled from Move bytecode v6
}

