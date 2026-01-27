module 0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::stake_pool {
    struct StakePoolRegistry has key {
        id: 0x2::object::UID,
        num_pool: u64,
    }

    struct StakePool has store, key {
        id: 0x2::object::UID,
        pool_info: StakePoolInfo,
        config: StakePoolConfig,
        incentives: vector<Incentive>,
        u64_padding: vector<u64>,
    }

    struct Incentive has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        config: IncentiveConfig,
        info: IncentiveInfo,
    }

    struct StakePoolInfo has copy, drop, store {
        stake_token: 0x1::type_name::TypeName,
        index: u64,
        next_user_share_id: u64,
        total_share: u64,
        active: bool,
        new_tlp_price: u64,
        depositors_count: u64,
        u64_padding: vector<u64>,
    }

    struct StakePoolConfig has copy, drop, store {
        unlock_countdown_ts_ms: u64,
        usd_per_exp: u64,
        u64_padding: vector<u64>,
    }

    struct IncentiveConfig has copy, drop, store {
        period_incentive_amount: u64,
        incentive_interval_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct IncentiveInfo has copy, drop, store {
        active: bool,
        last_allocate_ts_ms: u64,
        incentive_price_index: u64,
        unallocated_amount: u64,
        u64_padding: vector<u64>,
    }

    struct LpUserShare has store {
        user: address,
        user_share_id: u64,
        stake_ts_ms: u64,
        total_shares: u64,
        active_shares: u64,
        deactivating_shares: vector<DeactivatingShares>,
        last_incentive_price_index: vector<u64>,
        snapshot_ts_ms: u64,
        tlp_price: u64,
        harvested_amount: u64,
        u64_padding: vector<u64>,
    }

    struct DeactivatingShares has store {
        shares: u64,
        unsubscribed_ts_ms: u64,
        unlocked_ts_ms: u64,
        unsubscribed_incentive_price_index: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct NewStakePoolEvent has copy, drop {
        sender: address,
        stake_pool_info: StakePoolInfo,
        stake_pool_config: StakePoolConfig,
        u64_padding: vector<u64>,
    }

    struct AutoCompoundEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token: 0x1::type_name::TypeName,
        incentive_price_index: u64,
        total_amount: u64,
        compound_users: u64,
        total_users: u64,
        u64_padding: vector<u64>,
    }

    struct AddIncentiveTokenEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token: 0x1::type_name::TypeName,
        incentive_info: IncentiveInfo,
        incentive_config: IncentiveConfig,
        u64_padding: vector<u64>,
    }

    struct DeactivateStakePoolEvent has copy, drop {
        sender: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct ActivateStakePoolEvent has copy, drop {
        sender: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct DeactivateIncentiveTokenEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct ActivateIncentiveTokenEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct RemoveIncentiveTokenEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token: 0x1::type_name::TypeName,
        incentive_balance_value: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateUnlockCountdownTsMsEvent has copy, drop {
        sender: address,
        index: u64,
        previous_unlock_countdown_ts_ms: u64,
        new_unlock_countdown_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateIncentiveConfigEvent has copy, drop {
        sender: address,
        index: u64,
        previous_incentive_config: IncentiveConfig,
        new_incentive_config: IncentiveConfig,
        u64_padding: vector<u64>,
    }

    struct DepositIncentiveEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawIncentiveEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token_type: 0x1::type_name::TypeName,
        withdrawal_amount: u64,
        u64_padding: vector<u64>,
    }

    struct StakeEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        stake_amount: u64,
        user_share_id: u64,
        stake_ts_ms: u64,
        last_incentive_price_index: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct UpdatePoolInfoU64PaddingEvent has copy, drop {
        sender: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct SnapshotEvent has copy, drop {
        sender: address,
        index: u64,
        user_share_id: u64,
        shares: u64,
        tlp_price: u64,
        last_ts_ms: u64,
        current_ts_ms: u64,
        exp: u64,
        u64_padding: vector<u64>,
    }

    struct UnsubscribeEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        user_share_id: u64,
        unsubscribed_shares: u64,
        unsubscribe_ts_ms: u64,
        unlocked_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct UnstakeEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        user_share_id: u64,
        unstake_amount: u64,
        unstake_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct HarvestPerUserShareEvent has copy, drop {
        sender: address,
        index: u64,
        incentive_token_type: 0x1::type_name::TypeName,
        harvest_amount: u64,
        user_share_id: u64,
        u64_padding: vector<u64>,
    }

    entry fun activate_incentive_token<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_mut_incentive(v1, &v2);
        v3.info.last_allocate_ts_ms = 0x2::clock::timestamp_ms(arg3) / v3.config.incentive_interval_ts_ms * v3.config.incentive_interval_ts_ms;
        v3.info.active = true;
        let v4 = ActivateIncentiveTokenEvent{
            sender          : 0x2::tx_context::sender(arg4),
            index           : arg2,
            incentive_token : v2,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ActivateIncentiveTokenEvent>(v4);
    }

    entry fun activate_stake_pool(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(!v1.pool_info.active, 13);
        v1.pool_info.active = true;
        let v2 = ActivateStakePoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ActivateStakePoolEvent>(v2);
    }

    entry fun add_incentive_token<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg6);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_incentive_tokens(v1);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 4);
        assert!(arg4 > 0, 11);
        let v4 = IncentiveConfig{
            period_incentive_amount  : arg3,
            incentive_interval_ts_ms : arg4,
            u64_padding              : 0x1::vector::empty<u64>(),
        };
        let v5 = IncentiveInfo{
            active                : true,
            last_allocate_ts_ms   : 0x2::clock::timestamp_ms(arg5),
            incentive_price_index : 0,
            unallocated_amount    : 0,
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        let v6 = Incentive{
            token_type : v2,
            config     : v4,
            info       : v5,
        };
        0x1::vector::push_back<Incentive>(&mut v1.incentives, v6);
        let v7 = AddIncentiveTokenEvent{
            sender           : 0x2::tx_context::sender(arg6),
            index            : arg2,
            incentive_token  : v6.token_type,
            incentive_info   : v6.info,
            incentive_config : v6.config,
            u64_padding      : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AddIncentiveTokenEvent>(v7);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2, 0x2::balance::zero<T0>());
        let v8 = 0x1::vector::length<Incentive>(&v1.incentives) - 1;
        let v9 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v1.id, 0x1::string::utf8(b"lp_user_shares"));
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v9);
        if (v10 > 0) {
            let v11 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v9) as u64);
            let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v9, 0);
            let v13 = 0;
            while (v13 < v10) {
                let (_, v15) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<address, LpUserShare>(v12, v13 % v11);
                while (0x1::vector::length<u64>(&v15.last_incentive_price_index) <= v8) {
                    0x1::vector::push_back<u64>(&mut v15.last_incentive_price_index, 0);
                };
                let v16 = &mut v15.deactivating_shares;
                let v17 = 0;
                while (v17 < 0x1::vector::length<DeactivatingShares>(v16)) {
                    let v18 = 0x1::vector::borrow_mut<DeactivatingShares>(v16, v17);
                    while (0x1::vector::length<u64>(&v18.unsubscribed_incentive_price_index) <= v8) {
                        0x1::vector::push_back<u64>(&mut v18.unsubscribed_incentive_price_index, 0);
                    };
                    v17 = v17 + 1;
                };
                if (v13 + 1 < v10 && (v13 + 1) % v11 == 0) {
                    v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v9, (((v13 + 1) / v11) as u16));
                };
                v13 = v13 + 1;
            };
        };
    }

    public(friend) fun allocate_incentive(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Incentive>(&v1.incentives)) {
            let v3 = 0x1::vector::borrow_mut<Incentive>(&mut v1.incentives, v2);
            let v4 = 0x2::clock::timestamp_ms(arg3) / v3.config.incentive_interval_ts_ms * v3.config.incentive_interval_ts_ms;
            let v5 = v3.info.last_allocate_ts_ms;
            if (v3.info.active && v4 > v5) {
                let (v6, v7) = if (v1.pool_info.total_share > 0) {
                    let v8 = (((v3.config.period_incentive_amount as u128) * ((v4 - v5) as u128) / (v3.config.incentive_interval_ts_ms as u128)) as u64);
                    (v8, (((multiplier(9) as u128) * (v8 as u128) / (v1.pool_info.total_share as u128)) as u64))
                } else {
                    (0, 0)
                };
                assert!(v3.info.unallocated_amount >= v6, 9);
                v3.info.unallocated_amount = v3.info.unallocated_amount - v6;
                v3.info.incentive_price_index = v3.info.incentive_price_index + v7;
                v3.info.last_allocate_ts_ms = v4;
            };
            v2 = v2 + 1;
        };
    }

    entry fun auto_compound<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg4);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v2 == v1.pool_info.stake_token, 0);
        let v3 = get_incentive_tokens(v1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 3);
        let v4 = get_incentive(v1, &v2).info.incentive_price_index;
        let v5 = 0x1::option::destroy_some<u64>(get_incentive_idx(v1, &v2));
        let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v1.id, 0x1::string::utf8(b"lp_user_shares"));
        let v7 = 0;
        let v8 = 0;
        let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v6);
        if (v9 > 0) {
            let v10 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v6) as u64);
            let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v6, 0);
            let v12 = 0;
            while (v12 < v9) {
                let (_, v14) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<address, LpUserShare>(v11, v12 % v10);
                let (v15, _) = calculate_incentive_by_idx(v4, v5, v14);
                update_last_incentive_price_index_by_idx(v14, v5, v4);
                log_harvested_amount(v14, v15);
                v7 = v7 + v15;
                v14.total_shares = v14.total_shares + v15;
                v14.active_shares = v14.active_shares + v15;
                v8 = v8 + 1;
                if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                    v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v6, (((v12 + 1) / v10) as u16));
                };
                v12 = v12 + 1;
            };
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"staked_tlp")), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2), v7));
        v1.pool_info.total_share = v1.pool_info.total_share + v7;
        let v17 = AutoCompoundEvent{
            sender                : 0x2::tx_context::sender(arg4),
            index                 : arg2,
            incentive_token       : v2,
            incentive_price_index : v4,
            total_amount          : v7,
            compound_users        : v8,
            total_users           : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v6),
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AutoCompoundEvent>(v17);
    }

    fun calculate_incentive_by_idx(arg0: u64, arg1: u64, arg2: &LpUserShare) : (u64, u64) {
        assert!(arg1 < 0x1::vector::length<u64>(&arg2.last_incentive_price_index), 16);
        let v0 = *0x1::vector::borrow<u64>(&arg2.last_incentive_price_index, arg1);
        let v1 = 0 + (((arg2.active_shares as u128) * ((arg0 - v0) as u128) / (multiplier(9) as u128)) as u64);
        let v2 = 0;
        while (v2 < 0x1::vector::length<DeactivatingShares>(&arg2.deactivating_shares)) {
            let v3 = 0x1::vector::borrow<DeactivatingShares>(&arg2.deactivating_shares, v2);
            assert!(arg1 < 0x1::vector::length<u64>(&v3.unsubscribed_incentive_price_index), 16);
            let v4 = *0x1::vector::borrow<u64>(&v3.unsubscribed_incentive_price_index, arg1);
            let v5 = if (v4 > v0) {
                v4 - v0
            } else {
                0
            };
            v1 = v1 + (((v3.shares as u128) * (v5 as u128) / (multiplier(9) as u128)) as u64);
            v2 = v2 + 1;
        };
        (v1, arg0)
    }

    fun check_stake_pool_active(arg0: &StakePool) : bool {
        arg0.pool_info.active
    }

    entry fun deactivate_incentive_token<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg4);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        get_mut_incentive(v1, &v2).info.active = false;
        let v3 = DeactivateIncentiveTokenEvent{
            sender          : 0x2::tx_context::sender(arg4),
            index           : arg2,
            incentive_token : v2,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DeactivateIncentiveTokenEvent>(v3);
    }

    entry fun deactivate_stake_pool(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(v1.pool_info.active, 14);
        v1.pool_info.active = false;
        let v2 = DeactivateStakePoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DeactivateStakePoolEvent>(v2);
    }

    entry fun deposit_incentive<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_incentive_tokens(v1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 3);
        let v4 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2), 0x2::coin::into_balance<T0>(arg3));
        let v5 = get_mut_incentive(v1, &v2);
        v5.info.unallocated_amount = v5.info.unallocated_amount + v4;
        let v6 = DepositIncentiveEvent{
            sender               : 0x2::tx_context::sender(arg4),
            index                : arg2,
            incentive_token_type : v2,
            deposit_amount       : v4,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DepositIncentiveEvent>(v6);
    }

    fun get_incentive(arg0: &StakePool, arg1: &0x1::type_name::TypeName) : &Incentive {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            if (0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type == *arg1) {
                return 0x1::vector::borrow<Incentive>(&arg0.incentives, v0)
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    fun get_incentive_idx(arg0: &StakePool, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            if (0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type == *arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_incentive_tokens(arg0: &StakePool) : vector<0x1::type_name::TypeName> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type);
            v0 = v0 + 1;
        };
        v1
    }

    fun get_last_incentive_price_index(arg0: &StakePool) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Incentive>(&arg0.incentives, v0).info.incentive_price_index);
            v0 = v0 + 1;
        };
        v1
    }

    fun get_mut_incentive(arg0: &mut StakePool, arg1: &0x1::type_name::TypeName) : &mut Incentive {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            if (0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type == *arg1) {
                return 0x1::vector::borrow_mut<Incentive>(&mut arg0.incentives, v0)
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    fun get_mut_stake_pool(arg0: &mut 0x2::object::UID, arg1: u64) : &mut StakePool {
        0x2::dynamic_object_field::borrow_mut<u64, StakePool>(arg0, arg1)
    }

    fun get_stake_pool(arg0: &0x2::object::UID, arg1: u64) : &StakePool {
        0x2::dynamic_object_field::borrow<u64, StakePool>(arg0, arg1)
    }

    public(friend) fun get_user_shares(arg0: &StakePoolRegistry, arg1: u64, arg2: address) : vector<u8> {
        let v0 = get_stake_pool(&arg0.id, arg1);
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&v0.id, 0x1::string::utf8(b"lp_user_shares"));
        if (!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(v1, arg2)) {
            return 0x1::vector::empty<u8>()
        };
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, LpUserShare>(v1, arg2);
        let v3 = get_incentive_tokens(v0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &v3;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(v5)) {
            let v7 = 0x1::vector::borrow<0x1::type_name::TypeName>(v5, v6);
            let v8 = get_incentive_idx(v0, v7);
            if (0x1::option::is_some<u64>(&v8)) {
                let (v9, _) = calculate_incentive_by_idx(get_incentive(v0, v7).info.incentive_price_index, 0x1::option::destroy_some<u64>(v8), v2);
                0x1::vector::push_back<u64>(&mut v4, v9);
            };
            v6 = v6 + 1;
        };
        let v11 = 0x2::bcs::to_bytes<LpUserShare>(v2);
        0x1::vector::append<u8>(&mut v11, 0x2::bcs::to_bytes<vector<u64>>(&v4));
        v11
    }

    public(friend) fun get_user_shares_by_user_share_id(arg0: &StakePoolRegistry, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = get_stake_pool(&arg0.id, arg1);
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&v0.id, 0x1::string::utf8(b"lp_user_shares"));
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v1);
        if (v3 > 0) {
            let v4 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v1) as u64);
            let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<address, LpUserShare>(v1, 0);
            let v6 = 0;
            while (v6 < v3) {
                let (_, v8) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<address, LpUserShare>(v5, v6 % v4);
                if (v8.user_share_id == arg2) {
                    let v9 = get_incentive_tokens(v0);
                    let v10 = 0x1::vector::empty<u64>();
                    let v11 = &v9;
                    let v12 = 0;
                    while (v12 < 0x1::vector::length<0x1::type_name::TypeName>(v11)) {
                        let v13 = 0x1::vector::borrow<0x1::type_name::TypeName>(v11, v12);
                        let v14 = get_incentive_idx(v0, v13);
                        if (0x1::option::is_some<u64>(&v14)) {
                            let (v15, _) = calculate_incentive_by_idx(get_incentive(v0, v13).info.incentive_price_index, 0x1::option::destroy_some<u64>(v14), v8);
                            0x1::vector::push_back<u64>(&mut v10, v15);
                        };
                        v12 = v12 + 1;
                    };
                    let v17 = 0x2::bcs::to_bytes<LpUserShare>(v8);
                    0x1::vector::append<u8>(&mut v17, 0x2::bcs::to_bytes<vector<u64>>(&v10));
                    v2 = v17;
                };
                if (v6 + 1 < v3 && (v6 + 1) % v4 == 0) {
                    v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<address, LpUserShare>(v1, (((v6 + 1) / v4) as u16));
                };
                v6 = v6 + 1;
            };
        };
        v2
    }

    public fun harvest_per_user_share<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_incentive_tokens(v1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 3);
        let v4 = 0x1::option::destroy_some<u64>(get_incentive_idx(v1, &v2));
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, LpUserShare>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v1.id, 0x1::string::utf8(b"lp_user_shares")), 0x2::tx_context::sender(arg4));
        let v6 = v5.user_share_id;
        let (v7, v8) = calculate_incentive_by_idx(get_incentive(v1, &v2).info.incentive_price_index, v4, v5);
        update_last_incentive_price_index_by_idx(v5, v4, v8);
        log_harvested_amount(v5, v7);
        if (v7 > 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, v2))) {
            abort 9
        };
        let v9 = HarvestPerUserShareEvent{
            sender               : 0x2::tx_context::sender(arg4),
            index                : arg2,
            incentive_token_type : v2,
            harvest_amount       : v7,
            user_share_id        : v6,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<HarvestPerUserShareEvent>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2), v7), arg4)
    }

    fun harvest_progress_updated(arg0: vector<u64>, arg1: vector<u64>) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0);
        if (0x1::vector::length<u64>(&arg1) != v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u64>(&arg0, v1) != *0x1::vector::borrow<u64>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePoolRegistry{
            id       : 0x2::object::new(arg0),
            num_pool : 0,
        };
        0x2::transfer::share_object<StakePoolRegistry>(v0);
    }

    fun log_harvested_amount(arg0: &mut LpUserShare, arg1: u64) {
        arg0.harvested_amount = arg0.harvested_amount + arg1;
    }

    fun multiplier(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    entry fun new_stake_pool<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg3);
        let v0 = 0x2::object::new(arg3);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0, 0x1::string::utf8(b"staked_tlp"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v0, 0x1::string::utf8(b"lp_user_shares"), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<address, LpUserShare>(1000, arg3));
        let v1 = StakePoolInfo{
            stake_token        : 0x1::type_name::with_defining_ids<T0>(),
            index              : arg1.num_pool,
            next_user_share_id : 0,
            total_share        : 0,
            active             : true,
            new_tlp_price      : 10000,
            depositors_count   : 0,
            u64_padding        : 0x1::vector::empty<u64>(),
        };
        let v2 = StakePoolConfig{
            unlock_countdown_ts_ms : arg2,
            usd_per_exp            : 200,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        let v3 = StakePool{
            id          : v0,
            pool_info   : v1,
            config      : v2,
            incentives  : 0x1::vector::empty<Incentive>(),
            u64_padding : 0x1::vector::empty<u64>(),
        };
        let v4 = NewStakePoolEvent{
            sender            : 0x2::tx_context::sender(arg3),
            stake_pool_info   : v3.pool_info,
            stake_pool_config : v3.config,
            u64_padding       : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewStakePoolEvent>(v4);
        0x2::dynamic_object_field::add<u64, StakePool>(&mut arg1.id, arg1.num_pool, v3);
        arg1.num_pool = arg1.num_pool + 1;
    }

    fun remove_incentive(arg0: &mut StakePool, arg1: &0x1::type_name::TypeName) : Incentive {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            if (0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type == *arg1) {
                return 0x1::vector::remove<Incentive>(&mut arg0.incentives, v0)
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    public fun remove_incentive_token<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg2);
        let v3 = get_incentive_tokens(v2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v0), 3);
        let v4 = get_incentive_idx(v2, &v0);
        assert!(0x1::option::is_some<u64>(&v4), 3);
        let v5 = 0x1::option::destroy_some<u64>(v4);
        let v6 = remove_incentive(v2, &v0);
        let Incentive {
            token_type : _,
            config     : _,
            info       : v9,
        } = v6;
        let v10 = v9;
        let v11 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, v0);
        let v12 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v2.id, 0x1::string::utf8(b"lp_user_shares"));
        let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v12);
        if (v13 > 0) {
            let v14 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v12) as u64);
            let v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v12, 0);
            let v16 = 0;
            while (v16 < v13) {
                let (_, v18) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<address, LpUserShare>(v15, v16 % v14);
                if (v5 < 0x1::vector::length<u64>(&v18.last_incentive_price_index)) {
                    assert!(*0x1::vector::borrow<u64>(&v18.last_incentive_price_index, v5) == v10.incentive_price_index, 15);
                    0x1::vector::remove<u64>(&mut v18.last_incentive_price_index, v5);
                };
                let v19 = &mut v18.deactivating_shares;
                let v20 = 0;
                while (v20 < 0x1::vector::length<DeactivatingShares>(v19)) {
                    let v21 = 0x1::vector::borrow_mut<DeactivatingShares>(v19, v20);
                    if (v5 < 0x1::vector::length<u64>(&v21.unsubscribed_incentive_price_index)) {
                        0x1::vector::remove<u64>(&mut v21.unsubscribed_incentive_price_index, v5);
                    };
                    v20 = v20 + 1;
                };
                if (v16 + 1 < v13 && (v16 + 1) % v14 == 0) {
                    v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, LpUserShare>(v12, (((v16 + 1) / v14) as u16));
                };
                v16 = v16 + 1;
            };
        };
        let v22 = RemoveIncentiveTokenEvent{
            sender                  : 0x2::tx_context::sender(arg3),
            index                   : arg2,
            incentive_token         : v0,
            incentive_balance_value : 0x2::balance::value<T0>(&v11),
            u64_padding             : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RemoveIncentiveTokenEvent>(v22);
        0x2::coin::from_balance<T0>(v11, arg3)
    }

    public fun snapshot(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg4);
        assert!(check_stake_pool_active(v2), 12);
        let v3 = v2.pool_info.new_tlp_price;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, LpUserShare>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v2.id, 0x1::string::utf8(b"lp_user_shares")), v0);
        let v5 = v4.active_shares;
        let v6 = v4.snapshot_ts_ms;
        let v7 = v4.tlp_price;
        let v8 = v4.user_share_id;
        let v9 = 0x2::clock::timestamp_ms(arg5);
        let v10 = v2.config.usd_per_exp;
        let v11 = (((v5 as u256) * (v7 as u256) * (((v9 - v6) / 60000) as u256) / (multiplier(13) as u256) / ((60 * v10) as u256)) as u64);
        v4.snapshot_ts_ms = v9;
        v4.tlp_price = v3;
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::add_tails_exp_amount(arg0, arg2, arg3, v0, v11);
        let v12 = 0x1::vector::empty<u64>();
        let v13 = &mut v12;
        0x1::vector::push_back<u64>(v13, v3);
        0x1::vector::push_back<u64>(v13, v10);
        let v14 = SnapshotEvent{
            sender        : 0x2::tx_context::sender(arg6),
            index         : arg4,
            user_share_id : v8,
            shares        : v5,
            tlp_price     : v7,
            last_ts_ms    : v6,
            current_ts_ms : v9,
            exp           : v11,
            u64_padding   : v12,
        };
        0x2::event::emit<SnapshotEvent>(v14);
    }

    public fun stake<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg2);
        assert!(check_stake_pool_active(v2), 12);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v3 == v2.pool_info.stake_token, 0);
        let v4 = 0x2::coin::into_balance<T0>(arg3);
        let v5 = 0x2::balance::value<T0>(&v4);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::string::utf8(b"staked_tlp")), v4);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let v7 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v2.id, 0x1::string::utf8(b"lp_user_shares"));
        if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(v7, v0)) {
            assert!(harvest_progress_updated(get_last_incentive_price_index(v2), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, LpUserShare>(v7, v0).last_incentive_price_index), 8);
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, LpUserShare>(v7, v0);
            v8.stake_ts_ms = v6;
            assert!(v8.snapshot_ts_ms == v6, 10);
            v8.total_shares = v8.total_shares + v5;
            v8.active_shares = v8.active_shares + v5;
            let v9 = StakeEvent{
                sender                     : 0x2::tx_context::sender(arg5),
                index                      : arg2,
                lp_token_type              : v3,
                stake_amount               : v8.total_shares,
                user_share_id              : v8.user_share_id,
                stake_ts_ms                : v8.stake_ts_ms,
                last_incentive_price_index : v8.last_incentive_price_index,
                u64_padding                : v8.u64_padding,
            };
            0x2::event::emit<StakeEvent>(v9);
        } else {
            let v10 = LpUserShare{
                user                       : v0,
                user_share_id              : v2.pool_info.next_user_share_id,
                stake_ts_ms                : v6,
                total_shares               : v5,
                active_shares              : v5,
                deactivating_shares        : 0x1::vector::empty<DeactivatingShares>(),
                last_incentive_price_index : get_last_incentive_price_index(v2),
                snapshot_ts_ms             : v6,
                tlp_price                  : v2.pool_info.new_tlp_price,
                harvested_amount           : 0,
                u64_padding                : vector[],
            };
            v2.pool_info.next_user_share_id = v2.pool_info.next_user_share_id + 1;
            let v11 = StakeEvent{
                sender                     : 0x2::tx_context::sender(arg5),
                index                      : arg2,
                lp_token_type              : v3,
                stake_amount               : v10.total_shares,
                user_share_id              : v10.user_share_id,
                stake_ts_ms                : v10.stake_ts_ms,
                last_incentive_price_index : v10.last_incentive_price_index,
                u64_padding                : v10.u64_padding,
            };
            0x2::event::emit<StakeEvent>(v11);
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, LpUserShare>(v7, v0, v10);
        };
        v2.pool_info.depositors_count = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v7);
        v2.pool_info.total_share = v2.pool_info.total_share + v5;
    }

    public fun unstake<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v2 == v1.pool_info.stake_token, 0);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v1.id, 0x1::string::utf8(b"lp_user_shares"));
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, LpUserShare>(v5, v4);
        assert!(harvest_progress_updated(get_last_incentive_price_index(v1), v6.last_incentive_price_index), 8);
        let v7 = 0;
        let v8 = 0;
        while (v7 < 0x1::vector::length<DeactivatingShares>(&v6.deactivating_shares)) {
            if (0x1::vector::borrow<DeactivatingShares>(&v6.deactivating_shares, v7).unsubscribed_ts_ms + v1.config.unlock_countdown_ts_ms <= v3) {
                let DeactivatingShares {
                    shares                             : v9,
                    unsubscribed_ts_ms                 : _,
                    unlocked_ts_ms                     : _,
                    unsubscribed_incentive_price_index : _,
                    u64_padding                        : _,
                } = 0x1::vector::remove<DeactivatingShares>(&mut v6.deactivating_shares, v7);
                v8 = v8 + v9;
                continue
            };
            v7 = v7 + 1;
        };
        assert!(v6.snapshot_ts_ms == v3, 10);
        v6.total_shares = v6.total_shares - v8;
        let v14 = if (0x1::vector::length<DeactivatingShares>(&v6.deactivating_shares) == 0) {
            if (v6.total_shares == 0) {
                v6.active_shares == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v14) {
            let LpUserShare {
                user                       : _,
                user_share_id              : _,
                stake_ts_ms                : _,
                total_shares               : _,
                active_shares              : _,
                deactivating_shares        : v20,
                last_incentive_price_index : _,
                snapshot_ts_ms             : _,
                tlp_price                  : _,
                harvested_amount           : _,
                u64_padding                : _,
            } = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<address, LpUserShare>(v5, v4);
            0x1::vector::destroy_empty<DeactivatingShares>(v20);
        };
        let v26 = UnstakeEvent{
            sender         : 0x2::tx_context::sender(arg4),
            index          : arg2,
            lp_token_type  : v2,
            user_share_id  : v6.user_share_id,
            unstake_amount : v8,
            unstake_ts_ms  : v3,
            u64_padding    : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnstakeEvent>(v26);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"staked_tlp")), v8), arg4)
    }

    public fun unsubscribe<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v2 == v1.pool_info.stake_token, 0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, LpUserShare>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector>(&mut v1.id, 0x1::string::utf8(b"lp_user_shares")), 0x2::tx_context::sender(arg5));
        let v5 = v4.user_share_id;
        let v6 = if (0x1::option::is_some<u64>(&arg3)) {
            0x1::option::extract<u64>(&mut arg3)
        } else {
            v4.active_shares
        };
        assert!(v4.active_shares >= v6, 6);
        assert!(v4.snapshot_ts_ms == v3, 10);
        v4.active_shares = v4.active_shares - v6;
        let v7 = v3 + v1.config.unlock_countdown_ts_ms;
        let v8 = DeactivatingShares{
            shares                             : v6,
            unsubscribed_ts_ms                 : v3,
            unlocked_ts_ms                     : v7,
            unsubscribed_incentive_price_index : get_last_incentive_price_index(v1),
            u64_padding                        : 0x1::vector::empty<u64>(),
        };
        0x1::vector::push_back<DeactivatingShares>(&mut v4.deactivating_shares, v8);
        v1.pool_info.total_share = v1.pool_info.total_share - v6;
        let v9 = UnsubscribeEvent{
            sender              : 0x2::tx_context::sender(arg5),
            index               : arg2,
            lp_token_type       : v2,
            user_share_id       : v5,
            unsubscribed_shares : v6,
            unsubscribe_ts_ms   : v3,
            unlocked_ts_ms      : v7,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnsubscribeEvent>(v9);
    }

    entry fun update_incentive_config<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<vector<u64>>, arg7: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg7);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_mut_incentive(v1, &v2);
        if (0x1::option::is_some<u64>(&arg4)) {
            v3.config.period_incentive_amount = 0x1::option::extract<u64>(&mut arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v3.config.incentive_interval_ts_ms = 0x1::option::extract<u64>(&mut arg5);
        };
        if (0x1::option::is_some<vector<u64>>(&arg6)) {
            v3.config.u64_padding = 0x1::option::extract<vector<u64>>(&mut arg6);
        };
        let v4 = UpdateIncentiveConfigEvent{
            sender                    : 0x2::tx_context::sender(arg7),
            index                     : arg2,
            previous_incentive_config : v3.config,
            new_incentive_config      : v3.config,
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateIncentiveConfigEvent>(v4);
    }

    fun update_last_incentive_price_index_by_idx(arg0: &mut LpUserShare, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.last_incentive_price_index, arg1) = arg2;
    }

    entry fun update_pool_info_u64_padding(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg5);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        v1.pool_info.new_tlp_price = arg3;
        v1.config.usd_per_exp = arg4;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, arg4);
        let v4 = UpdatePoolInfoU64PaddingEvent{
            sender      : 0x2::tx_context::sender(arg5),
            index       : arg2,
            u64_padding : v2,
        };
        0x2::event::emit<UpdatePoolInfoU64PaddingEvent>(v4);
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(check_stake_pool_active(v1), 12);
        v1.config.unlock_countdown_ts_ms = arg3;
        let v2 = UpdateUnlockCountdownTsMsEvent{
            sender                          : 0x2::tx_context::sender(arg4),
            index                           : arg2,
            previous_unlock_countdown_ts_ms : v1.config.unlock_countdown_ts_ms,
            new_unlock_countdown_ts_ms      : arg3,
            u64_padding                     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateUnlockCountdownTsMsEvent>(v2);
    }

    public fun withdraw_incentive<T0>(arg0: &0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin::verify(arg0, arg5);
        allocate_incentive(arg0, arg1, arg2, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_incentive_tokens(v1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 3);
        let v4 = get_mut_incentive(v1, &v2);
        let v5 = if (0x1::option::is_some<u64>(&arg3)) {
            let v6 = 0x1::option::extract<u64>(&mut arg3);
            if (v6 > v4.info.unallocated_amount) {
                v4.info.unallocated_amount
            } else {
                v6
            }
        } else {
            v4.info.unallocated_amount
        };
        v4.info.unallocated_amount = v4.info.unallocated_amount - v5;
        let v7 = WithdrawIncentiveEvent{
            sender               : 0x2::tx_context::sender(arg5),
            index                : arg2,
            incentive_token_type : v2,
            withdrawal_amount    : v5,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<WithdrawIncentiveEvent>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2), v5), arg5)
    }

    // decompiled from Move bytecode v6
}

