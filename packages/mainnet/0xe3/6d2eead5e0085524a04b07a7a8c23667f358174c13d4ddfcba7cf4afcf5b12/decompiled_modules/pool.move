module 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool {
    struct RoyaltyPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        staked_shares: u64,
        cumulative_reward_per_share: u256,
        cumulative_deposits: u128,
    }

    struct RoyaltyPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyPoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        parent_id: 0x2::object::ID,
    }

    struct RoyaltyDepositedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        value: u64,
    }

    struct StakeRegisteredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        staked_amount: u64,
    }

    struct StakeUnregisteredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        unstaked_amount: u64,
    }

    struct RoyaltyClaimedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        reward_amount: u64,
    }

    public fun balance<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.balance
    }

    public fun assert_derived_from<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = RoyaltyPoolKey<T1>{dummy_field: false};
        assert!(0x2::object::uid_to_address(&arg0.id) == 0x2::derived_object::derive_address<RoyaltyPoolKey<T1>>(arg1, v0), 0);
    }

    fun calculate_reward(arg0: u64, arg1: u256, arg2: u256) : u64 {
        (((arg0 as u256) * (arg2 - arg1) / (1000000000000000000 as u256)) as u64)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::has_registration<T0>(arg1, &v0), 3);
        let v1 = id<T0, T1>(arg0);
        let v2 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::value<T0>(arg1);
        let v3 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_mut<T0>(arg1, &v0);
        assert!(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_pool_id(v3) == v1, 4);
        let v4 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_last_claim_index(v3);
        let v5 = calculate_reward(v2, v4, arg0.cumulative_reward_per_share);
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::set_last_claim_index(v3, v4 + (0x1::u128::mul_div((v5 as u128), 1000000000000000000, (v2 as u128)) as u256));
        let v6 = RoyaltyClaimedEvent<T0, T1>{
            pool_id       : v1,
            stake_id      : 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::id<T0>(arg1),
            reward_amount : v5,
        };
        0x2::event::emit<RoyaltyClaimedEvent<T0, T1>>(v6);
        0x2::balance::split<T1>(&mut arg0.balance, v5)
    }

    public fun cumulative_deposits<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u128 {
        arg0.cumulative_deposits
    }

    public fun cumulative_reward_per_share<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u256 {
        arg0.cumulative_reward_per_share
    }

    public fun deposit<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        assert!(arg0.staked_shares > 0, 1);
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert!(v0 > 0, 6);
        arg0.cumulative_reward_per_share = arg0.cumulative_reward_per_share + (0x1::u128::mul_div((v0 as u128), 1000000000000000000, (arg0.staked_shares as u128)) as u256);
        arg0.cumulative_deposits = arg0.cumulative_deposits + (v0 as u128);
        0x2::balance::join<T1>(&mut arg0.balance, arg1);
        let v1 = RoyaltyDepositedEvent<T0, T1>{
            pool_id : id<T0, T1>(arg0),
            value   : v0,
        };
        0x2::event::emit<RoyaltyDepositedEvent<T0, T1>>(v1);
    }

    public fun derived_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = RoyaltyPoolKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyPoolKey<T0>>(arg0, v0)
    }

    public fun id<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new<T0, T1>(arg0: &mut 0x2::object::UID) : RoyaltyPool<T0, T1> {
        let v0 = RoyaltyPoolKey<T1>{dummy_field: false};
        let v1 = RoyaltyPool<T0, T1>{
            id                          : 0x2::derived_object::claim<RoyaltyPoolKey<T1>>(arg0, v0),
            balance                     : 0x2::balance::zero<T1>(),
            staked_shares               : 0,
            cumulative_reward_per_share : 0,
            cumulative_deposits         : 0,
        };
        let v2 = RoyaltyPoolCreatedEvent<T0, T1>{
            pool_id   : id<T0, T1>(&v1),
            parent_id : 0x2::object::uid_to_inner(arg0),
        };
        0x2::event::emit<RoyaltyPoolCreatedEvent<T0, T1>>(v2);
        v1
    }

    public fun pending_rewards<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: &0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::has_registration<T0>(arg1, &v0)) {
            return 0
        };
        let v1 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::get_registration<T0>(arg1, &v0);
        if (0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_pool_id(v1) != id<T0, T1>(arg0)) {
            return 0
        };
        calculate_reward(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::value<T0>(arg1), 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_last_claim_index(v1), arg0.cumulative_reward_per_share)
    }

    public fun receive_and_deposit<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) {
        let v0 = 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::receive_balance<T1>(&mut arg0.id, arg1);
        deposit<T0, T1>(arg0, v0);
    }

    public fun redeem_and_deposit<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: u64) {
        let v0 = 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T1>(&mut arg0.id, arg1);
        deposit<T0, T1>(arg0, v0);
    }

    public fun register_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::has_registration<T0>(arg1, &v0), 2);
        let v1 = id<T0, T1>(arg0);
        let v2 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::value<T0>(arg1);
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::add_registration<T0>(arg1, v0, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::new_registration(v1, arg0.cumulative_reward_per_share));
        arg0.staked_shares = arg0.staked_shares + v2;
        let v3 = StakeRegisteredEvent<T0, T1>{
            pool_id       : v1,
            stake_id      : 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::id<T0>(arg1),
            staked_amount : v2,
        };
        0x2::event::emit<StakeRegisteredEvent<T0, T1>>(v3);
    }

    public fun share<T0, T1>(arg0: RoyaltyPool<T0, T1>) {
        0x2::transfer::share_object<RoyaltyPool<T0, T1>>(arg0);
    }

    public fun staked_shares<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u64 {
        arg0.staked_shares
    }

    public fun unregister_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::has_registration<T0>(arg1, &v0), 3);
        let v1 = id<T0, T1>(arg0);
        let v2 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::value<T0>(arg1);
        let v3 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::get_registration<T0>(arg1, &v0);
        assert!(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_pool_id(v3) == v1, 4);
        assert!(calculate_reward(v2, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::registration_last_claim_index(v3), arg0.cumulative_reward_per_share) == 0, 5);
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::remove_registration<T0>(arg1, &v0);
        arg0.staked_shares = arg0.staked_shares - v2;
        let v4 = StakeUnregisteredEvent<T0, T1>{
            pool_id         : v1,
            stake_id        : 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::id<T0>(arg1),
            unstaked_amount : v2,
        };
        0x2::event::emit<StakeUnregisteredEvent<T0, T1>>(v4);
    }

    // decompiled from Move bytecode v7
}

