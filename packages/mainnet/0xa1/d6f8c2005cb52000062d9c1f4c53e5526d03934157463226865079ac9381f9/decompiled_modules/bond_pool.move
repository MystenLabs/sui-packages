module 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::bond_pool {
    struct StakedEvent has copy, drop {
        staker: address,
        stake_amount: u64,
        share_amount: u64,
    }

    struct UnstakedEvent has copy, drop {
        staker: address,
        share_amount: u64,
        stake_amount: u64,
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

    struct BondPool<phantom T0> has key {
        id: 0x2::object::UID,
        pending: 0x2::coin::Coin<T0>,
        collectable_fee: 0x2::coin::Coin<T0>,
        cb_metadata: 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::Metadata,
        total_staked: 0x2::table::Table<u64, u64>,
        staked_update_epoch: u64,
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
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Balances<phantom T0> has store {
        available_amount: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
    }

    fun add_total_staked_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun assert_version<T0>(arg0: &BondPool<T0>) {
        assert!(arg0.version == 1 - 1 || arg0.version == 1, 1);
    }

    public entry fun burn_cb<T0>(arg0: &mut BondPool<T0>, arg1: 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::ConvertibleBond, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_cb_non_entry<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun burn_cb_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::ConvertibleBond, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        assert!(0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::is_unlocked(&arg1, arg2), 104);
        let (v0, _) = 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::unwrap_convertible_bond(&mut arg0.cb_metadata, arg1, arg2);
        0x2::coin::from_balance<T0>(0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0.pending, v0, arg2)), arg2)
    }

    fun calculate_reward_fee<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::mul_div(arg1, arg0.base_reward_fee, 10000)
    }

    public fun calculate_unstake_fee<T0>(arg0: &BondPool<T0>, arg1: u64) : u64 {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::mul_div(arg1, arg0.base_unstake_fee, 10000)
    }

    public entry fun change_base_reward_fee<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 < 10000, 109);
        let v0 = BaseRewardFeeChangedEvent{
            prev_value : arg0.base_reward_fee,
            new_value  : arg2,
        };
        0x2::event::emit<BaseRewardFeeChangedEvent>(v0);
        arg0.base_reward_fee = arg2;
    }

    public entry fun change_base_unstake_fee<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 < 10000, 109);
        let v0 = BaseUnstakeFeeChangedEvent{
            prev_value : arg0.base_unstake_fee,
            new_value  : arg2,
        };
        0x2::event::emit<BaseUnstakeFeeChangedEvent>(v0);
        arg0.base_unstake_fee = arg2;
    }

    public entry fun change_min_stake<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 > 1000, 102);
        let v0 = MinStakeChangedEvent{
            prev_value : arg0.min_stake,
            new_value  : arg2,
        };
        0x2::event::emit<MinStakeChangedEvent>(v0);
        arg0.min_stake = arg2;
    }

    public entry fun change_unstake_fee_threshold<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: u64) {
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

    public entry fun collect_fee<T0>(arg0: &mut BondPool<T0>, arg1: address, arg2: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
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

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u64, u64>(arg0);
        0x2::table::add<u64, u64>(&mut v0, 0, 0);
        let v1 = BondPool<T0>{
            id                    : 0x2::object::new(arg0),
            pending               : 0x2::coin::zero<T0>(arg0),
            collectable_fee       : 0x2::coin::zero<T0>(arg0),
            cb_metadata           : 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::create_metadata(arg0),
            total_staked          : v0,
            staked_update_epoch   : 0,
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
        };
        let v2 = BalanceKey{dummy_field: false};
        let v3 = Balances<T0>{
            available_amount : 0x2::balance::zero<T0>(),
            fees             : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_field::add<BalanceKey, Balances<T0>>(&mut v1.id, v2, v3);
        0x2::transfer::share_object<BondPool<T0>>(v1);
    }

    public fun from_shares<T0>(arg0: &BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: u64) : u64 {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::from_shares(get_ratio<T0>(arg0, arg1), arg2)
    }

    public fun get_min_stake<T0>(arg0: &BondPool<T0>) : u64 {
        arg0.min_stake
    }

    public fun get_pending<T0>(arg0: &BondPool<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.pending)
    }

    public fun get_ratio<T0>(arg0: &BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>) : u256 {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::ratio(0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::get_total_supply_value(arg1), get_total_staked<T0>(arg0) + get_total_rewards<T0>(arg0) - 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::get_total_unstake_supply(&arg0.cb_metadata))
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

    entry fun migrate<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public entry fun mint_cb<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::transfer(mint_cb_non_entry<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public fun mint_cb_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::ConvertibleBond {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::wrap_convertible_bond(&mut arg0.cb_metadata, arg2, arg3, true, 0, arg4, 0, 0x2::clock::timestamp_ms(arg6) + arg5, arg7)
    }

    public fun preview_cb_epoch<T0>(arg0: &BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: &0x2::coin::Coin<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg3: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = get_total_active_stake<T0>(arg0, arg4);
        if (0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::get_total_unstake_supply(&arg0.cb_metadata) + from_shares<T0>(arg0, arg1, 0x2::coin::value<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>(arg2)) > v0) {
            return 0x2::tx_context::epoch(arg4) + 1
        };
        0x2::tx_context::epoch(arg4)
    }

    public entry fun publish_ratio<T0>(arg0: &BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>) {
        let v0 = RatioUpdatedEvent{ratio: get_ratio<T0>(arg0, arg1)};
        0x2::event::emit<RatioUpdatedEvent>(v0);
    }

    public entry fun set_pause<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    fun set_rewards_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64) {
        arg0.total_rewards = arg1;
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    public entry fun stake<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = stake_non_entry<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::transfer(v0, 0x2::tx_context::sender(arg5));
    }

    public fun stake_non_entry<T0>(arg0: &mut BondPool<T0>, arg1: &mut 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::ConvertibleBond {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_stake, 100);
        let v1 = to_shares<T0>(arg0, arg1, v0);
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v2).available_amount, 0x2::coin::into_balance<T0>(arg2));
        let v3 = StakedEvent{
            staker       : 0x2::tx_context::sender(arg5),
            stake_amount : v0,
            share_amount : v1,
        };
        0x2::event::emit<StakedEvent>(v3);
        let v4 = if (v0 > 1000 && v0 < 5000) {
            0
        } else if (v0 > 5000 && v0 < 10000) {
            1
        } else {
            2
        };
        mint_cb_non_entry<T0>(arg0, arg1, v4, v0, v1, arg3, arg4, arg5)
    }

    fun sub_rewards_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64) {
        if (arg1 > arg0.total_rewards) {
            arg0.total_rewards = 0;
        } else {
            arg0.total_rewards = arg0.total_rewards - arg1;
        };
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    fun sub_total_staked_unsafe<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    public fun to_shares<T0>(arg0: &BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::Metadata<0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::utility::UTILITY>, arg2: u64) : u64 {
        0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::to_shares(get_ratio<T0>(arg0, arg1), arg2)
    }

    public entry fun unstake<T0>(arg0: &mut BondPool<T0>, arg1: 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::ConvertibleBond, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::is_unlocked(&arg1, arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(burn_cb_non_entry<T0>(arg0, arg1, arg2), v0);
        } else {
            0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::stake_cb::transfer(arg1, v0);
        };
    }

    public entry fun update_rewards<T0>(arg0: &mut BondPool<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OperatorCap) {
        assert_version<T0>(arg0);
        when_not_paused<T0>(arg0);
        assert!(arg2 > arg0.total_rewards, 105);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.rewards_update_ts > 43200000, 106);
        arg0.rewards_update_ts = v0;
        assert!(arg2 <= arg0.total_rewards + 0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::math::mul_div(get_total_staked<T0>(arg0), arg0.rewards_threshold, 10000), 107);
        arg0.collected_rewards = arg0.collected_rewards + calculate_reward_fee<T0>(arg0, arg2 - arg0.total_rewards);
        set_rewards_unsafe<T0>(arg0, arg2);
    }

    public entry fun update_rewards_threshold<T0>(arg0: &mut BondPool<T0>, arg1: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg2: u64) {
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

    fun when_not_paused<T0>(arg0: &BondPool<T0>) {
        assert!(!arg0.paused, 101);
    }

    public fun withdraw<T0>(arg0: &mut BondPool<T0>, arg1: u64, arg2: &0xa1d6f8c2005cb52000062d9c1f4c53e5526d03934157463226865079ac9381f9::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v0).available_amount, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

