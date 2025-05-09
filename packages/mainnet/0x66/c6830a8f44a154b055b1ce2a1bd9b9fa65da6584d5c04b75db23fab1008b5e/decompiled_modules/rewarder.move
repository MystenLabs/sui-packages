module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::rewarder {
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

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        abort 0
    }

    public fun balances(arg0: &RewarderGlobalVault) : &0x2::bag::Bag {
        abort 0
    }

    public fun borrow_rewarder<T0>(arg0: &RewarderManager) : &Rewarder {
        abort 0
    }

    public fun deposit_reward<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: 0x2::balance::Balance<T0>) : u64 {
        abort 0
    }

    public fun emergent_withdraw<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::AdminCap, arg1: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg2: &mut RewarderGlobalVault, arg3: u64) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun emissions_per_second(arg0: &Rewarder) : u128 {
        abort 0
    }

    public fun growth_global(arg0: &Rewarder) : u128 {
        abort 0
    }

    public fun last_update_time(arg0: &RewarderManager) : u64 {
        abort 0
    }

    public(friend) fun new() : RewarderManager {
        abort 0
    }

    public fun points_growth_global(arg0: &RewarderManager) : u128 {
        abort 0
    }

    public fun points_released(arg0: &RewarderManager) : u128 {
        abort 0
    }

    public fun reward_coin(arg0: &Rewarder) : 0x1::type_name::TypeName {
        abort 0
    }

    public fun rewarder_index<T0>(arg0: &RewarderManager) : 0x1::option::Option<u64> {
        abort 0
    }

    public fun rewarders(arg0: &RewarderManager) : vector<Rewarder> {
        abort 0
    }

    public fun rewards_growth_global(arg0: &RewarderManager) : vector<u128> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

