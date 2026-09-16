module 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool {
    struct RoyaltyPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        staked_shares: u64,
        cumulative_reward_per_share: u256,
        carry: u128,
        cumulative_deposits: u128,
    }

    struct RoyaltyPoolKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyPoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        parent_id: address,
        precision: u128,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct RoyaltyDepositedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        value: u64,
        cumulative_reward_per_share_before: u256,
        carry_before: u128,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct RoyaltyPoolFundsSettledEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        source_address: address,
        accumulator_root_id: address,
        value: u64,
        cumulative_reward_per_share_before: u256,
        carry_before: u128,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct RoyaltyPoolCoinsRecoveredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        coin_count: u64,
        funds_recipient: address,
        value: u64,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct StakeRegisteredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        stake_id: address,
        staked_amount: u64,
        registration_debt_after: u256,
        stake_registration_count_after: u64,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct StakeUnregisteredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        stake_id: address,
        unstaked_amount: u64,
        removed_registration_debt: u256,
        forfeited_reward_numerator: u256,
        stake_registration_count_after: u64,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    struct RoyaltyClaimedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        stake_id: address,
        staked_amount: u64,
        reward_amount: u64,
        registration_debt_before: u256,
        registration_debt_after: u256,
        reward_residue_after: u256,
        stake_registration_count_after: u64,
        pool_balance_after: u64,
        staked_shares_after: u64,
        cumulative_reward_per_share_after: u256,
        carry_after: u128,
        cumulative_deposits_after: u128,
    }

    public fun balance<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.balance
    }

    public fun assert_derived_from<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = RoyaltyPoolKey<T0, T1>{dummy_field: false};
        assert!(0x2::object::uid_to_address(&arg0.id) == 0x2::derived_object::derive_address<RoyaltyPoolKey<T0, T1>>(arg1, v0), 0);
    }

    fun calculate_reward(arg0: u64, arg1: u256, arg2: u256) : u64 {
        ((((arg0 as u256) * arg2 - arg1) / (1000000000000000000 as u256)) as u64)
    }

    public fun carry<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u128 {
        arg0.carry
    }

    public fun claim_rewards<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(arg1, &v0), 3);
        let v1 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v2 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(arg1);
        let v3 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(arg1);
        let v4 = arg0.cumulative_reward_per_share;
        let v5 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(arg1, &v0);
        assert!(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_pool_id(v5) == v1, 4);
        let v6 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(v5);
        let v7 = calculate_reward(v3, v6, v4);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::add_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_mut<T0>(arg1, &v0), (v7 as u256) * (1000000000000000000 as u256));
        let v8 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(arg1, &v0));
        if (v7 > 0) {
            let v9 = RoyaltyClaimedEvent<T0, T1>{
                pool_id                           : 0x2::object::id_to_address(&v1),
                stake_id                          : 0x2::object::id_to_address(&v2),
                staked_amount                     : v3,
                reward_amount                     : v7,
                registration_debt_before          : v6,
                registration_debt_after           : v8,
                reward_residue_after              : (v3 as u256) * v4 - v8,
                stake_registration_count_after    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(arg1),
                pool_balance_after                : 0x2::balance::value<T1>(&arg0.balance),
                staked_shares_after               : arg0.staked_shares,
                cumulative_reward_per_share_after : arg0.cumulative_reward_per_share,
                carry_after                       : arg0.carry,
                cumulative_deposits_after         : arg0.cumulative_deposits,
            };
            0x2::event::emit<RoyaltyClaimedEvent<T0, T1>>(v9);
        };
        0x2::balance::split<T1>(&mut arg0.balance, v7)
    }

    public fun cumulative_deposits<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u128 {
        arg0.cumulative_deposits
    }

    public fun cumulative_reward_per_share<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u256 {
        arg0.cumulative_reward_per_share
    }

    public fun deposit<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v1 = arg0.cumulative_reward_per_share;
        let v2 = arg0.carry;
        deposit_balance<T0, T1>(arg0, arg1);
        let v3 = RoyaltyDepositedEvent<T0, T1>{
            pool_id                            : 0x2::object::id_to_address(&v0),
            value                              : 0x2::balance::value<T1>(&arg1),
            cumulative_reward_per_share_before : v1,
            carry_before                       : v2,
            pool_balance_after                 : 0x2::balance::value<T1>(&arg0.balance),
            staked_shares_after                : arg0.staked_shares,
            cumulative_reward_per_share_after  : arg0.cumulative_reward_per_share,
            carry_after                        : arg0.carry,
            cumulative_deposits_after          : arg0.cumulative_deposits,
        };
        0x2::event::emit<RoyaltyDepositedEvent<T0, T1>>(v3);
    }

    fun deposit_balance<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        assert!(arg0.staked_shares > 0, 1);
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = (v0 as u128) * 1000000000000000000 + arg0.carry;
        let v2 = (arg0.staked_shares as u128);
        arg0.cumulative_reward_per_share = arg0.cumulative_reward_per_share + ((v1 / v2) as u256);
        arg0.carry = v1 % v2;
        arg0.cumulative_deposits = arg0.cumulative_deposits + (v0 as u128);
        0x2::balance::join<T1>(&mut arg0.balance, arg1);
    }

    public fun derived_address<T0, T1>(arg0: 0x2::object::ID) : address {
        let v0 = RoyaltyPoolKey<T0, T1>{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyPoolKey<T0, T1>>(arg0, v0)
    }

    public fun new<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0x2::coin_registry::Currency<T0>) : RoyaltyPool<T0, T1> {
        assert!(0x7e2935f3972f543c406ab49fc02835c4d2baf63363f0aa07ab271e2fd09e0550::share::is_share<T0>(arg1), 7);
        new_unchecked<T0, T1>(arg0)
    }

    fun new_unchecked<T0, T1>(arg0: &mut 0x2::object::UID) : RoyaltyPool<T0, T1> {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = RoyaltyPoolKey<T0, T1>{dummy_field: false};
        let v2 = RoyaltyPool<T0, T1>{
            id                          : 0x2::derived_object::claim<RoyaltyPoolKey<T0, T1>>(arg0, v1),
            balance                     : 0x2::balance::zero<T1>(),
            staked_shares               : 0,
            cumulative_reward_per_share : 0,
            carry                       : 0,
            cumulative_deposits         : 0,
        };
        let v3 = 0x2::object::id<RoyaltyPool<T0, T1>>(&v2);
        let v4 = RoyaltyPoolCreatedEvent<T0, T1>{
            pool_id                           : 0x2::object::id_to_address(&v3),
            parent_id                         : 0x2::object::id_to_address(&v0),
            precision                         : 1000000000000000000,
            pool_balance_after                : 0x2::balance::value<T1>(&v2.balance),
            staked_shares_after               : v2.staked_shares,
            cumulative_reward_per_share_after : v2.cumulative_reward_per_share,
            carry_after                       : v2.carry,
            cumulative_deposits_after         : v2.cumulative_deposits,
        };
        0x2::event::emit<RoyaltyPoolCreatedEvent<T0, T1>>(v4);
        v2
    }

    public fun pending_rewards<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: &0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(arg1, &v0)) {
            return 0
        };
        let v1 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(arg1, &v0);
        if (0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_pool_id(v1) != 0x2::object::id<RoyaltyPool<T0, T1>>(arg0)) {
            return 0
        };
        calculate_reward(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(arg1), 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(v1), arg0.cumulative_reward_per_share)
    }

    public fun recover_coins<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) : u64 {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>(&arg1);
        let v2 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_and_send_funds<T1>(&mut arg0.id, arg1, v0);
        if (v1 > 0) {
            let v3 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
            let v4 = RoyaltyPoolCoinsRecoveredEvent<T0, T1>{
                pool_id                           : 0x2::object::id_to_address(&v3),
                coin_count                        : v1,
                funds_recipient                   : v0,
                value                             : v2,
                pool_balance_after                : 0x2::balance::value<T1>(&arg0.balance),
                staked_shares_after               : arg0.staked_shares,
                cumulative_reward_per_share_after : arg0.cumulative_reward_per_share,
                carry_after                       : arg0.carry,
                cumulative_deposits_after         : arg0.cumulative_deposits,
            };
            0x2::event::emit<RoyaltyPoolCoinsRecoveredEvent<T0, T1>>(v4);
        };
        v2
    }

    public fun register_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(arg1, &v0), 2);
        let v1 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v2 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(arg1);
        let v3 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(arg1);
        let v4 = (v3 as u256) * arg0.cumulative_reward_per_share;
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::add_registration<T0>(arg1, v0, 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::new_registration(v1, v4));
        arg0.staked_shares = arg0.staked_shares + v3;
        let v5 = StakeRegisteredEvent<T0, T1>{
            pool_id                           : 0x2::object::id_to_address(&v1),
            stake_id                          : 0x2::object::id_to_address(&v2),
            staked_amount                     : v3,
            registration_debt_after           : v4,
            stake_registration_count_after    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(arg1),
            pool_balance_after                : 0x2::balance::value<T1>(&arg0.balance),
            staked_shares_after               : arg0.staked_shares,
            cumulative_reward_per_share_after : arg0.cumulative_reward_per_share,
            carry_after                       : arg0.carry,
            cumulative_deposits_after         : arg0.cumulative_deposits,
        };
        0x2::event::emit<StakeRegisteredEvent<T0, T1>>(v5);
    }

    public fun settle<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        if (arg0.staked_shares == 0) {
            return 0
        };
        let v0 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_settled_balance<T1>(&mut arg0.id, arg1);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return 0
        };
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = arg0.cumulative_reward_per_share;
        let v3 = arg0.carry;
        deposit_balance<T0, T1>(arg0, v0);
        let v4 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v5 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v6 = 0x2::object::id<0x2::accumulator::AccumulatorRoot>(arg1);
        let v7 = RoyaltyPoolFundsSettledEvent<T0, T1>{
            pool_id                            : 0x2::object::id_to_address(&v4),
            source_address                     : 0x2::object::id_to_address(&v5),
            accumulator_root_id                : 0x2::object::id_to_address(&v6),
            value                              : v1,
            cumulative_reward_per_share_before : v2,
            carry_before                       : v3,
            pool_balance_after                 : 0x2::balance::value<T1>(&arg0.balance),
            staked_shares_after                : arg0.staked_shares,
            cumulative_reward_per_share_after  : arg0.cumulative_reward_per_share,
            carry_after                        : arg0.carry,
            cumulative_deposits_after          : arg0.cumulative_deposits,
        };
        0x2::event::emit<RoyaltyPoolFundsSettledEvent<T0, T1>>(v7);
        v1
    }

    public fun settled_value<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::settled_balance_value<T1>(&arg0.id, arg1)
    }

    public fun share<T0, T1>(arg0: RoyaltyPool<T0, T1>) {
        0x2::transfer::share_object<RoyaltyPool<T0, T1>>(arg0);
    }

    public fun staked_shares<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u64 {
        arg0.staked_shares
    }

    public fun unregister_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(arg1, &v0), 3);
        let v1 = 0x2::object::id<RoyaltyPool<T0, T1>>(arg0);
        let v2 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(arg1);
        let v3 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(arg1);
        let v4 = arg0.cumulative_reward_per_share;
        let v5 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(arg1, &v0);
        assert!(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_pool_id(v5) == v1, 4);
        assert!(calculate_reward(v3, 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(v5), v4) == 0, 5);
        let v6 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(v5);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::remove_registration<T0>(arg1, &v0);
        arg0.staked_shares = arg0.staked_shares - v3;
        let v7 = StakeUnregisteredEvent<T0, T1>{
            pool_id                           : 0x2::object::id_to_address(&v1),
            stake_id                          : 0x2::object::id_to_address(&v2),
            unstaked_amount                   : v3,
            removed_registration_debt         : v6,
            forfeited_reward_numerator        : (v3 as u256) * v4 - v6,
            stake_registration_count_after    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(arg1),
            pool_balance_after                : 0x2::balance::value<T1>(&arg0.balance),
            staked_shares_after               : arg0.staked_shares,
            cumulative_reward_per_share_after : arg0.cumulative_reward_per_share,
            carry_after                       : arg0.carry,
            cumulative_deposits_after         : arg0.cumulative_deposits,
        };
        0x2::event::emit<StakeUnregisteredEvent<T0, T1>>(v7);
    }

    // decompiled from Move bytecode v7
}

