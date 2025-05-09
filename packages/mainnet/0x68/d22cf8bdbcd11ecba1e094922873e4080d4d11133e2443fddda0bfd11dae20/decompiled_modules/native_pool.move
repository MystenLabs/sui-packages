module 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool {
    struct StakedEvent has copy, drop {
        staker: address,
        sui_amount: u64,
        cert_amount: u64,
    }

    struct UnstakedEvent has copy, drop {
        staker: address,
        cert_amount: u64,
        sui_amount: u64,
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

    struct NativePool has key {
        id: 0x2::object::UID,
        pending: 0x2::coin::Coin<0x2::sui::SUI>,
        collectable_fee: 0x2::coin::Coin<0x2::sui::SUI>,
        validator_set: 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::validator_set::ValidatorSet,
        ticket_metadata: 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::Metadata,
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

    public fun from_shares(arg0: &NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: u64) : u64 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::math::from_shares(get_ratio(arg0, arg1), arg2)
    }

    public fun to_shares(arg0: &NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: u64) : u64 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::math::to_shares(get_ratio(arg0, arg1), arg2)
    }

    fun add_total_staked_unsafe(arg0: &mut NativePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun assert_version(arg0: &NativePool) {
        assert!(arg0.version == 2 - 1 || arg0.version == 2, 1);
    }

    public entry fun burn_ticket(arg0: &mut NativePool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::UnstakeTicket, arg3: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun burn_ticket_non_entry(arg0: &mut NativePool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::UnstakeTicket, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 999
    }

    fun calculate_reward_fee(arg0: &NativePool, arg1: u64) : u64 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::math::mul_div(arg1, arg0.base_reward_fee, 10000)
    }

    public fun calculate_unstake_fee(arg0: &NativePool, arg1: u64) : u64 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::math::mul_div(arg1, arg0.base_unstake_fee, 10000)
    }

    public entry fun change_base_reward_fee(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: u64) {
        abort 999
    }

    public entry fun change_base_unstake_fee(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: u64) {
        abort 999
    }

    public entry fun change_min_stake(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: u64) {
        abort 999
    }

    public entry fun change_unstake_fee_threshold(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: u64) {
        abort 999
    }

    public entry fun collect_fee(arg0: &mut NativePool, arg1: address, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.collectable_fee);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.collectable_fee, v0, arg3), arg1);
        let v1 = FeeCollectedEvent{
            to    : arg1,
            value : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    public(friend) fun emit_ratio(arg0: u256) {
        let v0 = RatioUpdatedEvent{ratio: arg0};
        0x2::event::emit<RatioUpdatedEvent>(v0);
    }

    public(friend) fun emit_staked(arg0: address, arg1: u64, arg2: u64) {
        let v0 = StakedEvent{
            staker      : arg0,
            sui_amount  : arg1,
            cert_amount : arg2,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public(friend) fun emit_unstaked(arg0: address, arg1: u64, arg2: u64) {
        let v0 = UnstakedEvent{
            staker      : arg0,
            cert_amount : arg1,
            sui_amount  : arg2,
        };
        0x2::event::emit<UnstakedEvent>(v0);
    }

    public fun get_min_stake(arg0: &NativePool) : u64 {
        arg0.min_stake
    }

    public fun get_pending(arg0: &NativePool) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.pending)
    }

    public fun get_ratio(arg0: &NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : u256 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::math::ratio(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::get_total_supply_value(arg1), get_total_staked(arg0) + get_total_rewards(arg0) - 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::get_total_supply(&arg0.ticket_metadata))
    }

    public fun get_total_active_stake(arg0: &NativePool, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.staked_update_epoch;
        let v1 = v0;
        let v2 = 0x2::tx_context::epoch(arg1);
        if (v0 > v2) {
            v1 = v2;
        };
        *0x2::table::borrow<u64, u64>(&arg0.total_staked, v1) + get_pending(arg0)
    }

    public fun get_total_rewards(arg0: &NativePool) : u64 {
        arg0.total_rewards - arg0.collected_rewards
    }

    public fun get_total_staked(arg0: &NativePool) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.total_staked, arg0.staked_update_epoch) + get_pending(arg0)
    }

    public fun get_unstake_fee_threshold(arg0: &NativePool) : u64 {
        arg0.unstake_fee_threshold
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u64, u64>(arg0);
        0x2::table::add<u64, u64>(&mut v0, 0, 0);
        let v1 = NativePool{
            id                    : 0x2::object::new(arg0),
            pending               : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            collectable_fee       : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            validator_set         : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::validator_set::create(arg0),
            ticket_metadata       : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::create_metadata(arg0),
            total_staked          : v0,
            staked_update_epoch   : 0,
            base_unstake_fee      : 5,
            unstake_fee_threshold : 1000,
            base_reward_fee       : 1000,
            version               : 2,
            paused                : false,
            min_stake             : 1000000000,
            total_rewards         : 0,
            collected_rewards     : 0,
            rewards_threshold     : 100,
            rewards_update_ts     : 0,
        };
        0x2::transfer::share_object<NativePool>(v1);
    }

    public(friend) fun mark_cap_created(arg0: &mut NativePool) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"cap_created")) {
            abort 0
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"cap_created", true);
    }

    entry fun migrate(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap) {
        assert!(arg0.version < 2, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 2,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 2;
    }

    public entry fun mint_ticket(arg0: &mut NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun mint_ticket_non_entry(arg0: &mut NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x2::tx_context::TxContext) : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::UnstakeTicket {
        abort 999
    }

    public(friend) fun mut_collected_rewards(arg0: &mut NativePool) : &mut u64 {
        &mut arg0.collected_rewards
    }

    public(friend) fun mut_pending(arg0: &mut NativePool) : &mut 0x2::coin::Coin<0x2::sui::SUI> {
        &mut arg0.pending
    }

    public(friend) fun mut_validator_set(arg0: &mut NativePool) : &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::validator_set::ValidatorSet {
        &mut arg0.validator_set
    }

    public entry fun publish_ratio(arg0: &NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        abort 999
    }

    public entry fun rebalance(arg0: &mut NativePool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun set_pause(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    fun set_rewards_unsafe(arg0: &mut NativePool, arg1: u64) {
        arg0.total_rewards = arg1;
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    public entry fun sort_validators(arg0: &mut NativePool) {
        abort 999
    }

    public entry fun stake(arg0: &mut NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun stake_non_entry(arg0: &mut NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        abort 999
    }

    fun stake_pool(arg0: &mut NativePool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun sub_rewards_unsafe(arg0: &mut NativePool, arg1: u64) {
        if (arg1 > arg0.total_rewards) {
            arg0.total_rewards = 0;
        } else {
            arg0.total_rewards = arg0.total_rewards - arg1;
        };
        let v0 = RewardsUpdated{value: arg0.total_rewards};
        0x2::event::emit<RewardsUpdated>(v0);
    }

    fun sub_total_staked_unsafe(arg0: &mut NativePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    public entry fun unstake(arg0: &mut NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun unstake_amount_from_validators(arg0: &mut NativePool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x1::vector::length<address>(&arg4) > 0, 103);
        let v0 = 0x1::vector::length<address>(&arg4) - 1;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0.pending);
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.pending, v1, arg5));
        let v4 = 0;
        while (v2 < arg2) {
            let (v5, v6, v7) = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::validator_set::remove_stakes(&mut arg0.validator_set, arg1, *0x1::vector::borrow<address>(&arg4, v0), arg2 - v2, arg5);
            sub_total_staked_unsafe(arg0, v6, arg5);
            let v8 = v4 + calculate_reward_fee(arg0, v7);
            v4 = v8;
            sub_rewards_unsafe(arg0, v7);
            0x2::balance::join<0x2::sui::SUI>(&mut v3, v5);
            v2 = 0x2::balance::value<0x2::sui::SUI>(&v3) - v8;
            if (v0 == 0) {
                break
            };
            v0 = v0 - 1;
        };
        if (v4 > arg0.collected_rewards) {
            v4 = arg0.collected_rewards;
            arg0.collected_rewards = 0;
        } else {
            arg0.collected_rewards = arg0.collected_rewards - v4;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&v3) >= arg3 + v4, 110);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.collectable_fee, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg3 + v4), arg5));
        if (v2 > arg2) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.pending, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2 - arg2), arg5));
            stake_pool(arg0, arg1, arg5);
        };
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5)
    }

    public entry fun update_rewards(arg0: &mut NativePool, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OperatorCap) {
        abort 999
    }

    public entry fun update_rewards_threshold(arg0: &mut NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OwnerCap, arg2: u64) {
        abort 999
    }

    public entry fun update_validators(arg0: &mut NativePool, arg1: vector<address>, arg2: vector<u64>, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::ownership::OperatorCap) {
        abort 999
    }

    fun when_not_paused(arg0: &NativePool) {
        assert!(!arg0.paused, 101);
    }

    // decompiled from Move bytecode v6
}

