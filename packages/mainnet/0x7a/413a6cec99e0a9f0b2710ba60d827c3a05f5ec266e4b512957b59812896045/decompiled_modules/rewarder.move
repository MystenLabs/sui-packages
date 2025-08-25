module 0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
    }

    struct Rewarder has copy, drop, store {
        reward_coin: 0x1::type_name::TypeName,
        reward_factor: u128,
    }

    struct RewarderGlobalVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
    }

    struct RewardFactorUpdateEvent has copy, drop {
        pair: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        old_factor: u128,
        new_factor: u128,
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

    struct EmergentWithdrawEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{rewarders: 0x1::vector::empty<Rewarder>()}
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager) {
        assert!(0x1::vector::length<Rewarder>(&arg0.rewarders) < 5, 3000);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!rewarder_exists(arg0, v0), 3001);
        let v1 = Rewarder{
            reward_coin   : v0,
            reward_factor : 0,
        };
        0x1::vector::push_back<Rewarder>(&mut arg0.rewarders, v1);
    }

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    public(friend) fun calculate_reward_amount(arg0: u128, arg1: u128) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::safe_math::u128_to_u64(0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::safe_math::mul_div_u128(arg0, arg1, (10000 as u128)))
    }

    public fun deposit_reward<T0>(arg0: &0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: 0x2::balance::Balance<T0>) {
        0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        0x2::balance::join<T0>(v1, arg2);
        let v2 = DepositEvent{
            vault         : 0x2::object::id<RewarderGlobalVault>(arg1),
            reward_type   : v0,
            amount        : 0x2::balance::value<T0>(&arg2),
            total_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun emergent_withdraw<T0>(arg0: &0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::checked_package_version(arg0);
        0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::check_reward_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = withdraw_reward<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x7a413a6cec99e0a9f0b2710ba60d827c3a05f5ec266e4b512957b59812896045::config::get_reward_receiver(arg0));
        let v1 = EmergentWithdrawEvent{
            reward_type     : 0x1::type_name::get<T0>(),
            withdraw_amount : arg2,
            after_amount    : balance_of<T0>(arg1),
        };
        0x2::event::emit<EmergentWithdrawEvent>(v1);
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

    public fun get_reward_coin_type(arg0: &Rewarder) : 0x1::type_name::TypeName {
        arg0.reward_coin
    }

    public fun get_reward_factor<T0>(arg0: &RewarderManager) : u128 {
        let v0 = find_rewarder(arg0, 0x1::type_name::get<T0>());
        if (0x1::option::is_some<Rewarder>(&v0)) {
            0x1::option::borrow<Rewarder>(&v0).reward_factor
        } else {
            0
        }
    }

    public fun get_rewarder_factor(arg0: &Rewarder) : u128 {
        arg0.reward_factor
    }

    public fun get_rewarders(arg0: &RewarderManager) : &vector<Rewarder> {
        &arg0.rewarders
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

    public fun max_rewarders_per_pair() : u64 {
        5
    }

    public fun reward_factor_precision() : u64 {
        10000
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

    public(friend) fun update_reward_factor<T0>(arg0: &RewarderGlobalVault, arg1: &mut RewarderManager, arg2: 0x2::object::ID, arg3: u128) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = find_rewarder_mut(arg1, v0);
        if (arg3 > 0) {
            assert!(balance_of<T0>(arg0) > 0, 3003);
        };
        v1.reward_factor = arg3;
        let v2 = RewardFactorUpdateEvent{
            pair        : arg2,
            reward_type : v0,
            old_factor  : v1.reward_factor,
            new_factor  : arg3,
        };
        0x2::event::emit<RewardFactorUpdateEvent>(v2);
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 3004);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3003);
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

