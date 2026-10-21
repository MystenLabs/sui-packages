module 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::coin_rewarder {
    struct FundingLot has store {
        lot_id: u64,
        start_ms: u64,
        end_ms: u64,
        budget: u64,
        accounted_amount: u64,
    }

    struct CoinRewarder<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        reward_vault: 0x2::balance::Balance<T0>,
        settlement_cap: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap,
        funding_lots: vector<FundingLot>,
        next_lot_id: u64,
        acc_reward_per_exposure: u256,
        acc_reward_remainder: u256,
        last_updated_ms: u64,
        allocated_rewards: u64,
        undistributed_rewards: u64,
        total_distributed: u256,
        enabled: bool,
        closed: bool,
        closed_at_ms: u64,
        withdrawn: bool,
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
        reward_remainder: u256,
        pending: u64,
    }

    struct DetachedRewardRecord has store {
        pending: u64,
        reward_remainder: u256,
    }

    struct CoinRewarderCreatedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
    }

    struct CoinRewarderFundedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        lot_id: u64,
        budget: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct CoinRewarderUpdatedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        enabled: bool,
        closed: bool,
        closed_at_ms: u64,
    }

    struct CoinRewarderClosedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        closed_at_ms: u64,
        allocated_rewards: u64,
        moved_to_undistributed: u64,
        undistributed_rewards: u64,
    }

    struct CoinRewarderWithdrawnEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        caller: address,
        withdrawn_at_ms: u64,
        amount: u64,
        allocated_cancelled: u64,
        scheduled_cancelled: u64,
        undistributed: u64,
    }

    struct CoinRewardFundingLotAdjustedEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        lot_id: u64,
        previous_remaining_budget: u64,
        new_remaining_budget: u64,
        moved_to_undistributed: u64,
        new_start_ms: u64,
        new_end_ms: u64,
    }

    struct CoinRewardUndistributedSweptEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        caller: address,
        amount: u64,
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

    struct CoinRewardOwnerTransferredEvent has copy, drop {
        rewarder_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        detached_pending: u64,
        detached_remainder: u256,
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

    fun account_scheduled_rewards<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FundingLot>(&arg0.funding_lots)) {
            let v2 = 0x1::vector::borrow_mut<FundingLot>(&mut arg0.funding_lots, v1);
            let v3 = vested_amount(v2, arg1);
            assert!(v3 >= v2.accounted_amount, 9409);
            v2.accounted_amount = v3;
            v0 = checked_add(v0, v3 - v2.accounted_amount);
            if (v3 == v2.budget) {
                let FundingLot {
                    lot_id           : _,
                    start_ms         : _,
                    end_ms           : _,
                    budget           : _,
                    accounted_amount : _,
                } = 0x1::vector::swap_remove<FundingLot>(&mut arg0.funding_lots, v1);
                continue
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun add_detached_reward<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u256) {
        if (arg3 == 0 && arg4 == 0) {
            return
        };
        let v0 = OwnerSubjectKey{
            subject_id : arg1,
            owner      : arg2,
        };
        if (!0x2::dynamic_field::exists<OwnerSubjectKey>(&arg0.id, v0)) {
            let v1 = DetachedRewardRecord{
                pending          : arg3,
                reward_remainder : arg4,
            };
            0x2::dynamic_field::add<OwnerSubjectKey, DetachedRewardRecord>(&mut arg0.id, v0, v1);
            return
        };
        let v2 = 0x2::dynamic_field::borrow_mut<OwnerSubjectKey, DetachedRewardRecord>(&mut arg0.id, v0);
        let v3 = v2.reward_remainder + arg4;
        let v4 = (v2.pending as u256) + (arg3 as u256) + v3 / 340282366920938463463374607431768211456;
        assert!(v4 <= 18446744073709551615, 9402);
        v2.pending = (v4 as u64);
        v2.reward_remainder = v3 % 340282366920938463463374607431768211456;
    }

    fun add_funding_lot<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64) {
        assert!(!arg0.closed, 9416);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9406);
        assert!(arg3 > 0, 9407);
        assert!(arg4 >= arg0.last_updated_ms, 9411);
        assert!(0x1::vector::length<FundingLot>(&arg0.funding_lots) < 16, 9408);
        let v1 = (arg4 as u256) + (arg2 as u256);
        assert!(v1 <= 18446744073709551615, 9407);
        let v2 = v1 + (arg3 as u256);
        assert!(v2 <= 18446744073709551615, 9407);
        let v3 = arg0.next_lot_id;
        arg0.next_lot_id = checked_add(v3, 1);
        let v4 = (v1 as u64);
        let v5 = (v2 as u64);
        0x2::balance::join<T0>(&mut arg0.reward_vault, 0x2::coin::into_balance<T0>(arg1));
        let v6 = FundingLot{
            lot_id           : v3,
            start_ms         : v4,
            end_ms           : v5,
            budget           : v0,
            accounted_amount : 0,
        };
        0x1::vector::push_back<FundingLot>(&mut arg0.funding_lots, v6);
        assert_vault_accounting<T0>(arg0);
        let v7 = CoinRewarderFundedEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            lot_id      : v3,
            budget      : v0,
            start_ms    : v4,
            end_ms      : v5,
        };
        0x2::event::emit<CoinRewarderFundedEvent>(v7);
    }

    fun adjust_funding_lot<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(!arg0.closed, 9416);
        let v0 = find_funding_lot_index<T0>(arg0, arg1);
        let v1 = 0x1::vector::borrow<FundingLot>(&arg0.funding_lots, v0);
        assert!(v1.budget >= v1.accounted_amount, 9409);
        let v2 = v1.budget - v1.accounted_amount;
        assert!(arg2 <= v2, 9413);
        let (v3, v4) = if (arg2 == 0) {
            (arg5, arg5)
        } else {
            assert!(arg4 > 0, 9407);
            let v5 = (arg5 as u256) + (arg3 as u256);
            assert!(v5 <= 18446744073709551615, 9407);
            let v6 = v5 + (arg4 as u256);
            assert!(v6 <= 18446744073709551615, 9407);
            ((v5 as u64), (v6 as u64))
        };
        let v7 = v2 - arg2;
        if (v7 > 0) {
            arg0.undistributed_rewards = checked_add(arg0.undistributed_rewards, v7);
        };
        if (arg2 == 0) {
            let FundingLot {
                lot_id           : _,
                start_ms         : _,
                end_ms           : _,
                budget           : _,
                accounted_amount : _,
            } = 0x1::vector::swap_remove<FundingLot>(&mut arg0.funding_lots, v0);
        } else {
            let v13 = 0x1::vector::borrow_mut<FundingLot>(&mut arg0.funding_lots, v0);
            v13.start_ms = v3;
            v13.end_ms = v4;
            v13.budget = arg2;
            v13.accounted_amount = 0;
        };
        assert_vault_accounting<T0>(arg0);
        let v14 = CoinRewardFundingLotAdjustedEvent{
            rewarder_id               : 0x2::object::id<CoinRewarder<T0>>(arg0),
            lot_id                    : arg1,
            previous_remaining_budget : v2,
            new_remaining_budget      : arg2,
            moved_to_undistributed    : v7,
            new_start_ms              : v3,
            new_end_ms                : v4,
        };
        0x2::event::emit<CoinRewardFundingLotAdjustedEvent>(v14);
    }

    public fun adjust_lot_by_acl<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg2, arg1, 0x2::tx_context::sender(arg9), 0x1::string::utf8(b"reward.configure"));
        assert!(!arg0.closed, 9416);
        assert_market_binding<T0, T1, T2, T3>(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        checkpoint_market<T0, T1, T2, T3>(arg0, arg3, v0);
        adjust_funding_lot<T0>(arg0, arg4, arg5, arg6, arg7, v0);
    }

    public fun adjust_lot_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert!(!arg0.closed, 9416);
        assert_market_binding<T0, T1, T2, T3>(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        checkpoint_market<T0, T1, T2, T3>(arg0, arg3, v0);
        adjust_funding_lot<T0>(arg0, arg4, arg5, arg6, arg7, v0);
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

    fun assert_market_binding<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &CoinRewarder<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>) {
        assert!(arg0.market_state_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg1), 9414);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T1, T2, T3>(arg1), 9414);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T1, T2, T3>(arg1) == arg0.distributor_id, 9414);
    }

    fun assert_payout_active<T0: drop>(arg0: &CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", arg0.market_state_id, 9418);
    }

    fun assert_supported_scope(arg0: u8) {
        let v0 = if (arg0 == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope()) {
            true
        } else if (arg0 == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope()) {
            true
        } else {
            arg0 == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope()
        };
        assert!(v0, 9415);
    }

    fun assert_vault_accounting<T0: drop>(arg0: &CoinRewarder<T0>) {
        assert!((arg0.allocated_rewards as u256) + (arg0.undistributed_rewards as u256) + (scheduled_reward_amount_internal<T0>(arg0) as u256) == (0x2::balance::value<T0>(&arg0.reward_vault) as u256), 9409);
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 9402);
        (v0 as u64)
    }

    fun checkpoint_market<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg2: u64) {
        let v0 = total_exposure_for_scope<T0, T1, T2, T3>(arg0, arg1);
        let v1 = if (arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope()) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T1, T2, T3>(arg1)
        } else {
            0
        };
        update_global_with_cutoff<T0>(arg0, v0, arg2, v1);
    }

    public fun claim_lp_position<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle_lp_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        claim_pending<T0>(arg0, arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), arg7)
    }

    public fun claim_pending<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_payout_active<T0>(arg0, arg1);
        assert!(!arg0.withdrawn, 9417);
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
        arg0.total_distributed = arg0.total_distributed + (v7 as u256);
        assert_vault_accounting<T0>(arg0);
        let v12 = CoinRewardClaimedEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            subject_id  : arg2,
            owner       : v0,
            amount      : v7,
        };
        0x2::event::emit<CoinRewardClaimedEvent>(v12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_vault, v7), arg3)
    }

    public fun claim_yt_position<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle_yt_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        claim_pending<T0>(arg0, arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), arg7)
    }

    fun close_at<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0.closed) {
            return
        };
        update_global_with_cutoff<T0>(arg0, arg1, arg2, arg3);
        let v0 = release_scheduled_rewards<T0>(arg0);
        arg0.enabled = false;
        arg0.closed = true;
        arg0.closed_at_ms = arg2;
        assert_vault_accounting<T0>(arg0);
        let v1 = CoinRewarderClosedEvent{
            rewarder_id            : 0x2::object::id<CoinRewarder<T0>>(arg0),
            closed_at_ms           : arg2,
            allocated_rewards      : arg0.allocated_rewards,
            moved_to_undistributed : v0,
            undistributed_rewards  : arg0.undistributed_rewards,
        };
        0x2::event::emit<CoinRewarderClosedEvent>(v1);
        emit_updated<T0>(arg0);
    }

    public fun close_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg5: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert_market_binding<T0, T1, T2, T3>(arg0, arg4);
        assert!(arg0.distributor_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg3), 9400);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_registered(arg3, arg0.scope, 0x2::object::id<CoinRewarder<T0>>(arg0)), 9400);
        close_rewarder<T0, T1, T2, T3>(arg0, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    fun close_rewarder<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg2: u64) {
        let v0 = total_exposure_for_scope<T0, T1, T2, T3>(arg0, arg1);
        let v1 = if (arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope()) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T1, T2, T3>(arg1)
        } else {
            0
        };
        close_at<T0>(arg0, v0, arg2, v1);
    }

    public fun closed<T0: drop>(arg0: &CoinRewarder<T0>) : bool {
        arg0.closed
    }

    public fun closed_at_ms<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.closed_at_ms
    }

    fun create_and_register<T0: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        assert_supported_scope(arg4);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg0) == arg3, 9414);
        let v2 = CoinRewarder<T0>{
            id                      : v0,
            distributor_id          : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg0),
            market_state_id         : arg3,
            scope                   : arg4,
            reward_vault            : 0x2::balance::zero<T0>(),
            settlement_cap          : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg2, arg4, v1, b"coin", b"coin"),
            funding_lots            : 0x1::vector::empty<FundingLot>(),
            next_lot_id             : 0,
            acc_reward_per_exposure : 0,
            acc_reward_remainder    : 0,
            last_updated_ms         : arg5,
            allocated_rewards       : 0,
            undistributed_rewards   : 0,
            total_distributed       : 0,
            enabled                 : true,
            closed                  : false,
            closed_at_ms            : 0,
            withdrawn               : false,
        };
        let v3 = CoinRewarderCreatedEvent{
            rewarder_id     : v1,
            distributor_id  : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg0),
            market_state_id : arg3,
            scope           : arg4,
        };
        0x2::event::emit<CoinRewarderCreatedEvent>(v3);
        0x2::transfer::share_object<CoinRewarder<T0>>(v2);
    }

    public fun create_and_register_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert_supported_scope(arg4);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T1, T2, T3>(arg3), 9414);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T1, T2, T3>(arg3) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg0), 9414);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg0) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg3), 9414);
        create_and_register<T0>(arg0, arg1, arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg3), arg4, 0x2::clock::timestamp_ms(arg5), arg6);
    }

    public fun distributor_id<T0: drop>(arg0: &CoinRewarder<T0>) : 0x2::object::ID {
        arg0.distributor_id
    }

    fun emit_updated<T0: drop>(arg0: &CoinRewarder<T0>) {
        let v0 = CoinRewarderUpdatedEvent{
            rewarder_id  : 0x2::object::id<CoinRewarder<T0>>(arg0),
            enabled      : arg0.enabled,
            closed       : arg0.closed,
            closed_at_ms : arg0.closed_at_ms,
        };
        0x2::event::emit<CoinRewarderUpdatedEvent>(v0);
    }

    public fun enabled<T0: drop>(arg0: &CoinRewarder<T0>) : bool {
        arg0.enabled
    }

    fun find_funding_lot_index<T0: drop>(arg0: &CoinRewarder<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FundingLot>(&arg0.funding_lots)) {
            if (0x1::vector::borrow<FundingLot>(&arg0.funding_lots, v0).lot_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 9412
    }

    public fun fund<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        add_funding_lot<T0>(arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun fund_by_acl<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg2, arg1, 0x2::tx_context::sender(arg7), 0x1::string::utf8(b"reward.configure"));
        add_funding_lot<T0>(arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun funding_lot<T0: drop>(arg0: &CoinRewarder<T0>, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = 0x1::vector::borrow<FundingLot>(&arg0.funding_lots, arg1);
        (v0.lot_id, v0.start_ms, v0.end_ms, v0.budget, v0.accounted_amount)
    }

    public fun funding_lot_count<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        0x1::vector::length<FundingLot>(&arg0.funding_lots)
    }

    fun initialize_record_if_missing<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = PositionKey{pos0: arg1};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return
        };
        let v1 = PositionRewardRecord{
            owner            : arg2,
            exposure         : arg3,
            reward_debt      : 0,
            reward_remainder : 0,
            pending          : 0,
        };
        0x2::dynamic_field::add<PositionKey, PositionRewardRecord>(&mut arg0.id, v0, v1);
    }

    public fun last_updated_ms<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.last_updated_ms
    }

    public fun market_state_id<T0: drop>(arg0: &CoinRewarder<T0>) : 0x2::object::ID {
        arg0.market_state_id
    }

    public fun max_funding_lots() : u64 {
        16
    }

    public fun pending<T0: drop>(arg0: &CoinRewarder<T0>, arg1: 0x2::object::ID) : u64 {
        if (arg0.withdrawn) {
            return 0
        };
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, PositionRewardRecord>(&arg0.id, v0).pending
    }

    fun pending_for(arg0: &PositionRewardRecord, arg1: u256) : (u64, u256) {
        let v0 = reward_debt(arg0.exposure, arg1);
        let v1 = if (v0 > arg0.reward_debt) {
            v0 - arg0.reward_debt
        } else {
            0
        };
        let v2 = v1 + arg0.reward_remainder;
        let v3 = v2 / 340282366920938463463374607431768211456;
        assert!(v3 <= 18446744073709551615, 9402);
        ((v3 as u64), v2 % 340282366920938463463374607431768211456)
    }

    public fun pending_for_owner<T0: drop>(arg0: &CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address) : u64 {
        if (arg0.withdrawn) {
            return 0
        };
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
        0x2::dynamic_field::borrow<OwnerSubjectKey, DetachedRewardRecord>(&arg0.id, v0).pending
    }

    public fun recover_pool_pending_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_payout_active<T0>(arg0, arg1);
        assert!(!arg0.withdrawn, 9417);
        assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), 9400);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg3);
        let v1 = PositionKey{pos0: v0};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            return 0x2::coin::zero<T0>(arg4)
        };
        let v2 = 0x2::dynamic_field::borrow_mut<PositionKey, PositionRewardRecord>(&mut arg0.id, v1);
        assert!(v2.owner == @0x0, 9401);
        let v3 = 0x1::u64::min(0x1::u64::min(v2.pending, 0x2::balance::value<T0>(&arg0.reward_vault)), arg0.allocated_rewards);
        v2.pending = v2.pending - v3;
        release_allocated_rewards<T0>(arg0, v3);
        arg0.total_distributed = arg0.total_distributed + (v3 as u256);
        assert_vault_accounting<T0>(arg0);
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

    fun release_scheduled_rewards<T0: drop>(arg0: &mut CoinRewarder<T0>) : u64 {
        let v0 = 0;
        while (!0x1::vector::is_empty<FundingLot>(&arg0.funding_lots)) {
            let FundingLot {
                lot_id           : _,
                start_ms         : _,
                end_ms           : _,
                budget           : v4,
                accounted_amount : v5,
            } = 0x1::vector::pop_back<FundingLot>(&mut arg0.funding_lots);
            assert!(v4 >= v5, 9409);
            v0 = checked_add(v0, v4 - v5);
        };
        arg0.undistributed_rewards = checked_add(arg0.undistributed_rewards, v0);
        v0
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

    public fun scheduled_reward_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        scheduled_reward_amount_internal<T0>(arg0)
    }

    fun scheduled_reward_amount_internal<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FundingLot>(&arg0.funding_lots)) {
            let v2 = 0x1::vector::borrow<FundingLot>(&arg0.funding_lots, v1);
            assert!(v2.budget >= v2.accounted_amount, 9409);
            v0 = checked_add(v0, v2.budget - v2.accounted_amount);
            v1 = v1 + 1;
        };
        v0
    }

    public fun scope<T0: drop>(arg0: &CoinRewarder<T0>) : u8 {
        arg0.scope
    }

    public fun set_enabled_by_acl<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg2, arg1, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"reward.configure"));
        assert!(!arg0.closed, 9416);
        assert_market_binding<T0, T1, T2, T3>(arg0, arg3);
        checkpoint_market<T0, T1, T2, T3>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.enabled = arg4;
        emit_updated<T0>(arg0);
    }

    public fun set_enabled_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg4: bool, arg5: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert!(!arg0.closed, 9416);
        assert_market_binding<T0, T1, T2, T3>(arg0, arg3);
        checkpoint_market<T0, T1, T2, T3>(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        arg0.enabled = arg4;
        emit_updated<T0>(arg0);
    }

    fun settle_derived<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert!(arg0.distributor_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 9400);
        assert!(arg0.market_state_id == arg4, 9414);
        assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_scope(arg3), 9400);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg3, arg5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg3, arg6);
        assert!(arg7 <= arg9, 9404);
        assert!(arg8 <= arg7, 9404);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg3, arg4);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg3) == arg10, 9405);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg3) == arg11, 9405);
        if (arg0.withdrawn) {
            return
        };
        let v0 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_is_transfer(arg3)) {
            assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope() || arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), 9415);
            let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_next_owner(arg3);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_transfer_rewarder_with_cap(arg2, arg1, arg3, &arg0.settlement_cap, v1);
            v1
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg2, arg1, arg3, &arg0.settlement_cap);
            arg6
        };
        if (arg12) {
            initialize_record_if_missing<T0>(arg0, arg5, arg6, arg7);
            let v2 = PositionKey{pos0: arg5};
            let v3 = 0x2::dynamic_field::borrow<PositionKey, PositionRewardRecord>(&arg0.id, v2);
            assert!(v3.owner == arg6 || v3.exposure == 0, 9405);
        };
        update_global_with_cutoff<T0>(arg0, arg9, 0x2::clock::timestamp_ms(arg14), arg13);
        if (arg12) {
            settle_record<T0>(arg0, arg5, v0, arg8);
        };
    }

    public fun settle_lp_position<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), 9400);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg4) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg5), 9403);
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), 0x2::tx_context::sender(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T1, T2, T3>(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg4), true, 0, arg6);
    }

    public fun settle_pool<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg5: &0x2::clock::Clock) {
        assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), 9400);
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg4), @0x0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T1, T2, T3>(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T1, T2, T3>(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T1, T2, T3>(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T1, T2, T3>(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::pool_reward_guard<T1, T2, T3>(arg4), true, 0, arg5);
    }

    fun settle_record<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = PositionKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0), 9403);
        let v1 = @0x0;
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        let v5 = 0x2::dynamic_field::borrow_mut<PositionKey, PositionRewardRecord>(&mut arg0.id, v0);
        let v6 = v5.exposure;
        let (v7, v8) = pending_for(v5, arg0.acc_reward_per_exposure);
        let v9 = (v5.pending as u256) + (v7 as u256);
        assert!(v9 <= 18446744073709551615, 9402);
        let v10 = (v9 as u64);
        let v11 = v10;
        if (v5.owner != arg2) {
            v4 = true;
            v1 = v5.owner;
            v2 = v10;
            v3 = v8;
            v11 = 0;
        };
        v5.owner = arg2;
        v5.exposure = arg3;
        v5.pending = v11;
        v5.reward_debt = reward_debt(arg3, arg0.acc_reward_per_exposure);
        let v12 = if (v4) {
            0
        } else {
            v8
        };
        v5.reward_remainder = v12;
        if (v2 > 0 || v3 > 0) {
            add_detached_reward<T0>(arg0, arg1, v1, v2, v3);
        };
        if (v4) {
            let v13 = CoinRewardOwnerTransferredEvent{
                rewarder_id        : 0x2::object::id<CoinRewarder<T0>>(arg0),
                subject_id         : arg1,
                previous_owner     : v1,
                new_owner          : arg2,
                detached_pending   : v2,
                detached_remainder : v3,
            };
            0x2::event::emit<CoinRewardOwnerTransferredEvent>(v13);
        };
        let v14 = CoinRewardSettledEvent{
            rewarder_id       : 0x2::object::id<CoinRewarder<T0>>(arg0),
            subject_id        : arg1,
            owner             : arg2,
            previous_exposure : v6,
            new_exposure      : arg3,
            pending_added     : v7,
            pending_total     : v11,
        };
        0x2::event::emit<CoinRewardSettledEvent>(v14);
    }

    public fun settle_yt_position<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(), 9400);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg5));
        let v0 = if (0x2::clock::timestamp_ms(arg6) >= 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T1, T2, T3>(arg5)) {
            0
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4)
        };
        settle_derived<T0>(arg0, arg1, arg2, arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T1, T2, T3>(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), 0x2::tx_context::sender(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4), v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::yt_supply<T1, T2, T3>(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg4), true, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T1, T2, T3>(arg5), arg6);
    }

    fun sweep_undistributed<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 9406);
        assert!(arg1 <= arg0.undistributed_rewards, 9410);
        arg0.undistributed_rewards = arg0.undistributed_rewards - arg1;
        assert_vault_accounting<T0>(arg0);
        let v0 = CoinRewardUndistributedSweptEvent{
            rewarder_id : 0x2::object::id<CoinRewarder<T0>>(arg0),
            caller      : 0x2::tx_context::sender(arg2),
            amount      : arg1,
        };
        0x2::event::emit<CoinRewardUndistributedSweptEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_vault, arg1), arg2)
    }

    public fun sweep_undistributed_by_acl<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_payout_active<T0>(arg0, arg1);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg2, arg1, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"reward.withdraw"));
        sweep_undistributed<T0>(arg0, arg3, arg4)
    }

    public fun sweep_undistributed_by_admin<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_payout_active<T0>(arg0, arg1);
        sweep_undistributed<T0>(arg0, arg3, arg4)
    }

    fun take_pending_for_owner<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u64 {
        let v0 = OwnerSubjectKey{
            subject_id : arg1,
            owner      : arg2,
        };
        if (arg3 == 0 || !0x2::dynamic_field::exists<OwnerSubjectKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<OwnerSubjectKey, DetachedRewardRecord>(&mut arg0.id, v0);
        let v2 = 0x1::u64::min(v1.pending, arg3);
        v1.pending = v1.pending - v2;
        if (v1.pending == 0 && v1.reward_remainder == 0) {
            let DetachedRewardRecord {
                pending          : _,
                reward_remainder : _,
            } = 0x2::dynamic_field::remove<OwnerSubjectKey, DetachedRewardRecord>(&mut arg0.id, v0);
        };
        v2
    }

    public fun total_distributed<T0: drop>(arg0: &CoinRewarder<T0>) : u256 {
        arg0.total_distributed
    }

    fun total_exposure_for_scope<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &CoinRewarder<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T1, T2, T3>) : u64 {
        if (arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope()) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::yt_supply<T1, T2, T3>(arg1)
        } else if (arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope()) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T1, T2, T3>(arg1)
        } else {
            assert!(arg0.scope == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), 9415);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T1, T2, T3>(arg1)
        }
    }

    public fun unallocated_reward_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        unallocated_reward_amount_internal<T0>(arg0)
    }

    fun unallocated_reward_amount_internal<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reward_vault);
        assert!(v0 >= arg0.allocated_rewards, 9402);
        v0 - arg0.allocated_rewards
    }

    public fun undistributed_reward_amount<T0: drop>(arg0: &CoinRewarder<T0>) : u64 {
        arg0.undistributed_rewards
    }

    fun update_global<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 >= arg0.last_updated_ms, 9411);
        if (arg2 == arg0.last_updated_ms) {
            assert_vault_accounting<T0>(arg0);
            return
        };
        let v0 = account_scheduled_rewards<T0>(arg0, arg2);
        arg0.last_updated_ms = arg2;
        if (v0 == 0) {
            assert_vault_accounting<T0>(arg0);
            return
        };
        if (arg0.enabled && arg1 > 0) {
            allocate_rewards<T0>(arg0, v0);
            let v1 = (v0 as u256) * 340282366920938463463374607431768211456 + arg0.acc_reward_remainder;
            arg0.acc_reward_per_exposure = arg0.acc_reward_per_exposure + v1 / (arg1 as u256);
            arg0.acc_reward_remainder = v1 % (arg1 as u256);
        } else {
            arg0.undistributed_rewards = checked_add(arg0.undistributed_rewards, v0);
        };
        assert_vault_accounting<T0>(arg0);
    }

    fun update_global_with_cutoff<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: u64, arg2: u64, arg3: u64) {
        if (arg3 == 0 || arg2 <= arg3) {
            update_global<T0>(arg0, arg1, arg2);
            return
        };
        if (arg0.last_updated_ms < arg3) {
            update_global<T0>(arg0, arg1, arg3);
        };
        update_global<T0>(arg0, 0, arg2);
    }

    fun vested_amount(arg0: &FundingLot, arg1: u64) : u64 {
        if (arg1 <= arg0.start_ms) {
            return 0
        };
        if (arg1 >= arg0.end_ms) {
            return arg0.budget
        };
        (((arg0.budget as u256) * ((arg1 - arg0.start_ms) as u256) / ((arg0.end_ms - arg0.start_ms) as u256)) as u64)
    }

    public fun withdraw_and_close_by_admin<T0: drop>(arg0: &mut CoinRewarder<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_payout_active<T0>(arg0, arg1);
        assert!(!arg0.withdrawn, 9417);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.last_updated_ms, 9411);
        assert_vault_accounting<T0>(arg0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::unregister_rewarder_by_admin(arg3, arg1, arg2, &arg0.settlement_cap);
        let v1 = 0x2::balance::value<T0>(&arg0.reward_vault);
        let v2 = arg0.allocated_rewards;
        let v3 = arg0.undistributed_rewards;
        let v4 = release_scheduled_rewards<T0>(arg0);
        arg0.allocated_rewards = 0;
        arg0.undistributed_rewards = 0;
        arg0.acc_reward_remainder = 0;
        arg0.enabled = false;
        if (!arg0.closed) {
            arg0.closed = true;
            arg0.closed_at_ms = v0;
        };
        arg0.withdrawn = true;
        arg0.last_updated_ms = v0;
        assert_vault_accounting<T0>(arg0);
        let v5 = CoinRewarderWithdrawnEvent{
            rewarder_id         : 0x2::object::id<CoinRewarder<T0>>(arg0),
            caller              : 0x2::tx_context::sender(arg5),
            withdrawn_at_ms     : v0,
            amount              : v1,
            allocated_cancelled : v2,
            scheduled_cancelled : v4,
            undistributed       : v3,
        };
        0x2::event::emit<CoinRewarderWithdrawnEvent>(v5);
        emit_updated<T0>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_vault, v1), arg5)
    }

    public fun withdrawn<T0: drop>(arg0: &CoinRewarder<T0>) : bool {
        arg0.withdrawn
    }

    // decompiled from Move bytecode v7
}

