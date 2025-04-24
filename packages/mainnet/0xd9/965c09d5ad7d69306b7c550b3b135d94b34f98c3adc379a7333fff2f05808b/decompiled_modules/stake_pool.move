module 0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::stake_pool {
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
        u64_padding: vector<u64>,
    }

    struct StakePoolConfig has copy, drop, store {
        unlock_countdown_ts_ms: u64,
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
        last_incentive_price_index: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        u64_padding: vector<u64>,
    }

    struct DeactivatingShares has store {
        shares: u64,
        unsubscribed_ts_ms: u64,
        unlocked_ts_ms: u64,
        unsubscribed_incentive_price_index: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        u64_padding: vector<u64>,
    }

    struct NewStakePoolEvent has copy, drop {
        sender: address,
        stake_pool_info: StakePoolInfo,
        stake_pool_config: StakePoolConfig,
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
        last_incentive_price_index: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
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

    entry fun activate_incentive_token<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
        get_mut_incentive(v1, &v2).info.active = true;
        let v3 = ActivateIncentiveTokenEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            incentive_token : v2,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ActivateIncentiveTokenEvent>(v3);
    }

    entry fun add_incentive_token<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg6);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = get_incentive_tokens(v1);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v2), 4);
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
    }

    public(friend) fun allocate_incentive(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
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
                v3.info.unallocated_amount = v3.info.unallocated_amount - v6;
                v3.info.incentive_price_index = v3.info.incentive_price_index + v7;
                v3.info.last_allocate_ts_ms = v4;
            };
            v2 = v2 + 1;
        };
    }

    fun calculate_incentive(arg0: &StakePool, arg1: &0x1::type_name::TypeName, arg2: &LpUserShare) : (u64, u64) {
        let v0 = get_incentive(arg0, arg1).info.incentive_price_index;
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg2.last_incentive_price_index, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg2.last_incentive_price_index, arg1)
        } else {
            0
        };
        let v2 = 0 + (((arg2.active_shares as u128) * ((v0 - v1) as u128) / (multiplier(9) as u128)) as u64);
        let v3 = 0;
        while (v3 < 0x1::vector::length<DeactivatingShares>(&arg2.deactivating_shares)) {
            let v4 = 0x1::vector::borrow<DeactivatingShares>(&arg2.deactivating_shares, v3);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v4.unsubscribed_incentive_price_index, arg1)) {
                let v5 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v4.unsubscribed_incentive_price_index, arg1);
                let v6 = if (v5 > v1) {
                    v5 - v1
                } else {
                    0
                };
                v2 = v2 + (((v4.shares as u128) * (v6 as u128) / (multiplier(9) as u128)) as u64);
            };
            v3 = v3 + 1;
        };
        (v2, v0)
    }

    fun create_user_last_incentive_ts_ms(arg0: &StakePool, arg1: u64) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = arg0.incentives;
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        while (0x1::vector::length<Incentive>(&v0) > 0) {
            let v2 = 0x1::vector::pop_back<Incentive>(&mut v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, v2.token_type, arg1);
        };
        v1
    }

    entry fun deactivate_incentive_token<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
        get_mut_incentive(v1, &v2).info.active = false;
        let v3 = DeactivateIncentiveTokenEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            incentive_token : v2,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DeactivateIncentiveTokenEvent>(v3);
    }

    entry fun deposit_incentive<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
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

    fun get_incentive_tokens(arg0: &StakePool) : vector<0x1::type_name::TypeName> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type);
            v0 = v0 + 1;
        };
        v1
    }

    fun get_last_incentive_price_index(arg0: &StakePool) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = arg0.incentives;
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        while (0x1::vector::length<Incentive>(&v0) > 0) {
            let v2 = 0x1::vector::pop_back<Incentive>(&mut v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, v2.token_type, v2.info.incentive_price_index);
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

    fun get_user_share_ids(arg0: &StakePool, arg1: address) : vector<u64> {
        let v0 = 0x2::table::borrow<address, vector<LpUserShare>>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, vector<LpUserShare>>>(&arg0.id, 0x1::string::utf8(b"lp_user_shares")), arg1);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<LpUserShare>(v0)) {
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::borrow<LpUserShare>(v0, v1).user_share_id);
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun get_user_shares(arg0: &StakePoolRegistry, arg1: u64, arg2: address) : vector<vector<u8>> {
        let v0 = get_stake_pool(&arg0.id, arg1);
        let v1 = 0x2::table::borrow<address, vector<LpUserShare>>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, vector<LpUserShare>>>(&v0.id, 0x1::string::utf8(b"lp_user_shares")), arg2);
        let v2 = get_incentive_tokens(v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<vector<u8>>();
        while (v3 < 0x1::vector::length<LpUserShare>(v1)) {
            let v5 = 0x1::vector::borrow<LpUserShare>(v1, v3);
            let v6 = 0x1::vector::empty<u64>();
            let v7 = &v2;
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(v7)) {
                let (v9, _) = calculate_incentive(v0, 0x1::vector::borrow<0x1::type_name::TypeName>(v7, v8), v5);
                0x1::vector::push_back<u64>(&mut v6, v9);
                v8 = v8 + 1;
            };
            let v11 = 0x2::bcs::to_bytes<LpUserShare>(v5);
            0x1::vector::append<u8>(&mut v11, 0x2::bcs::to_bytes<vector<u64>>(&v6));
            0x1::vector::push_back<vector<u8>>(&mut v4, v11);
            v3 = v3 + 1;
        };
        v4
    }

    public fun harvest_per_user_share<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg2);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = get_incentive_tokens(v2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v4, &v3), 3);
        let v5 = &mut v2.id;
        let v6 = remove_user_share_by_id(v5, v0, arg3);
        let (v7, v8) = calculate_incentive(v2, &v3, &v6);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v6.last_incentive_price_index, &v3)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v6.last_incentive_price_index, &v3) = v8;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6.last_incentive_price_index, v3, v8);
        };
        if (v7 > 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v2.id, v3))) {
            abort 9
        };
        let v9 = HarvestPerUserShareEvent{
            sender               : 0x2::tx_context::sender(arg5),
            index                : arg2,
            incentive_token_type : v3,
            harvest_amount       : v7,
            user_share_id        : v6.user_share_id,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<HarvestPerUserShareEvent>(v9);
        let v10 = &mut v2.id;
        store_user_shares(v10, v0, 0x1::vector::singleton<LpUserShare>(v6));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, v3), v7), arg5)
    }

    fun harvest_progress_updated(arg0: &StakePool, arg1: &LpUserShare) : bool {
        let v0 = true;
        let v1 = get_incentive_tokens(arg0);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.last_incentive_price_index, &v2)) {
                if (*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg1.last_incentive_price_index, &v2) != get_incentive(arg0, &v2).info.incentive_price_index) {
                    v0 = false;
                    continue
                } else {
                    continue
                };
            };
            v0 = false;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePoolRegistry{
            id       : 0x2::object::new(arg0),
            num_pool : 0,
        };
        0x2::transfer::share_object<StakePoolRegistry>(v0);
    }

    entry fun migrate_to_staked_tlp<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        assert!(0x1::type_name::get<T0>() == v1.pool_info.stake_token, 0);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"staked_tlp"), 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()));
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

    entry fun new_stake_pool<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg3);
        assert!(arg2 > 0, 7);
        let v0 = 0x2::object::new(arg3);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0, 0x1::string::utf8(b"staked_tlp"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, vector<LpUserShare>>>(&mut v0, 0x1::string::utf8(b"lp_user_shares"), 0x2::table::new<address, vector<LpUserShare>>(arg3));
        let v1 = StakePoolInfo{
            stake_token        : 0x1::type_name::get<T0>(),
            index              : arg1.num_pool,
            next_user_share_id : 0,
            total_share        : 0,
            active             : true,
            u64_padding        : 0x1::vector::empty<u64>(),
        };
        let v2 = StakePoolConfig{
            unlock_countdown_ts_ms : arg2,
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

    public fun remove_incentive_token<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg2);
        let v3 = get_incentive_tokens(v2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v0), 3);
        let v4 = remove_incentive(v2, &v0);
        let Incentive {
            token_type : _,
            config     : _,
            info       : _,
        } = v4;
        let v8 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, v0);
        let v9 = RemoveIncentiveTokenEvent{
            sender                  : 0x2::tx_context::sender(arg3),
            index                   : arg2,
            incentive_token         : v0,
            incentive_balance_value : 0x2::balance::value<T0>(&v8),
            u64_padding             : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RemoveIncentiveTokenEvent>(v9);
        0x2::coin::from_balance<T0>(v8, arg3)
    }

    fun remove_user_share_by_id(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64) : LpUserShare {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, vector<LpUserShare>>>(arg0, 0x1::string::utf8(b"lp_user_shares"));
        let v1 = 0x2::table::borrow_mut<address, vector<LpUserShare>>(v0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::length<LpUserShare>(v1);
        while (v2 < v3) {
            if (0x1::vector::borrow<LpUserShare>(v1, v2).user_share_id == arg2) {
                break
            };
            v2 = v2 + 1;
        };
        assert!(v2 < v3, 1);
        if (0x1::vector::length<LpUserShare>(v1) == 0) {
            0x1::vector::destroy_empty<LpUserShare>(0x2::table::remove<address, vector<LpUserShare>>(v0, arg1));
        };
        0x1::vector::remove<LpUserShare>(v1, v2)
    }

    public fun snapshot(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg4);
        let v3 = *0x1::vector::borrow<u64>(&v2.pool_info.u64_padding, 0);
        let v4 = &mut v2.id;
        let v5 = remove_user_share_by_id(v4, 0x2::tx_context::sender(arg7), arg5);
        if (0x1::vector::length<u64>(&v5.u64_padding) == 0) {
            let v6 = 0x1::vector::empty<u64>();
            let v7 = &mut v6;
            0x1::vector::push_back<u64>(v7, v5.stake_ts_ms);
            0x1::vector::push_back<u64>(v7, v3);
            v5.u64_padding = v6;
        };
        let v8 = v5.active_shares;
        let v9 = *0x1::vector::borrow<u64>(&v5.u64_padding, 0);
        let v10 = *0x1::vector::borrow<u64>(&v5.u64_padding, 1);
        let v11 = 0x2::clock::timestamp_ms(arg6);
        let v12 = *0x1::vector::borrow<u64>(&v2.pool_info.u64_padding, 1);
        let v13 = (((v8 as u256) * (v10 as u256) * (((v11 - v9) / 60000) as u256) / (multiplier(13) as u256) / ((60 * v12) as u256)) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v5.u64_padding, 0) = v11;
        *0x1::vector::borrow_mut<u64>(&mut v5.u64_padding, 1) = v3;
        let v14 = &mut v2.id;
        store_user_shares(v14, v0, 0x1::vector::singleton<LpUserShare>(v5));
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::add_tails_exp_amount(arg0, arg2, arg3, v0, v13);
        let v15 = 0x1::vector::empty<u64>();
        let v16 = &mut v15;
        0x1::vector::push_back<u64>(v16, v3);
        0x1::vector::push_back<u64>(v16, v12);
        let v17 = SnapshotEvent{
            sender        : 0x2::tx_context::sender(arg7),
            index         : arg4,
            user_share_id : arg5,
            shares        : v8,
            tlp_price     : v10,
            last_ts_ms    : v9,
            current_ts_ms : v11,
            exp           : v13,
            u64_padding   : v15,
        };
        0x2::event::emit<SnapshotEvent>(v17);
    }

    public fun stake<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg1.id;
        let v2 = get_mut_stake_pool(v1, arg2);
        let v3 = 0x1::type_name::get<T0>();
        assert!(v3 == v2.pool_info.stake_token, 0);
        let v4 = 0x2::coin::into_balance<T0>(arg3);
        let v5 = 0x2::balance::value<T0>(&v4);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::string::utf8(b"staked_tlp")), v4);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        let v7 = if (0x1::option::is_some<u64>(&arg4)) {
            let v8 = &mut v2.id;
            let v9 = remove_user_share_by_id(v8, 0x2::tx_context::sender(arg6), *0x1::option::borrow<u64>(&arg4));
            assert!(v0 == v9.user, 5);
            assert!(harvest_progress_updated(v2, &v9), 8);
            v9.stake_ts_ms = v6;
            assert!(*0x1::vector::borrow<u64>(&v9.u64_padding, 0) == v6, 10);
            v9.total_shares = v9.total_shares + v5;
            v9.active_shares = v9.active_shares + v5;
            v9.last_incentive_price_index = get_last_incentive_price_index(v2);
            v9
        } else {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = &mut v10;
            0x1::vector::push_back<u64>(v11, v6);
            0x1::vector::push_back<u64>(v11, *0x1::vector::borrow<u64>(&v2.pool_info.u64_padding, 0));
            let v12 = LpUserShare{
                user                       : v0,
                user_share_id              : v2.pool_info.next_user_share_id,
                stake_ts_ms                : v6,
                total_shares               : v5,
                active_shares              : v5,
                deactivating_shares        : 0x1::vector::empty<DeactivatingShares>(),
                last_incentive_price_index : get_last_incentive_price_index(v2),
                u64_padding                : v10,
            };
            v2.pool_info.next_user_share_id = v2.pool_info.next_user_share_id + 1;
            v12
        };
        let v13 = v7;
        let v14 = StakeEvent{
            sender                     : 0x2::tx_context::sender(arg6),
            index                      : arg2,
            lp_token_type              : v3,
            stake_amount               : v13.total_shares,
            user_share_id              : v13.user_share_id,
            stake_ts_ms                : v13.stake_ts_ms,
            last_incentive_price_index : v13.last_incentive_price_index,
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<StakeEvent>(v14);
        let v15 = &mut v2.id;
        store_user_shares(v15, v0, 0x1::vector::singleton<LpUserShare>(v13));
        v2.pool_info.total_share = v2.pool_info.total_share + v5;
    }

    fun store_user_shares(arg0: &mut 0x2::object::UID, arg1: address, arg2: vector<LpUserShare>) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, vector<LpUserShare>>>(arg0, 0x1::string::utf8(b"lp_user_shares"));
        if (!0x2::table::contains<address, vector<LpUserShare>>(v0, arg1)) {
            0x2::table::add<address, vector<LpUserShare>>(v0, arg1, 0x1::vector::empty<LpUserShare>());
        };
        0x1::vector::append<LpUserShare>(0x2::table::borrow_mut<address, vector<LpUserShare>>(v0, arg1), arg2);
    }

    public fun unstake<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
        assert!(v2 == v1.pool_info.stake_token, 0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = &mut v1.id;
        let v5 = remove_user_share_by_id(v4, 0x2::tx_context::sender(arg5), arg3);
        assert!(harvest_progress_updated(v1, &v5), 8);
        let v6 = 0;
        let v7 = 0;
        while (v6 < 0x1::vector::length<DeactivatingShares>(&v5.deactivating_shares)) {
            if (0x1::vector::borrow<DeactivatingShares>(&v5.deactivating_shares, v6).unlocked_ts_ms <= v3) {
                let DeactivatingShares {
                    shares                             : v8,
                    unsubscribed_ts_ms                 : _,
                    unlocked_ts_ms                     : _,
                    unsubscribed_incentive_price_index : _,
                    u64_padding                        : _,
                } = 0x1::vector::remove<DeactivatingShares>(&mut v5.deactivating_shares, v6);
                v7 = v7 + v8;
                continue
            };
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u64>(&v5.u64_padding, 0) == v3, 10);
        v5.total_shares = v5.total_shares - v7;
        let v13 = if (0x1::vector::length<DeactivatingShares>(&v5.deactivating_shares) == 0) {
            if (v5.total_shares == 0) {
                v5.active_shares == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            let LpUserShare {
                user                       : _,
                user_share_id              : _,
                stake_ts_ms                : _,
                total_shares               : _,
                active_shares              : _,
                deactivating_shares        : v19,
                last_incentive_price_index : _,
                u64_padding                : _,
            } = v5;
            0x1::vector::destroy_empty<DeactivatingShares>(v19);
        } else {
            let v22 = &mut v1.id;
            store_user_shares(v22, v5.user, 0x1::vector::singleton<LpUserShare>(v5));
        };
        let v23 = UnstakeEvent{
            sender         : 0x2::tx_context::sender(arg5),
            index          : arg2,
            lp_token_type  : v2,
            user_share_id  : arg3,
            unstake_amount : v7,
            unstake_ts_ms  : v3,
            u64_padding    : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnstakeEvent>(v23);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"staked_tlp")), v7), arg5)
    }

    public fun unsubscribe<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::version_check(arg0);
        allocate_incentive(arg0, arg1, arg2, arg5);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
        assert!(v2 == v1.pool_info.stake_token, 0);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = &mut v1.id;
        let v5 = remove_user_share_by_id(v4, 0x2::tx_context::sender(arg6), arg3);
        let v6 = if (0x1::option::is_some<u64>(&arg4)) {
            0x1::option::extract<u64>(&mut arg4)
        } else {
            v5.active_shares
        };
        assert!(v5.active_shares >= v6, 6);
        assert!(*0x1::vector::borrow<u64>(&v5.u64_padding, 0) == v3, 10);
        v5.active_shares = v5.active_shares - v6;
        let v7 = v3 + v1.config.unlock_countdown_ts_ms;
        let v8 = DeactivatingShares{
            shares                             : v6,
            unsubscribed_ts_ms                 : v3,
            unlocked_ts_ms                     : v7,
            unsubscribed_incentive_price_index : get_last_incentive_price_index(v1),
            u64_padding                        : 0x1::vector::empty<u64>(),
        };
        0x1::vector::push_back<DeactivatingShares>(&mut v5.deactivating_shares, v8);
        let v9 = &mut v1.id;
        store_user_shares(v9, v5.user, 0x1::vector::singleton<LpUserShare>(v5));
        v1.pool_info.total_share = v1.pool_info.total_share - v6;
        let v10 = UnsubscribeEvent{
            sender              : 0x2::tx_context::sender(arg6),
            index               : arg2,
            lp_token_type       : v2,
            user_share_id       : arg3,
            unsubscribed_shares : v6,
            unsubscribe_ts_ms   : v3,
            unlocked_ts_ms      : v7,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnsubscribeEvent>(v10);
    }

    entry fun update_incentive_config<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<vector<u64>>, arg7: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg7);
        allocate_incentive(arg0, arg1, arg2, arg3);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
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

    entry fun update_pool_info_u64_padding(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg5);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, arg4);
        v1.pool_info.u64_padding = v2;
        let v4 = UpdatePoolInfoU64PaddingEvent{
            sender      : 0x2::tx_context::sender(arg5),
            index       : arg2,
            u64_padding : v1.pool_info.u64_padding,
        };
        0x2::event::emit<UpdatePoolInfoU64PaddingEvent>(v4);
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg4);
        assert!(arg3 > 0, 7);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
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

    public fun withdraw_incentive<T0>(arg0: &0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::Version, arg1: &mut StakePoolRegistry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin::verify(arg0, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_stake_pool(v0, arg2);
        let v2 = 0x1::type_name::get<T0>();
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
            sender               : 0x2::tx_context::sender(arg4),
            index                : arg2,
            incentive_token_type : v2,
            withdrawal_amount    : v5,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<WithdrawIncentiveEvent>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v2), v5), arg4)
    }

    // decompiled from Move bytecode v6
}

