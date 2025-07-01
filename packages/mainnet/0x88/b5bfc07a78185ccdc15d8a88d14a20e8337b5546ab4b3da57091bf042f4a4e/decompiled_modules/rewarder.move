module 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        last_update_time: u64,
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

    struct RewarderAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct RewarderAddedEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
    }

    struct EmissionUpdateEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        old_rate: u128,
        new_rate: u128,
    }

    struct DepositEvent has copy, drop {
        vault: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        remaining_balance: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        pool: 0x2::object::ID,
        bucket: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{
            rewarders        : 0x1::vector::empty<Rewarder>(),
            last_update_time : 0,
        }
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID) {
        assert!(0x1::vector::length<Rewarder>(&arg0.rewarders) < 5, 3000);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!rewarder_exists(arg0, v0), 3001);
        let v1 = Rewarder{
            reward_coin          : v0,
            emissions_per_second : 0,
            growth_global        : 0,
        };
        0x1::vector::push_back<Rewarder>(&mut arg0.rewarders, v1);
        let v2 = RewarderAddedEvent{
            pool        : arg1,
            reward_type : v0,
        };
        0x2::event::emit<RewarderAddedEvent>(v2);
    }

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    public fun calculate_rewards_owed(arg0: u128, arg1: u128, arg2: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2 >= arg1) {
            arg2 - arg1
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::constants::max_u128() - arg1 + arg2 + 1
        };
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::u128_to_u64(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_div_u128(arg0, v0, 1000000000))
    }

    public fun deposit_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        0x2::balance::join<T0>(v1, arg1);
        let v2 = DepositEvent{
            vault         : 0x2::object::id<RewarderGlobalVault>(arg0),
            reward_type   : v0,
            amount        : 0x2::balance::value<T0>(&arg1),
            total_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun emergency_withdraw<T0>(arg0: &RewarderAdminCap, arg1: &mut RewarderGlobalVault, arg2: u64) : 0x2::balance::Balance<T0> {
        withdraw_reward<T0>(arg1, arg2)
    }

    public fun emission_rate<T0>(arg0: &RewarderManager) : u128 {
        let v0 = find_rewarder(arg0, 0x1::type_name::get<T0>());
        if (0x1::option::is_some<Rewarder>(&v0)) {
            0x1::option::borrow<Rewarder>(&v0).emissions_per_second
        } else {
            0
        }
    }

    fun find_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<Rewarder> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v1 = 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0);
            if (v1.reward_coin == arg1) {
                return 0x1::option::some<Rewarder>(*v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Rewarder>()
    }

    fun find_rewarder_mut(arg0: &mut RewarderManager, arg1: 0x1::type_name::TypeName) : &mut Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == arg1) {
                return 0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 3004
    }

    public fun get_rewarders(arg0: &RewarderManager) : &vector<Rewarder> {
        &arg0.rewarders
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderGlobalVault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        let v1 = RewarderAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewarderGlobalVault>(v0);
        0x2::transfer::transfer<RewarderAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RewarderInitEvent{
            global_vault_id : 0x2::object::id<RewarderGlobalVault>(&v0),
            admin_cap_id    : 0x2::object::id<RewarderAdminCap>(&v1),
        };
        0x2::event::emit<RewarderInitEvent>(v2);
    }

    public fun last_update_time(arg0: &RewarderManager) : u64 {
        arg0.last_update_time
    }

    fun rewarder_exists(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
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

    public fun rewards_growth_global(arg0: &RewarderManager) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            0x1::vector::push_back<u128>(&mut v0, 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v1).growth_global);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun settle_rewards(arg0: &mut RewarderManager, arg1: u64) {
        if (arg1 <= arg0.last_update_time) {
            return
        };
        arg0.last_update_time = arg1;
    }

    public(friend) fun update_emission<T0>(arg0: &RewarderGlobalVault, arg1: &mut RewarderManager, arg2: 0x2::object::ID, arg3: u128, arg4: u64) {
        settle_rewards(arg1, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = find_rewarder_mut(arg1, v0);
        let v2 = v1.emissions_per_second;
        if (arg3 > v2 && arg3 > 0) {
            assert!(balance_of<T0>(arg0) >= 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::u128_to_u64(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_u128(arg3, (86400 as u128))), 3003);
        };
        v1.emissions_per_second = arg3;
        let v3 = EmissionUpdateEvent{
            pool        : arg2,
            reward_type : v0,
            old_rate    : v2,
            new_rate    : arg3,
        };
        0x2::event::emit<EmissionUpdateEvent>(v3);
    }

    public(friend) fun update_rewards_growth(arg0: &mut RewarderManager, arg1: u128, arg2: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        if (arg1 == 0 || arg2 == 0) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
                0x1::vector::push_back<u128>(&mut v0, 0);
                v1 = v1 + 1;
            };
            return v0
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v3 = 0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v2);
            if (v3.emissions_per_second > 0) {
                let v4 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_div_u128(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_u128(v3.emissions_per_second, (arg2 as u128)), 1000000000, arg1);
                v3.growth_global = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u128(v3.growth_global, v4);
                0x1::vector::push_back<u128>(&mut v0, v4);
            } else {
                0x1::vector::push_back<u128>(&mut v0, 0);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 3004);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        let v3 = WithdrawEvent{
            vault             : 0x2::object::id<RewarderGlobalVault>(arg0),
            reward_type       : v0,
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

