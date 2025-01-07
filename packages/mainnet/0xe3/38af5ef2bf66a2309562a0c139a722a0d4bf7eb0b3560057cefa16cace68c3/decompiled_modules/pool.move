module 0xe338af5ef2bf66a2309562a0c139a722a0d4bf7eb0b3560057cefa16cace68c3::pool {
    struct PoolManager has store, key {
        id: 0x2::object::UID,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        pool_info: PoolInfo,
        config: PoolConfig,
        incentives: vector<Incentive>,
    }

    struct Incentive has store {
        id: 0x2::object::UID,
        token_type: 0x1::type_name::TypeName,
        config: IncentiveConfig,
        info: IncentiveInfo,
    }

    struct PoolInfo has copy, drop, store {
        stake_token: 0x1::type_name::TypeName,
        total_share: u64,
        active: bool,
        next_incentive_id: u64,
    }

    struct PoolConfig has copy, drop, store {
        unlock_countdown_ts_ms: u64,
    }

    struct IncentiveConfig has copy, drop, store {
        period_incentive_amount: u64,
        incentive_interval_ts_ms: u64,
    }

    struct IncentiveInfo has copy, drop, store {
        incentive_id: u64,
        active: bool,
        last_allocate_ts_ms: u64,
        incentive_price_index: u64,
    }

    struct LpUserShare has store {
        user: address,
        stake_ts_ms: u64,
        total_shares: u64,
        active_shares: u64,
        deactivating_shares: vector<DeactivatingShares>,
        last_incentive_price_index: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct DeactivatingShares has store {
        shares: u64,
        unsubscribed_ts_ms: u64,
        unlocked_ts_ms: u64,
        unsubscribed_incentive_price_index: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct NewPoolEvent has copy, drop {
        sender: address,
        pool_info: PoolInfo,
        pool_config: PoolConfig,
    }

    struct CreateIncentiveProgramEvent has copy, drop {
        pool_address: address,
        incentive_token: 0x1::type_name::TypeName,
        incentive_info: IncentiveInfo,
        incentive_config: IncentiveConfig,
    }

    struct DeactivateIncentiveProgramEvent has copy, drop {
        pool_address: address,
        sender: address,
        incentive_program_idx: u64,
        incentive_token: 0x1::type_name::TypeName,
    }

    struct ActivateIncentiveTokenEvent has copy, drop {
        pool_address: address,
        incentive_program_idx: u64,
        incentive_token: 0x1::type_name::TypeName,
    }

    struct RemoveIncentiveProgramEvent has copy, drop {
        pool_address: address,
        incentive_program_idx: u64,
        incentive_token: 0x1::type_name::TypeName,
        incentive_balance_value: u64,
    }

    struct UpdateUnlockCountdownTsMsEvent has copy, drop {
        pool_address: address,
        previous_unlock_countdown_ts_ms: u64,
        new_unlock_countdown_ts_ms: u64,
    }

    struct UpdateIncentiveConfigEvent has copy, drop {
        pool_address: address,
        previous_incentive_config: IncentiveConfig,
        new_incentive_config: IncentiveConfig,
    }

    struct StakeEvent has copy, drop {
        pool_address: address,
        token_type: 0x1::type_name::TypeName,
        stake_amount: u64,
        stake_ts_ms: u64,
        last_incentive_price_index: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct UnsubscribeEvent has copy, drop {
        pool_address: address,
        token_type: 0x1::type_name::TypeName,
        unsubscribed_shares: u64,
        unsubscribe_ts_ms: u64,
        unlocked_ts_ms: u64,
    }

    struct UnstakeEvent has copy, drop {
        pool_address: address,
        token_type: 0x1::type_name::TypeName,
        unstake_amount: u64,
        unstake_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct HarvestEvent has copy, drop {
        pool_address: address,
        incentive_token_type: 0x1::type_name::TypeName,
        harvest_amount: u64,
    }

    entry fun activate_incentive_token<T0>(arg0: &PoolManager, arg1: &mut Pool, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::borrow_mut<Incentive>(&mut arg1.incentives, arg2);
        assert!(v1.token_type == v0, 0);
        assert!(!v1.info.active, 7);
        v1.info.active = true;
        let v2 = ActivateIncentiveTokenEvent{
            pool_address          : 0x2::object::id_address<Pool>(arg1),
            incentive_program_idx : arg2,
            incentive_token       : v0,
        };
        0x2::event::emit<ActivateIncentiveTokenEvent>(v2);
    }

    public(friend) fun allocate_incentive(arg0: &mut Pool, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            let v1 = 0x1::vector::borrow_mut<Incentive>(&mut arg0.incentives, v0);
            if (v1.info.active) {
                let v2 = v1.info.last_allocate_ts_ms;
                let v3 = 0x2::clock::timestamp_ms(arg1) / v1.config.incentive_interval_ts_ms * v1.config.incentive_interval_ts_ms;
                if (v3 > v2) {
                    let v4 = if (arg0.pool_info.total_share > 0) {
                        (((multiplier(9) as u128) * ((((v1.config.period_incentive_amount as u128) * ((v3 - v2) as u128) / (v1.config.incentive_interval_ts_ms as u128)) as u64) as u128) / (arg0.pool_info.total_share as u128)) as u64)
                    } else {
                        0
                    };
                    v1.info.incentive_price_index = v1.info.incentive_price_index + v4;
                    v1.info.last_allocate_ts_ms = v3;
                };
            };
            v0 = v0 + 1;
        };
    }

    fun calculate_incentive(arg0: &Pool, arg1: u64, arg2: &LpUserShare) : (u64, u64) {
        let v0 = 0x1::vector::borrow<Incentive>(&arg0.incentives, arg1).info.incentive_price_index;
        let v1 = if (0x2::vec_map::contains<u64, u64>(&arg2.last_incentive_price_index, &arg1)) {
            *0x2::vec_map::get<u64, u64>(&arg2.last_incentive_price_index, &arg1)
        } else {
            0
        };
        let v2 = 0 + (((arg2.active_shares as u128) * ((v0 - v1) as u128) / (multiplier(9) as u128)) as u64);
        let v3 = 0;
        while (v3 < 0x1::vector::length<DeactivatingShares>(&arg2.deactivating_shares)) {
            let v4 = 0x1::vector::borrow<DeactivatingShares>(&arg2.deactivating_shares, v3);
            if (0x2::vec_map::contains<u64, u64>(&v4.unsubscribed_incentive_price_index, &arg1)) {
                let v5 = *0x2::vec_map::get<u64, u64>(&v4.unsubscribed_incentive_price_index, &arg1);
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

    entry fun create_incentive_program<T0>(arg0: &PoolManager, arg1: &mut Pool, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 9);
        assert!(arg3 > 0, 10);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = IncentiveConfig{
            period_incentive_amount  : arg3,
            incentive_interval_ts_ms : arg4,
        };
        let v2 = IncentiveInfo{
            incentive_id          : arg1.pool_info.next_incentive_id,
            active                : true,
            last_allocate_ts_ms   : 0x2::clock::timestamp_ms(arg5),
            incentive_price_index : 0,
        };
        let v3 = Incentive{
            id         : 0x2::object::new(arg6),
            token_type : v0,
            config     : v1,
            info       : v2,
        };
        let v4 = CreateIncentiveProgramEvent{
            pool_address     : 0x2::object::id_address<Pool>(arg1),
            incentive_token  : v3.token_type,
            incentive_info   : v3.info,
            incentive_config : v3.config,
        };
        0x2::event::emit<CreateIncentiveProgramEvent>(v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.id, v0, 0x2::coin::into_balance<T0>(arg2));
        0x1::vector::push_back<Incentive>(&mut arg1.incentives, v3);
        arg1.pool_info.next_incentive_id = arg1.pool_info.next_incentive_id + 1;
    }

    public(friend) fun create_user_last_incentive_ts_ms(arg0: &Pool, arg1: u64) : 0x2::vec_map::VecMap<u64, u64> {
        let v0 = &arg0.incentives;
        let v1 = 0x2::vec_map::empty<u64, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Incentive>(v0)) {
            0x2::vec_map::insert<u64, u64>(&mut v1, 0x1::vector::borrow<Incentive>(v0, v2).info.incentive_id, arg1);
            v2 = v2 + 1;
        };
        v1
    }

    entry fun deactivate_incentive_program<T0>(arg0: &PoolManager, arg1: &mut Pool, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::borrow_mut<Incentive>(&mut arg1.incentives, arg2);
        assert!(v1.token_type == v0, 0);
        assert!(v1.info.active, 6);
        v1.info.active = false;
        let v2 = DeactivateIncentiveProgramEvent{
            pool_address          : 0x2::object::id_address<Pool>(arg1),
            sender                : 0x2::tx_context::sender(arg3),
            incentive_program_idx : arg2,
            incentive_token       : v0,
        };
        0x2::event::emit<DeactivateIncentiveProgramEvent>(v2);
    }

    public(friend) fun get_incentive_tokens(arg0: &Pool) : vector<0x1::type_name::TypeName> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (v0 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::vector::borrow<Incentive>(&arg0.incentives, v0).token_type);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun get_last_incentive_price_index(arg0: &Pool) : 0x2::vec_map::VecMap<u64, u64> {
        let v0 = &arg0.incentives;
        let v1 = 0x2::vec_map::empty<u64, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Incentive>(v0)) {
            let v3 = 0x1::vector::borrow<Incentive>(v0, v2);
            0x2::vec_map::insert<u64, u64>(&mut v1, v3.info.incentive_id, v3.info.incentive_price_index);
            v2 = v2 + 1;
        };
        v1
    }

    public fun harvest<T0>(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::type_name::get<T0>();
        allocate_incentive(arg0, arg1);
        let v2 = &mut arg0.id;
        let v3 = remove_user_share(v2, v0);
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<Incentive>(&arg0.incentives)) {
            let v6 = 0x1::vector::borrow<Incentive>(&arg0.incentives, v5).info.incentive_id;
            if (0x1::vector::borrow<Incentive>(&arg0.incentives, v5).token_type == v1) {
                let (v7, v8) = calculate_incentive(arg0, v6, &v3);
                if (0x2::vec_map::contains<u64, u64>(&v3.last_incentive_price_index, &v6)) {
                    *0x2::vec_map::get_mut<u64, u64>(&mut v3.last_incentive_price_index, &v6) = v8;
                } else {
                    0x2::vec_map::insert<u64, u64>(&mut v3.last_incentive_price_index, v6, v8);
                };
                let v9 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&0x1::vector::borrow<Incentive>(&arg0.incentives, v5).id, v1));
                let v10 = if (v7 > v9) {
                    v9
                } else {
                    v7
                };
                0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut 0x1::vector::borrow_mut<Incentive>(&mut arg0.incentives, v5).id, v1), v10));
            };
            v5 = v5 + 1;
        };
        let v11 = HarvestEvent{
            pool_address         : 0x2::object::id_address<Pool>(arg0),
            incentive_token_type : v1,
            harvest_amount       : 0x2::balance::value<T0>(&v4),
        };
        0x2::event::emit<HarvestEvent>(v11);
        let v12 = &mut arg0.id;
        store_user_shares(v12, v0, v3);
        0x2::coin::from_balance<T0>(v4, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManager{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PoolManager>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun multiplier(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    entry fun new_pool<T0>(arg0: &PoolManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x1::type_name::get<T0>();
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, LpUserShare>>(&mut v0, 0x1::string::utf8(b"lp_user_shares"), 0x2::table::new<address, LpUserShare>(arg2));
        let v2 = PoolInfo{
            stake_token       : v1,
            total_share       : 0,
            active            : true,
            next_incentive_id : 0,
        };
        let v3 = PoolConfig{unlock_countdown_ts_ms: arg1};
        let v4 = Pool{
            id         : v0,
            pool_info  : v2,
            config     : v3,
            incentives : 0x1::vector::empty<Incentive>(),
        };
        let v5 = NewPoolEvent{
            sender      : 0x2::tx_context::sender(arg2),
            pool_info   : v4.pool_info,
            pool_config : v4.config,
        };
        0x2::event::emit<NewPoolEvent>(v5);
        0x2::transfer::share_object<Pool>(v4);
    }

    public fun remove_incentive_program<T0>(arg0: &PoolManager, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::remove<Incentive>(&mut arg1.incentives, arg2);
        assert!(v1.token_type == v0, 0);
        let Incentive {
            id         : v2,
            token_type : _,
            config     : _,
            info       : _,
        } = v1;
        let v6 = v2;
        let v7 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v6, v0);
        0x2::object::delete(v6);
        let v8 = RemoveIncentiveProgramEvent{
            pool_address            : 0x2::object::id_address<Pool>(arg1),
            incentive_program_idx   : arg2,
            incentive_token         : v0,
            incentive_balance_value : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<RemoveIncentiveProgramEvent>(v8);
        0x2::coin::from_balance<T0>(v7, arg3)
    }

    fun remove_user_share(arg0: &mut 0x2::object::UID, arg1: address) : LpUserShare {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, LpUserShare>>(arg0, 0x1::string::utf8(b"lp_user_shares"));
        assert!(0x2::table::contains<address, LpUserShare>(v0, arg1), 1);
        0x2::table::remove<address, LpUserShare>(v0, arg1)
    }

    public fun stake<T0>(arg0: &mut Pool, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v1 == arg0.pool_info.stake_token, 0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 11);
        allocate_incentive(arg0, arg2);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::balance::value<T0>(&v2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), v2);
        let v4 = if (0x2::table::contains<address, LpUserShare>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, LpUserShare>>(&arg0.id, 0x1::string::utf8(b"lp_user_shares")), v0)) {
            let v5 = &mut arg0.id;
            let v6 = remove_user_share(v5, 0x2::tx_context::sender(arg3));
            assert!(v0 == v6.user, 3);
            v6.stake_ts_ms = 0x2::clock::timestamp_ms(arg2);
            v6.total_shares = v6.total_shares + v3;
            v6.active_shares = v6.active_shares + v3;
            v6.last_incentive_price_index = get_last_incentive_price_index(arg0);
            v6
        } else {
            LpUserShare{user: v0, stake_ts_ms: 0x2::clock::timestamp_ms(arg2), total_shares: v3, active_shares: v3, deactivating_shares: 0x1::vector::empty<DeactivatingShares>(), last_incentive_price_index: get_last_incentive_price_index(arg0)}
        };
        let v7 = v4;
        let v8 = StakeEvent{
            pool_address               : 0x2::object::id_address<Pool>(arg0),
            token_type                 : v1,
            stake_amount               : v7.total_shares,
            stake_ts_ms                : v7.stake_ts_ms,
            last_incentive_price_index : v7.last_incentive_price_index,
        };
        0x2::event::emit<StakeEvent>(v8);
        let v9 = &mut arg0.id;
        store_user_shares(v9, v0, v7);
        arg0.pool_info.total_share = arg0.pool_info.total_share + v3;
    }

    fun store_user_shares(arg0: &mut 0x2::object::UID, arg1: address, arg2: LpUserShare) {
        0x2::table::add<address, LpUserShare>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, LpUserShare>>(arg0, 0x1::string::utf8(b"lp_user_shares")), arg1, arg2);
    }

    public fun unstake<T0>(arg0: &mut Pool, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == arg0.pool_info.stake_token, 0);
        allocate_incentive(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = &mut arg0.id;
        let v3 = remove_user_share(v2, 0x2::tx_context::sender(arg3));
        let v4 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::extract<u64>(&mut arg1)
        } else {
            v3.total_shares - v3.active_shares
        };
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x1::vector::length<DeactivatingShares>(&v3.deactivating_shares)) {
            if (v6 == v4) {
                break
            };
            let v7 = 0x1::vector::borrow<DeactivatingShares>(&v3.deactivating_shares, 0);
            assert!(v7.unlocked_ts_ms <= v1, 2);
            if (v4 >= v6 + v7.shares) {
                let DeactivatingShares {
                    shares                             : v8,
                    unsubscribed_ts_ms                 : _,
                    unlocked_ts_ms                     : _,
                    unsubscribed_incentive_price_index : _,
                } = 0x1::vector::remove<DeactivatingShares>(&mut v3.deactivating_shares, 0);
                v6 = v6 + v8;
            } else {
                let v12 = v4 - v6;
                v6 = v6 + v12;
                let v13 = 0x1::vector::borrow_mut<DeactivatingShares>(&mut v3.deactivating_shares, 0);
                v13.shares = v13.shares - v12;
            };
            v5 = v5 + 1;
        };
        v3.total_shares = v3.total_shares - v6;
        let v14 = if (0x1::vector::length<DeactivatingShares>(&v3.deactivating_shares) == 0) {
            if (v3.total_shares == 0) {
                v3.active_shares == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v14) {
            let LpUserShare {
                user                       : _,
                stake_ts_ms                : _,
                total_shares               : _,
                active_shares              : _,
                deactivating_shares        : v19,
                last_incentive_price_index : _,
            } = v3;
            0x1::vector::destroy_empty<DeactivatingShares>(v19);
        } else {
            let v21 = &mut arg0.id;
            store_user_shares(v21, v3.user, v3);
        };
        let v22 = UnstakeEvent{
            pool_address   : 0x2::object::id_address<Pool>(arg0),
            token_type     : v0,
            unstake_amount : v6,
            unstake_ts_ms  : v1,
            u64_padding    : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnstakeEvent>(v22);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), v6), arg3)
    }

    public fun unsubscribe<T0>(arg0: &mut Pool, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == arg0.pool_info.stake_token, 0);
        allocate_incentive(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = &mut arg0.id;
        let v3 = remove_user_share(v2, 0x2::tx_context::sender(arg3));
        let v4 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::extract<u64>(&mut arg1)
        } else {
            v3.active_shares
        };
        assert!(v3.active_shares >= v4, 4);
        v3.active_shares = v3.active_shares - v4;
        let v5 = v1 + arg0.config.unlock_countdown_ts_ms;
        let v6 = DeactivatingShares{
            shares                             : v4,
            unsubscribed_ts_ms                 : v1,
            unlocked_ts_ms                     : v5,
            unsubscribed_incentive_price_index : get_last_incentive_price_index(arg0),
        };
        0x1::vector::push_back<DeactivatingShares>(&mut v3.deactivating_shares, v6);
        let v7 = &mut arg0.id;
        store_user_shares(v7, v3.user, v3);
        arg0.pool_info.total_share = arg0.pool_info.total_share - v4;
        let v8 = UnsubscribeEvent{
            pool_address        : 0x2::object::id_address<Pool>(arg0),
            token_type          : v0,
            unsubscribed_shares : v4,
            unsubscribe_ts_ms   : v1,
            unlocked_ts_ms      : v5,
        };
        0x2::event::emit<UnsubscribeEvent>(v8);
    }

    entry fun update_incentive_config(arg0: &PoolManager, arg1: &mut Pool, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) {
        let v0 = 0x1::vector::borrow_mut<Incentive>(&mut arg1.incentives, arg2);
        if (0x1::option::is_some<u64>(&arg3)) {
            v0.config.period_incentive_amount = 0x1::option::extract<u64>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v0.config.incentive_interval_ts_ms = 0x1::option::extract<u64>(&mut arg4);
        };
        let v1 = UpdateIncentiveConfigEvent{
            pool_address              : 0x2::object::id_address<Pool>(arg1),
            previous_incentive_config : v0.config,
            new_incentive_config      : v0.config,
        };
        0x2::event::emit<UpdateIncentiveConfigEvent>(v1);
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &PoolManager, arg1: &mut Pool, arg2: u64) {
        assert!(arg2 > 0, 5);
        arg1.config.unlock_countdown_ts_ms = arg2;
        let v0 = UpdateUnlockCountdownTsMsEvent{
            pool_address                    : 0x2::object::id_address<Pool>(arg1),
            previous_unlock_countdown_ts_ms : arg1.config.unlock_countdown_ts_ms,
            new_unlock_countdown_ts_ms      : arg2,
        };
        0x2::event::emit<UpdateUnlockCountdownTsMsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

