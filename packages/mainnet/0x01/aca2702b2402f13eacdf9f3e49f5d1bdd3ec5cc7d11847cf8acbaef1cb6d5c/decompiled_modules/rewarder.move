module 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        last_update_timestamp: u64,
    }

    struct Rewarder has copy, drop, store {
        emission_per_ms: u128,
        reward_coin: 0x1::type_name::TypeName,
    }

    struct RewarderGlobalVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
    }

    struct RewardEmissionUpdateEvent has copy, drop {
        pair: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        old_emission: u128,
        new_emission: u128,
    }

    struct DepositEvent has copy, drop {
        vault: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct EmergentWithdrawEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{
            rewarders             : 0x1::vector::empty<Rewarder>(),
            last_update_timestamp : 0,
        }
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager) {
        assert!(0x1::vector::length<Rewarder>(&arg0.rewarders) <= 30, 3000);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!rewarder_exists(arg0, v0), 3001);
        let v1 = Rewarder{
            emission_per_ms : 0,
            reward_coin     : v0,
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

    public fun calc_reward_emission(arg0: &RewarderManager, arg1: &0x2::clock::Clock) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x2::clock::timestamp_ms(arg1);
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v3 = 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0);
            let v4 = if (v3.emission_per_ms > 0 && v2 > arg0.last_update_timestamp) {
                0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::mul_u128(v3.emission_per_ms, (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::sub_u64(v2, arg0.last_update_timestamp) as u128))
            } else {
                0
            };
            0x1::vector::push_back<u128>(&mut v1, v4);
            v0 = v0 + 1;
        };
        v1
    }

    public fun deposit_reward<T0>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: 0x2::balance::Balance<T0>) {
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::balance::value<T0>(&arg2);
        assert!(v1 > 0, 3005);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        0x2::balance::join<T0>(v2, arg2);
        let v3 = DepositEvent{
            vault         : 0x2::object::id<RewarderGlobalVault>(arg1),
            reward_type   : v0,
            amount        : v1,
            total_balance : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun emergent_withdraw<T0>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::checked_package_version(arg0);
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::check_reward_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = withdraw_reward<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::get_reward_receiver(arg0));
        let v1 = EmergentWithdrawEvent{
            reward_type     : 0x1::type_name::get<T0>(),
            withdraw_amount : arg2,
            after_amount    : balance_of<T0>(arg1),
        };
        0x2::event::emit<EmergentWithdrawEvent>(v1);
    }

    public(friend) fun get_reward_emission<T0>(arg0: &RewarderManager, arg1: &0x2::clock::Clock) : u128 {
        let v0 = get_rewarder(arg0, 0x1::type_name::get<T0>()).emission_per_ms;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg0.last_update_timestamp;
        if (v0 > 0 && v1 > v2) {
            0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::mul_u128(v0, (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::sub_u64(v1, v2) as u128))
        } else {
            0
        }
    }

    fun get_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName) : &Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == arg1) {
                return 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 3004
    }

    fun get_rewarder_mut(arg0: &mut RewarderManager, arg1: 0x1::type_name::TypeName) : &mut Rewarder {
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
        0x2::transfer::share_object<RewarderGlobalVault>(v0);
        let v1 = RewarderInitEvent{global_vault_id: 0x2::object::id<RewarderGlobalVault>(&v0)};
        0x2::event::emit<RewarderInitEvent>(v1);
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

    public(friend) fun settle_reward(arg0: &mut RewarderManager, arg1: &0x2::clock::Clock) : vector<u128> {
        arg0.last_update_timestamp = 0x2::clock::timestamp_ms(arg1);
        calc_reward_emission(arg0, arg1)
    }

    public(friend) fun update_reward_emission<T0>(arg0: &RewarderGlobalVault, arg1: &mut RewarderManager, arg2: 0x2::object::ID, arg3: u128) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_rewarder_mut(arg1, v0);
        if (arg3 > 0) {
            assert!((balance_of<T0>(arg0) as u128) << 64 >= 86400000 * arg3, 3003);
        };
        v1.emission_per_ms = arg3;
        let v2 = RewardEmissionUpdateEvent{
            pair         : arg2,
            reward_type  : v0,
            old_emission : v1.emission_per_ms,
            new_emission : arg3,
        };
        0x2::event::emit<RewardEmissionUpdateEvent>(v2);
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 3004);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3003);
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

