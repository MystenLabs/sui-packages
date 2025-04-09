module 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::bond_pool {
    struct StakedEvent has copy, drop {
        staker: address,
        stake_amount: u64,
        share_amount: u64,
    }

    struct UnstakedEvent has copy, drop {
        staker: address,
        share_amount: u64,
        unstaked_amount: u64,
        remaining_amount: u64,
    }

    struct MinStakeChangedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct UnstakeFeeThresholdChangedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct BaseUnstakeFeeChangedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct BaseRewardFeeChangedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct RewardsThresholdChangedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct RewardsUpdated has copy, drop {
        value: u64,
    }

    struct StakedUpdated has copy, drop {
        total_staked: u64,
        epoch: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        to: address,
        value: u64,
    }

    struct StakeCollectedEvent has copy, drop {
        to: address,
        value: u64,
    }

    struct PausedEvent has copy, drop {
        paused: bool,
    }

    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct RatioUpdatedEvent has copy, drop {
        ratio: u256,
    }

    struct LeaderboardEntry has copy, drop, store {
        user: address,
        weighted_stake: u64,
    }

    struct BondPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pending: 0x2::coin::Coin<T0>,
        collectable_fee: 0x2::coin::Coin<T0>,
        collectable_stake: 0x2::coin::Coin<T0>,
        cb_metadata: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::Metadata,
        total_staked: 0x2::table::Table<u64, u64>,
        staked_update_epoch: u64,
        total_users_stake: u64,
        total_weighted_stake: u64,
        reward_pool: u64,
        base_unstake_fee: u64,
        unstake_fee_threshold: u64,
        base_reward_fee: u64,
        version: u64,
        paused: bool,
        min_stake: u64,
        total_rewards: u64,
        collected_rewards: u64,
        rewards_threshold: u64,
        rewards_update_ts: u64,
        tier_thresholds: 0x2::vec_map::VecMap<u64, u64>,
        tier_name: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
        tier_url: 0x2::vec_map::VecMap<u64, 0x2::url::Url>,
        whitelisted_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        leaderboard: vector<LeaderboardEntry>,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Balances<phantom T0> has store {
        available_amount: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
    }

    public fun add_tier<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        assert!(!0x2::vec_map::contains<u64, u64>(&arg0.tier_thresholds, &arg1), 114);
        0x2::vec_map::insert<u64, u64>(&mut arg0.tier_thresholds, arg1, arg2);
        0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg0.tier_name, arg1, arg3);
        0x2::vec_map::insert<u64, 0x2::url::Url>(&mut arg0.tier_url, arg1, 0x2::url::new_unsafe_from_bytes(arg4));
    }

    public fun add_total_rewards<T0>(arg0: &mut BondPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.reward_pool = arg0.reward_pool + 0x2::coin::value<T0>(&arg1);
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v0).available_amount, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun add_total_staked_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = v0 + 1;
        if (!0x2::table::contains<u64, u64>(&arg0.total_staked, v0)) {
            let v2 = *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch);
            arg0.staked_update_epoch = v0;
            0x2::table::add<u64, u64>(&mut arg0.total_staked, v0, v2);
            let v3 = StakedUpdated{
                total_staked : v2,
                epoch        : v0,
            };
            0x2::event::emit<StakedUpdated>(v3);
        };
        let v4 = if (0x2::table::contains<u64, u64>(&arg0.total_staked, v1)) {
            let v5 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.total_staked, v1);
            *v5 = *v5 + arg1;
            *v5
        } else {
            arg0.staked_update_epoch = v1;
            let v6 = *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch) + arg1;
            0x2::table::add<u64, u64>(&mut arg0.total_staked, v1, v6);
            v6
        };
        let v7 = StakedUpdated{
            total_staked : v4,
            epoch        : v1,
        };
        0x2::event::emit<StakedUpdated>(v7);
    }

    public fun add_whitelisted_token<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelisted_tokens, 0x1::type_name::get<T0>());
    }

    fun apply_proportion(arg0: u64, arg1: 0x1::uq64_64::UQ64_64) : u128 {
        0x1::uq64_64::int_mul((arg0 as u128), arg1)
    }

    fun apply_time_factor(arg0: u128, arg1: 0x1::uq64_64::UQ64_64) : u64 {
        0x1::uq64_64::to_int(0x1::uq64_64::mul(0x1::uq64_64::from_raw(arg0), arg1))
    }

    fun assert_version<T0>(arg0: &BondPool<T0>) {
        assert!(arg0.version == 1 - 1 || arg0.version == 1, 1);
    }

    public entry fun burn_cb<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_cb_non_entry<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun burn_cb_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        assert!(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_unlocked(&arg1, arg3), 104);
        let (v0, _, _) = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::unwrap_convertible_bond(&mut arg0.cb_metadata, arg1, arg2, arg4);
        0x2::coin::from_balance<T0>(0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0.pending, v0, arg4)), arg4)
    }

    fun calculate_base_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 116);
        assert!(arg1 >= arg0, 117);
        assert!(arg2 <= arg3, 1);
        calculate_total_withdrawable(arg1);
        calculate_individual_withdrawable(arg0);
        apply_time_factor(apply_proportion(calculate_base_fee(arg0, arg4), calculate_proportion(arg0, arg1)), calculate_time_factor(arg2, arg3))
    }

    fun calculate_individual_withdrawable(arg0: u64) : u64 {
        arg0 * 1000 / 10000
    }

    public fun calculate_multiplier(arg0: u64, arg1: u64) : u64 {
        let v0 = arg1 - arg0;
        if (v0 < 10) {
            return 1
        };
        if (v0 < 30) {
            return 2
        };
        3
    }

    fun calculate_proportion(arg0: u64, arg1: u64) : 0x1::uq64_64::UQ64_64 {
        0x1::uq64_64::from_quotient((arg0 as u128), (arg1 as u128))
    }

    fun calculate_reward_fee<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::mul_div(arg1, arg0.base_reward_fee, 10000)
    }

    public fun calculate_rewards<T0>(arg0: &BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_last_claimed_epoch(arg1);
        let v2 = 0;
        let v3 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_epoch_snapshots(arg1);
        while (v2 < 0x1::vector::length<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::EpochSnapshot>(&v3)) {
            let v4 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_epoch_snapshots(arg1);
            let (v5, v6, v7, v8) = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_bond_epoch_snapshot_value(0x1::vector::borrow<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::EpochSnapshot>(&v4, v2));
            if (v5 > v1) {
                let v9 = arg0.reward_pool * v6 * v7 * v8 / arg0.total_weighted_stake;
                v0 = v0 + v9;
                0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_cumulative_rewards(arg1, v9);
                v1 = v5;
            };
            v2 = v2 + 1;
        };
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_unclaimed_rewards(arg1, v0);
    }

    fun calculate_time_factor(arg0: u64, arg1: u64) : 0x1::uq64_64::UQ64_64 {
        0x1::uq64_64::sub(0x1::uq64_64::from_quotient((10000 as u128), (10000 as u128)), 0x1::uq64_64::from_quotient((arg0 as u128), (arg1 as u128)))
    }

    public fun calculate_time_weight(arg0: u64, arg1: u64) : u64 {
        let v0 = arg1 - arg0;
        if (v0 < 10) {
            return 1
        };
        if (v0 < 30) {
            return 2
        };
        3
    }

    fun calculate_total_withdrawable(arg0: u64) : u64 {
        arg0 * 1000 / 10000
    }

    public fun calculate_unstake_fee<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::mul_div(arg1, arg0.base_unstake_fee, 10000)
    }

    public entry fun change_base_reward_fee<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 < 10000, 109);
        let v0 = BaseRewardFeeChangedEvent{
            prev_value : arg0.base_reward_fee,
            new_value  : arg2,
        };
        0x2::event::emit<BaseRewardFeeChangedEvent>(v0);
        arg0.base_reward_fee = arg2;
    }

    public entry fun change_base_unstake_fee<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 < 10000, 109);
        let v0 = BaseUnstakeFeeChangedEvent{
            prev_value : arg0.base_unstake_fee,
            new_value  : arg2,
        };
        0x2::event::emit<BaseUnstakeFeeChangedEvent>(v0);
        arg0.base_unstake_fee = arg2;
    }

    public entry fun change_min_stake<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 > 1000, 102);
        let v0 = MinStakeChangedEvent{
            prev_value : arg0.min_stake,
            new_value  : arg2,
        };
        0x2::event::emit<MinStakeChangedEvent>(v0);
        arg0.min_stake = arg2;
    }

    public entry fun change_unstake_fee_threshold<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 > 0, 102);
        assert!(arg2 < 10000, 109);
        let v0 = UnstakeFeeThresholdChangedEvent{
            prev_value : arg0.unstake_fee_threshold,
            new_value  : arg2,
        };
        0x2::event::emit<UnstakeFeeThresholdChangedEvent>(v0);
        arg0.unstake_fee_threshold = arg2;
    }

    public entry fun check_unclaimed_reward<T0>(arg0: &BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &0x2::clock::Clock) : u64 {
        calculate_rewards<T0>(arg0, arg1, arg2);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unclaimed_rewards(arg1)
    }

    entry fun claim_rewards<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards_non_entry<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun claim_rewards_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        calculate_rewards<T0>(arg0, arg1, arg2);
        let v0 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unclaimed_rewards(arg1);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_unclaimed_rewards(arg1, 0);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_last_claimed_epoch(arg1, 0x2::tx_context::epoch(arg3));
        arg0.reward_pool = arg0.reward_pool - v0;
        let v1 = BalanceKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v1).available_amount, v0), arg3)
    }

    public entry fun collect_fee<T0>(arg0: &mut BondPool<T0>, arg1: address, arg2: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg0.collectable_fee);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.collectable_fee, v0, arg3), arg1);
        let v1 = FeeCollectedEvent{
            to    : arg1,
            value : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    public entry fun collect_stake<T0>(arg0: &mut BondPool<T0>, arg1: address, arg2: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg0.collectable_stake);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.collectable_stake, v0, arg3), arg1);
        let v1 = StakeCollectedEvent{
            to    : arg1,
            value : v0,
        };
        0x2::event::emit<StakeCollectedEvent>(v1);
    }

    public fun compare_entries(arg0: &LeaderboardEntry, arg1: &LeaderboardEntry) : bool {
        arg0.weighted_stake > arg1.weighted_stake
    }

    entry fun convert_cb<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::Metadata<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), 119);
        if (0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_unlocked(&arg1, arg4)) {
            let v0 = convert_cb_non_entry<T0>(arg0, arg1, arg2, 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), arg4, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>>(v0, 0x2::tx_context::sender(arg5));
        } else {
            let v1 = convert_cb_non_entry<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>>(v1, 0x2::tx_context::sender(arg5));
        };
    }

    public fun convert_cb_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::Metadata<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT> {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        0x2::clock::timestamp_ms(arg4);
        let v0 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_unlocked(&arg1, arg4);
        let v1 = 0x2::tx_context::epoch(arg5);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_bond_epoch_snapshot_on_unstake(&mut arg1, v1, arg3, calculate_multiplier(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v1), calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v1));
        arg0.total_users_stake = arg0.total_users_stake - arg3;
        arg0.total_weighted_stake = arg0.total_weighted_stake - arg3 * calculate_multiplier(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v1) * calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v1);
        let v2 = to_shares<T0>(arg0, arg3);
        let v3 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::mint(arg2, v2, arg5);
        if (v0) {
            let v4 = BalanceKey{dummy_field: false};
            0x2::coin::join<T0>(&mut arg0.collectable_stake, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v4).available_amount, arg3), arg5));
            burn_cb<T0>(arg0, arg1, 0, arg4, arg5);
        } else {
            let v5 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1) - arg3;
            let v6 = &arg0.tier_thresholds;
            let v7 = 0;
            let v8 = 1;
            while (v7 < 0x2::vec_map::size<u64, u64>(v6)) {
                if (*0x2::vec_map::get<u64, u64>(v6, &v7) >= v5) {
                    v8 = v7 + 1;
                    break
                };
                let v9 = v7;
                v7 = v9 + 1;
            };
            let v10 = calculate_fee(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), arg0.total_users_stake, 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_duration(&arg1) - 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1) - 0x2::clock::timestamp_ms(arg4), 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1), arg0.base_unstake_fee);
            if (0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_compensation(&arg1)) {
                v10 = 0x1::uq64_64::to_int(0x1::uq64_64::from_quotient((arg3 as u128), (2 as u128)));
            };
            let v11 = arg3 - v10;
            let v12 = BalanceKey{dummy_field: false};
            let v13 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v12);
            0x2::coin::join<T0>(&mut arg0.collectable_fee, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13.available_amount, v10), arg5));
            0x2::coin::join<T0>(&mut arg0.collectable_stake, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13.available_amount, v11), arg5));
            let v14 = UnstakedEvent{
                staker           : 0x2::tx_context::sender(arg5),
                share_amount     : to_shares<T0>(arg0, v11),
                unstaked_amount  : arg3,
                remaining_amount : v5,
            };
            0x2::event::emit<UnstakedEvent>(v14);
            0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::convert_convertible_bond(&mut arg0.cb_metadata, &mut arg1, *0x2::vec_map::get<u64, 0x1::string::String>(&arg0.tier_name, &v7), v8, v5, 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_shares(&arg1) - v2, *0x2::vec_map::get<u64, 0x2::url::Url>(&arg0.tier_url, &v7), !v0, v10, arg5);
            0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::transfer(arg1, 0x2::tx_context::sender(arg5));
        };
        v3
    }

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u64, u64>(arg0);
        0x2::table::add<u64, u64>(&mut v0, 0, 0);
        let v1 = BondPool<T0>{
            id                    : 0x2::object::new(arg0),
            pending               : 0x2::coin::zero<T0>(arg0),
            collectable_fee       : 0x2::coin::zero<T0>(arg0),
            collectable_stake     : 0x2::coin::zero<T0>(arg0),
            cb_metadata           : 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::create_metadata(arg0),
            total_staked          : v0,
            staked_update_epoch   : 0,
            total_users_stake     : 0,
            total_weighted_stake  : 0,
            reward_pool           : 0,
            base_unstake_fee      : 5,
            unstake_fee_threshold : 1000,
            base_reward_fee       : 1000,
            version               : 1,
            paused                : false,
            min_stake             : 1000000000,
            total_rewards         : 0,
            collected_rewards     : 0,
            rewards_threshold     : 100,
            rewards_update_ts     : 0,
            tier_thresholds       : 0x2::vec_map::empty<u64, u64>(),
            tier_name             : 0x2::vec_map::empty<u64, 0x1::string::String>(),
            tier_url              : 0x2::vec_map::empty<u64, 0x2::url::Url>(),
            whitelisted_tokens    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            leaderboard           : 0x1::vector::empty<LeaderboardEntry>(),
        };
        let v2 = BalanceKey{dummy_field: false};
        let v3 = Balances<T0>{
            available_amount : 0x2::balance::zero<T0>(),
            fees             : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_field::add<BalanceKey, Balances<T0>>(&mut v1.id, v2, v3);
        0x2::transfer::share_object<BondPool<T0>>(v1);
    }

    public fun from_shares<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::from_shares(get_ratio<T0>(arg0), arg1)
    }

    public fun get_base_multiplier(arg0: u64) : u64 {
        if (arg0 >= 31536000) {
            return 3
        };
        if (arg0 >= 15768000) {
            return 2
        };
        1
    }

    entry fun get_leaderboard<T0>(arg0: &BondPool<T0>) : vector<LeaderboardEntry> {
        arg0.leaderboard
    }

    public fun get_min_stake<T0>(arg0: &BondPool<T0>) : u64 {
        arg0.min_stake
    }

    public fun get_pending<T0>(arg0: &BondPool<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.pending)
    }

    public fun get_ratio<T0>(arg0: &BondPool<T0>) : u256 {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::ratio(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_total_convertible_shares(&arg0.cb_metadata), 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_total_stake_supply(&arg0.cb_metadata))
    }

    public entry fun get_reward_pool<T0>(arg0: &BondPool<T0>) : u64 {
        arg0.reward_pool
    }

    entry fun get_shares<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        to_shares<T0>(arg0, arg1)
    }

    entry fun get_stake_from_shares<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        from_shares<T0>(arg0, arg1)
    }

    public fun get_total_active_stake<T0>(arg0: &BondPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.staked_update_epoch;
        let v1 = v0;
        let v2 = 0x2::tx_context::epoch(arg1);
        if (v0 > v2) {
            v1 = v2;
        };
        *0x2::table::borrow<u64, u64>(&arg0.total_staked, v1) + get_pending<T0>(arg0)
    }

    public fun get_total_rewards<T0>(arg0: &BondPool<T0>) : u64 {
        arg0.total_rewards - arg0.collected_rewards
    }

    public fun get_total_staked<T0>(arg0: &BondPool<T0>) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch) + get_pending<T0>(arg0)
    }

    public fun get_unstake_fee_threshold<T0>(arg0: &BondPool<T0>) : u64 {
        arg0.unstake_fee_threshold
    }

    public fun get_whitelisted_tokens<T0>(arg0: &BondPool<T0>) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.whitelisted_tokens)
    }

    public fun is_threshold_used<T0>(arg0: &BondPool<T0>, arg1: u64) : bool {
        let v0 = &arg0.tier_thresholds;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<u64, u64>(v0)) {
            if (0x2::vec_map::get_idx<u64, u64>(v0, &v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun is_token_whitelisted<T0>(arg0: &BondPool<T0>) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_tokens, &v0)
    }

    entry fun migrate<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public entry fun mint_cb<T0>(arg0: &mut BondPool<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::transfer(mint_cb_non_entry<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::url::new_unsafe_from_bytes(arg7), arg8, arg11, arg12), 0x2::address::from_bytes(arg9));
    }

    public fun mint_cb_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: 0x2::url::Url, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::wrap_convertible_bond(&mut arg0.cb_metadata, arg1, arg2, arg3, arg4, arg5, arg7, arg6, 0x2::clock::timestamp_ms(arg9) + arg6, arg8, arg10)
    }

    public entry fun new_stake<T0>(arg0: &mut BondPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = new_stake_non_entry<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::transfer(v0, 0x2::tx_context::sender(arg5));
    }

    public fun new_stake_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        validate_stake<T0>(&arg1, arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = get_base_multiplier(arg3);
        0x2::tx_context::epoch(arg5);
        let v2 = to_shares<T0>(arg0, v0);
        arg0.total_users_stake = arg0.total_users_stake + v0;
        arg0.total_weighted_stake = arg0.total_weighted_stake + v0 * v1;
        let v3 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v3).available_amount, 0x2::coin::into_balance<T0>(arg1));
        let v4 = StakedEvent{
            staker       : 0x2::tx_context::sender(arg5),
            stake_amount : v0,
            share_amount : v2,
        };
        0x2::event::emit<StakedEvent>(v4);
        let v5 = &arg0.tier_thresholds;
        let v6 = 0;
        let v7 = 1;
        while (v6 < 0x2::vec_map::size<u64, u64>(v5)) {
            if (*0x2::vec_map::get<u64, u64>(v5, &v6) >= v0) {
                v7 = v6 + 1;
                break
            };
            let v8 = v6;
            v6 = v8 + 1;
        };
        let v9 = *0x2::vec_map::get<u64, 0x1::string::String>(&arg0.tier_name, &v6);
        let v10 = *0x2::vec_map::get<u64, 0x2::url::Url>(&arg0.tier_url, &v6);
        mint_cb_non_entry<T0>(arg0, v9, v7, v0, v2, arg2, arg3, v10, v1, arg4, arg5)
    }

    public fun preview_cb_epoch<T0>(arg0: &BondPool<T0>, arg1: &0x2::coin::Coin<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_total_unstake_supply(&arg0.cb_metadata) + from_shares<T0>(arg0, 0x2::coin::value<0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::gut::GUT>(arg1)) > arg0.total_users_stake) {
            return 0x2::tx_context::epoch(arg2) + 1
        };
        0x2::tx_context::epoch(arg2)
    }

    public entry fun publish_ratio<T0>(arg0: &BondPool<T0>) {
        let v0 = RatioUpdatedEvent{ratio: get_ratio<T0>(arg0)};
        0x2::event::emit<RatioUpdatedEvent>(v0);
    }

    public fun remove_tier<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.tier_thresholds, &arg1), 115);
        let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.tier_thresholds, &arg1);
        let (_, _) = 0x2::vec_map::remove<u64, 0x1::string::String>(&mut arg0.tier_name, &arg1);
        let (_, _) = 0x2::vec_map::remove<u64, 0x2::url::Url>(&mut arg0.tier_url, &arg1);
    }

    public fun remove_whitelisted_token<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_tokens, &v0);
    }

    public entry fun set_pause<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    fun set_rewards_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64) {
        arg0.total_rewards = arg1;
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    public fun sort_leaderboard_descending(arg0: &mut vector<LeaderboardEntry>) {
        let v0 = 0x1::vector::length<LeaderboardEntry>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 0;
        while (v1 < v0 - 1) {
            let v2 = 0;
            while (v2 < v0 - v1 - 1) {
                if (0x1::vector::borrow<LeaderboardEntry>(arg0, v2).weighted_stake < 0x1::vector::borrow<LeaderboardEntry>(arg0, v2 + 1).weighted_stake) {
                    0x1::vector::swap<LeaderboardEntry>(arg0, v2, v2 + 1);
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun sub_rewards_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64) {
        if (arg1 > arg0.total_rewards) {
            arg0.total_rewards = 0;
        } else {
            arg0.total_rewards = arg0.total_rewards - arg1;
        };
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    public fun sub_total_staked_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = v0 + 1;
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.total_staked, v0)) {
            let v3 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.total_staked, v0);
            *v3 = *v3 - arg1;
            *v3
        } else {
            arg0.staked_update_epoch = v0;
            let v4 = *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch) - arg1;
            0x2::table::add<u64, u64>(&mut arg0.total_staked, v0, v4);
            v4
        };
        let v5 = StakedUpdated{
            total_staked : v2,
            epoch        : v0,
        };
        0x2::event::emit<StakedUpdated>(v5);
        if (0x2::table::contains<u64, u64>(&arg0.total_staked, v1)) {
            let v6 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.total_staked, v1);
            *v6 = *v6 - arg1;
            v2 = *v6;
        } else {
            let v7 = *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch);
            v2 = v7;
            arg0.staked_update_epoch = v1;
            0x2::table::add<u64, u64>(&mut arg0.total_staked, v1, v7);
        };
        let v8 = StakedUpdated{
            total_staked : v2,
            epoch        : v1,
        };
        0x2::event::emit<StakedUpdated>(v8);
    }

    public fun to_shares<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::to_shares(get_ratio<T0>(arg0), arg1)
    }

    public entry fun unstake<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_compensation(&arg1), 120);
        unstake_non_entry<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun unstake_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg2 <= 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), 118);
        calculate_multiplier(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v0);
        calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v0);
        let v1 = calculate_multiplier(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v0);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_bond_epoch_snapshot_on_unstake(&mut arg1, v0, arg2, v1, calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v0));
        let v2 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_unlocked(&arg1, arg3);
        0x2::tx_context::sender(arg4);
        if (v2) {
            arg0.total_users_stake = arg0.total_users_stake - 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1);
            burn_cb<T0>(arg0, arg1, 0, arg3, arg4);
        } else if (arg2 == 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1)) {
            let v3 = calculate_fee(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), arg0.total_users_stake, 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_duration(&arg1) - 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1) - 0x2::clock::timestamp_ms(arg3), 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1), arg0.base_unstake_fee);
            arg0.total_users_stake = arg0.total_users_stake - 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1);
            burn_cb<T0>(arg0, arg1, v3, arg3, arg4);
        } else {
            let v4 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1) - arg2;
            let v5 = 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_shares(&arg1) - to_shares<T0>(arg0, arg2);
            let v6 = UnstakedEvent{
                staker           : 0x2::tx_context::sender(arg4),
                share_amount     : v5,
                unstaked_amount  : arg2,
                remaining_amount : v4,
            };
            0x2::event::emit<UnstakedEvent>(v6);
            let v7 = &arg0.tier_thresholds;
            let v8 = 0;
            let v9 = 1;
            while (v8 <= 0x2::vec_map::size<u64, u64>(v7)) {
                if (*0x2::vec_map::get<u64, u64>(v7, &v8) >= v4) {
                    v9 = v8 + 1;
                    break
                };
                let v10 = v8;
                v8 = v10 + 1;
            };
            arg0.total_users_stake = arg0.total_users_stake - arg2;
            0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::withdraw_stake_convertible_bond(&mut arg0.cb_metadata, &mut arg1, *0x2::vec_map::get<u64, 0x1::string::String>(&arg0.tier_name, &v8), v9, v4, v5, *0x2::vec_map::get<u64, 0x2::url::Url>(&arg0.tier_url, &v8), !v2, calculate_fee(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(&arg1), arg0.total_users_stake, 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_duration(&arg1) - 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1) - 0x2::clock::timestamp_ms(arg3), 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_unlock_time(&arg1), arg0.base_unstake_fee), arg4);
            arg0.total_users_stake = arg0.total_users_stake - arg2;
            arg0.total_weighted_stake = arg0.total_weighted_stake - arg2 * v1 * calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(&arg1), v0);
            0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::transfer(arg1, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun update_leaderboard<T0>(arg0: &mut BondPool<T0>, arg1: address, arg2: u64, arg3: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OperatorCap) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<LeaderboardEntry>(&arg0.leaderboard)) {
            let v2 = 0x1::vector::borrow_mut<LeaderboardEntry>(&mut arg0.leaderboard, v1);
            if (v2.user == arg1) {
                v2.weighted_stake = arg2;
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (!v0) {
            let v3 = LeaderboardEntry{
                user           : arg1,
                weighted_stake : arg2,
            };
            0x1::vector::push_back<LeaderboardEntry>(&mut arg0.leaderboard, v3);
        };
        let v4 = &mut arg0.leaderboard;
        sort_leaderboard_descending(v4);
        while (0x1::vector::length<LeaderboardEntry>(&arg0.leaderboard) > 100) {
            0x1::vector::pop_back<LeaderboardEntry>(&mut arg0.leaderboard);
        };
    }

    public entry fun update_rewards<T0>(arg0: &mut BondPool<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OperatorCap) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        assert!(arg2 > arg0.total_rewards, 105);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.rewards_update_ts > 43200000, 106);
        arg0.rewards_update_ts = v0;
        assert!(arg2 <= arg0.total_rewards + 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::math::mul_div(get_total_staked<T0>(arg0), arg0.rewards_threshold, 10000), 107);
        arg0.collected_rewards = arg0.collected_rewards + calculate_reward_fee<T0>(arg0, arg2 - arg0.total_rewards);
        set_rewards_unsafe<T0>(arg0, arg2);
    }

    public entry fun update_rewards_threshold<T0>(arg0: &mut BondPool<T0>, arg1: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        assert!(arg2 > 0, 102);
        assert!(arg2 <= 10000, 109);
        let v0 = RewardsThresholdChangedEvent{
            prev_value : arg0.rewards_threshold,
            new_value  : arg2,
        };
        0x2::event::emit<RewardsThresholdChangedEvent>(v0);
        arg0.rewards_threshold = arg2;
    }

    public entry fun update_stake<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::is_compensation(arg1), 120);
        update_stake_non_entry<T0>(arg0, arg1, arg2, arg3);
    }

    public fun update_stake_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::ConvertibleBond, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg0.min_stake, 100);
        let v2 = calculate_multiplier(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(arg1), v0);
        let v3 = calculate_time_weight(0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_start_epoch(arg1), v0);
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::update_bond_epoch_snapshot_on_stake(arg1, v0, v1, v2, v3);
        arg0.total_users_stake = arg0.total_users_stake + v1;
        arg0.total_weighted_stake = arg0.total_weighted_stake + v1 * v2;
        let v4 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v4).available_amount, 0x2::coin::into_balance<T0>(arg2));
        let v5 = v1 + 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_value(arg1);
        let v6 = to_shares<T0>(arg0, v1) + 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::get_shares(arg1);
        let v7 = StakedEvent{
            staker       : 0x2::tx_context::sender(arg3),
            stake_amount : v5,
            share_amount : v6,
        };
        0x2::event::emit<StakedEvent>(v7);
        let v8 = &arg0.tier_thresholds;
        let v9 = 0;
        let v10 = 1;
        while (v9 < 0x2::vec_map::size<u64, u64>(v8)) {
            if (*0x2::vec_map::get<u64, u64>(v8, &v9) >= v5) {
                v10 = v9 + 1;
                break
            };
            let v11 = v9;
            v9 = v11 + 1;
        };
        arg0.total_users_stake = arg0.total_users_stake + v1;
        arg0.total_weighted_stake = arg0.total_weighted_stake + v1 * v2 * v3;
        0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb::add_stake_convertible_bond(&mut arg0.cb_metadata, arg1, *0x2::vec_map::get<u64, 0x1::string::String>(&arg0.tier_name, &v9), v10, v5, v6, *0x2::vec_map::get<u64, 0x2::url::Url>(&arg0.tier_url, &v9), arg3);
    }

    public fun update_tier_threshold<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: u64, arg3: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.tier_thresholds, &arg1), 115);
        0x2::vec_map::insert<u64, u64>(&mut arg0.tier_thresholds, arg1, arg2);
    }

    public fun validate_stake<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &BondPool<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelisted_tokens, &v0), 111);
        assert!(0x2::coin::value<T0>(arg0) >= arg1.min_stake, 100);
    }

    fun when_not_paused<T0>(arg0: &BondPool<T0>) {
        assert!(!arg0.paused, 101);
    }

    public fun whitelist_size<T0>(arg0: &BondPool<T0>) : u64 {
        0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.whitelisted_tokens)
    }

    public fun withdraw<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v0).available_amount, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

