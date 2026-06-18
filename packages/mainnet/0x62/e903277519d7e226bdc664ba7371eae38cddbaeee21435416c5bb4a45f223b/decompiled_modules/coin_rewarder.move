module 0x62e903277519d7e226bdc664ba7371eae38cddbaeee21435416c5bb4a45f223b::coin_rewarder {
    struct CoinRewarder<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        distributor_id: 0x2::object::ID,
        scope: u8,
        reward_vault: 0x2::balance::Balance<T0>,
        settlement_cap: 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewarderSettlementCap,
        emission_per_ms: u64,
        acc_reward_per_exposure: u256,
        last_updated_ms: u64,
        allocated_rewards: u64,
        total_distributed: u64,
        enabled: bool,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct OwnerSubjectKey has copy, drop, store {
        subject_id: 0x2::object::ID,
        owner: address,
    }

    struct PositionRewardRecord has store {
        owner: address,
        exposure: u64,
        reward_debt: u256,
        pending: u64,
    }

    struct CoinRewarderCreatedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
        scope: u8,
        emission_per_ms: u64,
    }

    struct CoinRewarderFundedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        amount: u64,
    }

    struct CoinRewarderUpdatedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        emission_per_ms: u64,
        enabled: bool,
    }

    struct CoinRewardSettledEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
        owner: address,
        previous_exposure: u64,
        new_exposure: u64,
        pending_added: u64,
        pending_total: u64,
    }

    struct CoinRewardClaimedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    public fun acc_reward_per_exposure<T0: drop>(arg0: &CoinRewarder<T0>) : u256 {
        arg0.acc_reward_per_exposure
    }

    fun add_pending_for_owner<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = OwnerSubjectKey{
            subject_id : arg1,
            owner      : arg2,
        };
        if (!0x2::dynamic_field::exists<OwnerSubjectKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<OwnerSubjectKey, u64>(&mut arg0.id, v0, arg3);
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<OwnerSubjectKey, u64>(&mut arg0.id, v0);
        let v2 = (*v1 as u256) + (arg3 as u256);
        assert!(v2 <= 18446744073709551615, 9402);
        *v1 = (v2 as u64);
    }

    fun allocate_rewards<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64) {
        let v0 = (arg0.allocated_rewards as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 9402);
        assert!(v0 <= (0x2::balance::value<T0>(&arg0.reward_vault) as u256), 9402);
        arg0.allocated_rewards = (v0 as u64);
    }

    public fun allocated_reward_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.allocated_rewards
    }

    public fun claim_lp_position<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle_lp_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        claim_pending<T0>(arg0, arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::id(arg4), arg7)
    }

    public fun claim_pending<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = PositionKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1) && pending_for_owner_only<T0>(arg0, arg2, v0) == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v2 = 0x2::balance::value<T0>(&arg0.reward_vault);
        let v3 = v2;
        let v4 = arg0.allocated_rewards;
        let v5 = v4;
        let v6 = 0;
        let v7 = v6;
        let v8 = false;
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            let v9 = 0x2::dynamic_field::borrow_mut<PositionKey, PositionRewardRecord>(&mut arg0.id, v1);
            if (v9.owner == v0) {
                v8 = true;
                let v10 = 0x1::u64::min(0x1::u64::min(v9.pending, v2), v4);
                v9.pending = v9.pending - v10;
                v3 = v2 - v10;
                v5 = v4 - v10;
                v7 = v6 + v10;
            };
        };
        if (v3 > 0 && v5 > 0) {
            let v11 = take_pending_for_owner<T0>(arg0, arg2, v0, 0x1::u64::min(v3, v5));
            v7 = v7 + v11;
        };
        assert!(v8 || v7 > 0, 9401);
        release_allocated_rewards<T0>(arg0, v7);
        arg0.total_distributed = arg0.total_distributed + v7;
        let v12 = CoinRewardClaimedEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            subject_id  : arg2,
            owner       : v0,
            amount      : v7,
        };
        0x2::event::emit<CoinRewardClaimedEvent>(v12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_vault, v7), arg3)
    }

    public fun claim_yt_position<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle_yt_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        claim_pending<T0>(arg0, arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::id(arg4), arg7)
    }

    fun create_and_register<T0: drop>(arg0: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = CoinRewarder<T0>{
            id                      : v0,
            distributor_id          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg0),
            scope                   : arg3,
            reward_vault            : 0x2::balance::zero<T0>(),
            settlement_cap          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg2, arg3, v1, b"coin", b"coin"),
            emission_per_ms         : arg4,
            acc_reward_per_exposure : 0,
            last_updated_ms         : arg5,
            allocated_rewards       : 0,
            total_distributed       : 0,
            enabled                 : true,
        };
        let v3 = CoinRewarderCreatedEvent{
            rewarder_id     : v1,
            distributor_id  : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg0),
            scope           : arg3,
            emission_per_ms : arg4,
        };
        0x2::event::emit<CoinRewarderCreatedEvent>(v3);
        0x2::transfer::share_object<CoinRewarder<T0>>(v2);
    }

    public fun create_and_register_by_admin<T0: drop>(arg0: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        create_and_register<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
    }

    public fun distributor_id<T0: drop>(arg0: &CoinRewarder<T0>) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun emission_per_ms<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.emission_per_ms
    }

    fun emit_updated<T0: drop>(arg0: &CoinRewarder<T0>) {
        let v0 = CoinRewarderUpdatedEvent{
            rewarder_id     : 0x2::object::id<CoinRewarder<T0>>(arg0),
            emission_per_ms : arg0.emission_per_ms,
            enabled         : arg0.enabled,
        };
        0x2::event::emit<CoinRewarderUpdatedEvent>(v0);
    }

    public fun enabled<T0: drop>(arg0: &CoinRewarder<T0>) : bool {
        arg0.enabled
    }

    public fun fund<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        0x2::balance::join<T0>(&mut arg0.reward_vault, 0x2::coin::into_balance<T0>(arg2));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (unallocated_reward_amount_internal<T0>(arg0) == 0 && v0 > arg0.last_updated_ms) {
            arg0.last_updated_ms = v0;
        };
        let v1 = CoinRewarderFundedEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            amount      : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<CoinRewarderFundedEvent>(v1);
    }

    public fun last_updated_ms<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.last_updated_ms
    }

    public fun pending<T0: drop>(arg0: &CoinRewarder<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, PositionRewardRecord>(&arg0.id, v0).pending
    }

    fun pending_for(arg0: &PositionRewardRecord, arg1: u256) : u64 {
        let v0 = reward_debt(arg0.exposure, arg1);
        if (v0 <= arg0.reward_debt) {
            return 0
        };
        let v1 = (v0 - arg0.reward_debt) / 1000000000000;
        assert!(v1 <= 18446744073709551615, 9402);
        (v1 as u64)
    }

    public fun pending_for_owner<T0: drop>(arg0: &CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address) : u64 {
        let v0 = PositionKey{pos0: arg1};
        let v1 = pending_for_owner_only<T0>(arg0, arg1, arg2);
        let v2 = v1;
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<PositionKey, PositionRewardRecord>(&arg0.id, v0);
            if (v3.owner == arg2) {
                let v4 = (v1 as u256) + (v3.pending as u256);
                assert!(v4 <= 18446744073709551615, 9402);
                v2 = (v4 as u64);
            };
        };
        v2
    }

    fun pending_for_owner_only<T0: drop>(arg0: &CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address) : u64 {
        let v0 = OwnerSubjectKey{
            subject_id : arg1,
            owner      : arg2,
        };
        if (!0x2::dynamic_field::exists<OwnerSubjectKey>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<OwnerSubjectKey, u64>(&arg0.id, v0)
    }

    public fun recover_pool_pending_by_admin<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        assert!(arg0.scope == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::pool_scope(), 9400);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T1>(arg3);
        let v1 = PositionKey{pos0: v0};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            return 0x2::coin::zero<T0>(arg4)
        };
        let v2 = 0x2::dynamic_field::borrow_mut<PositionKey, PositionRewardRecord>(&mut arg0.id, v1);
        assert!(v2.owner == @0x0, 9401);
        let v3 = 0x1::u64::min(0x1::u64::min(v2.pending, 0x2::balance::value<T0>(&arg0.reward_vault)), arg0.allocated_rewards);
        v2.pending = v2.pending - v3;
        release_allocated_rewards<T0>(arg0, v3);
        arg0.total_distributed = arg0.total_distributed + v3;
        let v4 = CoinRewardClaimedEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            subject_id  : v0,
            owner       : @0x0,
            amount      : v3,
        };
        0x2::event::emit<CoinRewardClaimedEvent>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_vault, v3), arg4)
    }

    fun release_allocated_rewards<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64) {
        assert!(arg0.allocated_rewards >= arg1, 9402);
        arg0.allocated_rewards = arg0.allocated_rewards - arg1;
    }

    fun reward_debt(arg0: u64, arg1: u256) : u256 {
        (arg0 as u256) * arg1
    }

    public fun reward_vault_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_vault)
    }

    public fun rewarder_id<T0: drop>(arg0: &CoinRewarder<T0>) : 0x2::object::ID {
        0x2::object::id<CoinRewarder<T0>>(arg0)
    }

    public fun scope<T0: drop>(arg0: &CoinRewarder<T0>) : u8 {
        arg0.scope
    }

    public fun set_emission_by_acl<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"reward.configure"));
        update_global<T0>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.emission_per_ms = arg4;
        emit_updated<T0>(arg0);
    }

    public fun set_emission_by_admin<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        update_global<T0>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.emission_per_ms = arg4;
        emit_updated<T0>(arg0);
    }

    public fun set_enabled_by_acl<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"reward.configure"));
        update_global<T0>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.enabled = arg4;
        emit_updated<T0>(arg0);
    }

    public fun set_enabled_by_admin<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        update_global<T0>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.enabled = arg4;
        emit_updated<T0>(arg0);
    }

    fun settle_derived<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) {
        assert!(arg0.distributor_id == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg2), 9400);
        assert!(arg0.scope == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::operation_scope(arg3), 9400);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_subject(arg3, arg5);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_owner(arg3, arg6);
        assert!(arg7 <= arg8, 9404);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::settle_rewarder_with_cap(arg2, arg1, arg3, &arg0.settlement_cap);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::assert_operation_profile_matches(arg3, arg4);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::previous_exposure(arg3) == arg9, 9405);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::operation_guard(arg3) == arg10, 9405);
        update_global<T0>(arg0, arg8, 0x2::clock::timestamp_ms(arg11));
        settle_record<T0>(arg0, arg5, arg6, arg7);
    }

    public fun settle_lp_position<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.scope == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::lp_scope(), 9400);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::pool_id(arg4) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T1>(arg5), 9403);
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T1>(arg5), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::id(arg4), 0x2::tx_context::sender(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_amount(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T1>(arg5), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_amount(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_reward_guard(arg4), arg6);
    }

    public fun settle_pool<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T1>, arg5: &0x2::clock::Clock) {
        assert!(arg0.scope == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::pool_scope(), 9400);
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T1>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T1>(arg4), @0x0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T1>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T1>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T1>(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_guard<T1>(arg4), arg5);
    }

    fun settle_record<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v1 = PositionRewardRecord{
                owner       : arg2,
                exposure    : arg3,
                reward_debt : reward_debt(arg3, arg0.acc_reward_per_exposure),
                pending     : 0,
            };
            0x2::dynamic_field::add<PositionKey, PositionRewardRecord>(&mut arg0.id, v0, v1);
            let v2 = CoinRewardSettledEvent{
                rewarder_id       : 0x2::object::id<CoinRewarder<T0>>(arg0),
                subject_id        : arg1,
                owner             : arg2,
                previous_exposure : 0,
                new_exposure      : arg3,
                pending_added     : 0,
                pending_total     : 0,
            };
            0x2::event::emit<CoinRewardSettledEvent>(v2);
            return
        };
        let v3 = @0x0;
        let v4 = 0;
        let v5 = 0x2::dynamic_field::borrow_mut<PositionKey, PositionRewardRecord>(&mut arg0.id, v0);
        let v6 = v5.exposure;
        let v7 = pending_for(v5, arg0.acc_reward_per_exposure);
        let v8 = (v5.pending as u256) + (v7 as u256);
        assert!(v8 <= 18446744073709551615, 9402);
        let v9 = (v8 as u64);
        let v10 = v9;
        if (v5.owner != arg2) {
            v3 = v5.owner;
            v4 = v9;
            v10 = 0;
        };
        v5.owner = arg2;
        v5.exposure = arg3;
        v5.pending = v10;
        v5.reward_debt = reward_debt(arg3, arg0.acc_reward_per_exposure);
        if (v4 > 0) {
            add_pending_for_owner<T0>(arg0, arg1, v3, v4);
        };
        let v11 = CoinRewardSettledEvent{
            rewarder_id       : 0x2::object::id<CoinRewarder<T0>>(arg0),
            subject_id        : arg1,
            owner             : arg2,
            previous_exposure : v6,
            new_exposure      : arg3,
            pending_added     : v7,
            pending_total     : v10,
        };
        0x2::event::emit<CoinRewardSettledEvent>(v11);
    }

    public fun settle_yt_position<T0: drop, T1: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor, arg3: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardOperation, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.scope == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::yt_scope(), 9400);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::py_state_id(arg4) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T1>(arg5), 9403);
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T1>(arg5), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::id(arg4), 0x2::tx_context::sender(arg7), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_supply<T1>(arg5), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg4), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg4), arg6);
    }

    fun take_pending_for_owner<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u64 {
        let v0 = OwnerSubjectKey{
            subject_id : arg1,
            owner      : arg2,
        };
        if (arg3 == 0 || !0x2::dynamic_field::exists<OwnerSubjectKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<OwnerSubjectKey, u64>(&mut arg0.id, v0);
        let v2 = 0x1::u64::min(*v1, arg3);
        *v1 = *v1 - v2;
        if (*v1 == 0) {
            0x2::dynamic_field::remove<OwnerSubjectKey, u64>(&mut arg0.id, v0);
        };
        v2
    }

    public fun total_distributed<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.total_distributed
    }

    public fun unallocated_reward_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        unallocated_reward_amount_internal<T0>(arg0)
    }

    fun unallocated_reward_amount_internal<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reward_vault);
        assert!(v0 >= arg0.allocated_rewards, 9402);
        v0 - arg0.allocated_rewards
    }

    fun update_global<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: u64) {
        if (arg2 <= arg0.last_updated_ms) {
            return
        };
        let v0 = if (!arg0.enabled) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0.emission_per_ms == 0
        };
        if (v0) {
            arg0.last_updated_ms = arg2;
            return
        };
        let v1 = unallocated_reward_amount_internal<T0>(arg0);
        arg0.last_updated_ms = arg2;
        if (v1 == 0) {
            return
        };
        let v2 = ((arg2 - arg0.last_updated_ms) as u256) * (arg0.emission_per_ms as u256);
        let v3 = if (v2 > (v1 as u256)) {
            v1
        } else {
            (v2 as u64)
        };
        if (v3 == 0) {
            return
        };
        allocate_rewards<T0>(arg0, v3);
        arg0.acc_reward_per_exposure = arg0.acc_reward_per_exposure + (v3 as u256) * 1000000000000 / (arg1 as u256);
    }

    // decompiled from Move bytecode v7
}

