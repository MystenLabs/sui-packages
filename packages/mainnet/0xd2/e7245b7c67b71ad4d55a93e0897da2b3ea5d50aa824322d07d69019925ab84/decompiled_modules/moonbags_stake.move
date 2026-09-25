module 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ClaimCreatorPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        claimer: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
    }

    struct ClaimStakingPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        is_staking_account_deleted: bool,
        claimer: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        deny_unstake_duration_ms: u64,
    }

    struct CreatorPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_token: 0x2::coin::Coin<0x2::sui::SUI>,
        creator: address,
    }

    struct DepositPoolCreatorEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        depositor: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct InitializeCreatorPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        initializer: 0x1::ascii::String,
        creator: 0x1::ascii::String,
        timestamp: u64,
    }

    struct InitializeStakingPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        initializer: 0x1::ascii::String,
        timestamp: u64,
    }

    struct StakeEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        staker: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct StakingAccount has store, key {
        id: 0x2::object::UID,
        staker: address,
        balance: u64,
        reward_index: u128,
        earned: u64,
        unstake_deadline: u64,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        staking_token: 0x2::coin::Coin<T0>,
        sui_token: 0x2::coin::Coin<0x2::sui::SUI>,
        total_supply: u64,
        reward_index: u128,
        pending_initial_rewards: u64,
    }

    struct UnstakeEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        is_staking_account_deleted: bool,
        unstaker: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct UpdateCreatorEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        old_creator: 0x1::ascii::String,
        new_creator: 0x1::ascii::String,
        updated_by: 0x1::ascii::String,
    }

    struct UpdateRewardIndexEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        reward_updater: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
        is_initial_rewards: bool,
    }

    public entry fun calculate_rewards_earned<T0>(arg0: &Configuration, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public entry fun claim_creator_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public entry fun claim_staking_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public entry fun deposit_creator_pool<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun initialize_staking_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        abort 0
    }

    public entry fun stake<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        abort 0
    }

    public entry fun unstake<T0>(arg0: &mut Configuration, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: u64) {
        abort 0
    }

    public entry fun update_creator<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_reward_index<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

