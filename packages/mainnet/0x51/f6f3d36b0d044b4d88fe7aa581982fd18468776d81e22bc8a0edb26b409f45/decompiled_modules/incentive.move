module 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive {
    struct IncentiveBal<phantom T0> has store, key {
        id: 0x2::object::UID,
        asset: u8,
        current_idx: u64,
        distributed_amount: u256,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PoolInfo has store {
        id: u8,
        last_update_time: u64,
        coin_types: vector<0x1::ascii::String>,
        start_times: vector<u64>,
        end_times: vector<u64>,
        total_supplys: vector<u256>,
        rates: vector<u256>,
        index_rewards: vector<u256>,
        index_rewards_paids: vector<0x2::table::Table<address, u256>>,
        user_acc_rewards: vector<0x2::table::Table<address, u256>>,
        user_acc_rewards_paids: vector<0x2::table::Table<address, u256>>,
        oracle_ids: vector<u8>,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        creator: address,
        owners: 0x2::table::Table<u256, bool>,
        admins: 0x2::table::Table<u256, bool>,
        pools: 0x2::table::Table<u8, PoolInfo>,
        assets: vector<u8>,
    }

    struct PoolOwnerSetting has copy, drop {
        sender: address,
        owner: u256,
        value: bool,
    }

    struct PoolAdminSetting has copy, drop {
        sender: address,
        admin: u256,
        value: bool,
    }

    struct IncentiveOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct IncentiveAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_pool<T0>(arg0: &mut Incentive, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg8), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::not_owner());
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1) && arg4 > arg3, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_duration_time());
        if (!0x2::table::contains<u8, PoolInfo>(&arg0.pools, arg2)) {
            let v0 = PoolInfo{
                id                     : arg2,
                last_update_time       : 0,
                coin_types             : 0x1::vector::empty<0x1::ascii::String>(),
                start_times            : 0x1::vector::empty<u64>(),
                end_times              : 0x1::vector::empty<u64>(),
                total_supplys          : 0x1::vector::empty<u256>(),
                rates                  : 0x1::vector::empty<u256>(),
                index_rewards          : 0x1::vector::empty<u256>(),
                index_rewards_paids    : 0x1::vector::empty<0x2::table::Table<address, u256>>(),
                user_acc_rewards       : 0x1::vector::empty<0x2::table::Table<address, u256>>(),
                user_acc_rewards_paids : 0x1::vector::empty<0x2::table::Table<address, u256>>(),
                oracle_ids             : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<u8, PoolInfo>(&mut arg0.pools, arg2, v0);
            0x1::vector::push_back<u8>(&mut arg0.assets, arg2);
        };
        let v1 = 0x2::table::borrow_mut<u8, PoolInfo>(&mut arg0.pools, arg2);
        0x1::vector::push_back<0x1::ascii::String>(&mut v1.coin_types, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::vector::push_back<u64>(&mut v1.start_times, arg3);
        0x1::vector::push_back<u64>(&mut v1.end_times, arg4);
        0x1::vector::push_back<u256>(&mut v1.total_supplys, (arg6 as u256));
        0x1::vector::push_back<u256>(&mut v1.rates, 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_div((arg6 as u256), ((arg4 - arg3) as u256)));
        0x1::vector::push_back<u256>(&mut v1.index_rewards, 0);
        0x1::vector::push_back<0x2::table::Table<address, u256>>(&mut v1.index_rewards_paids, 0x2::table::new<address, u256>(arg8));
        0x1::vector::push_back<0x2::table::Table<address, u256>>(&mut v1.user_acc_rewards, 0x2::table::new<address, u256>(arg8));
        0x1::vector::push_back<0x2::table::Table<address, u256>>(&mut v1.user_acc_rewards_paids, 0x2::table::new<address, u256>(arg8));
        0x1::vector::push_back<u8>(&mut v1.oracle_ids, arg7);
        let v2 = IncentiveBal<T0>{
            id                 : 0x2::object::new(arg8),
            asset              : arg2,
            current_idx        : 0x1::vector::length<0x1::ascii::String>(&v1.coin_types),
            distributed_amount : 0,
            balance            : 0xe2b200837712c83938bf67d8d712bbcdac9222faa1fe04cf262fd20f45ce5251::utils::split_coin_to_balance<T0>(arg5, arg6, arg8),
        };
        0x2::transfer::share_object<IncentiveBal<T0>>(v2);
    }

    fun base_claim_reward<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg4: address) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg2, arg3, arg1.asset, arg4);
        let v0 = 0x2::table::borrow_mut<u8, PoolInfo>(&mut arg0.pools, arg1.asset);
        let v1 = arg1.current_idx;
        let v2 = 0;
        let v3 = 0x1::vector::borrow<0x2::table::Table<address, u256>>(&v0.user_acc_rewards, v1);
        if (0x2::table::contains<address, u256>(v3, arg4)) {
            v2 = *0x2::table::borrow<address, u256>(v3, arg4);
        };
        let v4 = 0;
        let v5 = 0x1::vector::borrow_mut<0x2::table::Table<address, u256>>(&mut v0.user_acc_rewards_paids, v1);
        if (0x2::table::contains<address, u256>(v5, arg4)) {
            v4 = 0x2::table::remove<address, u256>(v5, arg4);
        };
        0x2::table::add<address, u256>(v5, arg4, v2);
        let v6 = (v2 - v4) / 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray();
        assert!(arg1.distributed_amount + v6 <= *0x1::vector::borrow<u256>(&v0.total_supplys, v1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::insufficient_balance());
        arg1.distributed_amount = arg1.distributed_amount + v6;
        0x2::balance::split<T0>(&mut arg1.balance, (v6 as u64))
    }

    fun calc_pool_update_rewards(arg0: &Incentive, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg2: u64, arg3: u8, arg4: address) : (vector<u256>, vector<u256>) {
        let v0 = 0x2::table::borrow<u8, PoolInfo>(&arg0.pools, arg3);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0x1::vector::empty<u256>();
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&v0.coin_types)) {
            let v4 = *0x1::vector::borrow<u64>(&v0.start_times, v1);
            let v5 = v4;
            if (v4 < v0.last_update_time) {
                v5 = v0.last_update_time;
            };
            let v6 = *0x1::vector::borrow<u64>(&v0.end_times, v1);
            let v7 = v6;
            if (arg2 < v6) {
                v7 = arg2;
            };
            let v8 = *0x1::vector::borrow<u256>(&v0.index_rewards, v1);
            let v9 = v8;
            if (v5 < v7) {
                let (v10, _) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_total_supply(arg1, arg3);
                let v12 = 0;
                if (v10 > 0) {
                    v12 = 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::safe_math::mul(*0x1::vector::borrow<u256>(&v0.rates, v1), ((v7 - v5) as u256)) / v10;
                };
                v9 = v8 + v12;
            };
            0x1::vector::push_back<u256>(&mut v2, v9);
            let v13 = 0;
            if (arg4 != @0x0) {
                let v14 = 0x1::vector::borrow<0x2::table::Table<address, u256>>(&v0.user_acc_rewards, v1);
                if (0x2::table::contains<address, u256>(v14, arg4)) {
                    v13 = *0x2::table::borrow<address, u256>(v14, arg4);
                };
                let v15 = 0;
                let v16 = 0x1::vector::borrow<0x2::table::Table<address, u256>>(&v0.index_rewards_paids, v1);
                if (0x2::table::contains<address, u256>(v16, arg4)) {
                    v15 = *0x2::table::borrow<address, u256>(v16, arg4);
                };
                let (v17, _) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_user_balance(arg1, arg3, arg4);
                v13 = v13 + (v9 - v15) * v17;
            };
            0x1::vector::push_back<u256>(&mut v3, v13);
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public entry fun claim_reward<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = base_claim_reward<T0>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), arg4);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun claim_reward_non_entry<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_claim_reward<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4))
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg4: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_claim_reward<T0>(arg0, arg1, arg2, arg3, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::account::account_owner(arg4))
    }

    public fun create_and_transfer_ownership(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun earned(arg0: &Incentive, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg2: &0x2::clock::Clock, arg3: u8, arg4: address) : (vector<0x1::ascii::String>, vector<u256>, vector<u8>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u8>();
        if (0x2::table::contains<u8, PoolInfo>(&arg0.pools, arg3)) {
            let (_, v4) = calc_pool_update_rewards(arg0, arg1, 0x2::clock::timestamp_ms(arg2), arg3, arg4);
            let v5 = v4;
            let v6 = 0x2::table::borrow<u8, PoolInfo>(&arg0.pools, arg3);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::ascii::String>(&v6.coin_types)) {
                let v8 = 0x1::vector::borrow<0x2::table::Table<address, u256>>(&v6.user_acc_rewards_paids, v7);
                let v9 = 0;
                if (0x2::table::contains<address, u256>(v8, arg4)) {
                    v9 = *0x2::table::borrow<address, u256>(v8, arg4);
                };
                0x1::vector::push_back<0x1::ascii::String>(&mut v0, *0x1::vector::borrow<0x1::ascii::String>(&v6.coin_types, v7));
                0x1::vector::push_back<u256>(&mut v1, *0x1::vector::borrow<u256>(&v5, v7) - v9);
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v6.oracle_ids, v7));
                v7 = v7 + 1;
            };
        };
        (v0, v1, v2)
    }

    public fun get_pool_count(arg0: &Incentive, arg1: u8) : u64 {
        let v0 = 0;
        if (0x2::table::contains<u8, PoolInfo>(&arg0.pools, arg1)) {
            v0 = 0x1::vector::length<0x1::ascii::String>(&0x2::table::borrow<u8, PoolInfo>(&arg0.pools, arg1).coin_types);
        };
        v0
    }

    public fun get_pool_info(arg0: &Incentive, arg1: u8, arg2: u64) : (u64, u64, u256, u8) {
        assert!(0x2::table::contains<u8, PoolInfo>(&arg0.pools, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_pool());
        let v0 = 0x2::table::borrow<u8, PoolInfo>(&arg0.pools, arg1);
        assert!(0x1::vector::length<0x1::ascii::String>(&v0.coin_types) > arg2, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_pool());
        (*0x1::vector::borrow<u64>(&v0.start_times, arg2), *0x1::vector::borrow<u64>(&v0.end_times, arg2), *0x1::vector::borrow<u256>(&v0.rates, arg2), *0x1::vector::borrow<u8>(&v0.oracle_ids, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Incentive{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
            owners  : 0x2::table::new<u256, bool>(arg0),
            admins  : 0x2::table::new<u256, bool>(arg0),
            pools   : 0x2::table::new<u8, PoolInfo>(arg0),
            assets  : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Incentive>(v0);
    }

    public fun set_admin(arg0: &mut Incentive, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::not_owner());
        if (!0x2::table::contains<u256, bool>(&arg0.admins, arg1)) {
            0x2::table::add<u256, bool>(&mut arg0.admins, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u256, bool>(&mut arg0.admins, arg1) = arg2;
        };
        let v0 = PoolAdminSetting{
            sender : 0x2::tx_context::sender(arg3),
            admin  : arg1,
            value  : arg2,
        };
        0x2::event::emit<PoolAdminSetting>(v0);
    }

    public fun set_owner(arg0: &mut Incentive, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::not_owner());
        if (!0x2::table::contains<u256, bool>(&arg0.owners, arg1)) {
            0x2::table::add<u256, bool>(&mut arg0.owners, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u256, bool>(&mut arg0.owners, arg1) = arg2;
        };
        let v0 = PoolOwnerSetting{
            sender : 0x2::tx_context::sender(arg3),
            owner  : arg1,
            value  : arg2,
        };
        0x2::event::emit<PoolOwnerSetting>(v0);
    }

    public(friend) fun update_reward(arg0: &mut Incentive, arg1: &0x2::clock::Clock, arg2: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg3: u8, arg4: address) {
        if (0x2::table::contains<u8, PoolInfo>(&arg0.pools, arg3)) {
            let v0 = 0x2::clock::timestamp_ms(arg1);
            let (v1, v2) = calc_pool_update_rewards(arg0, arg2, v0, arg3, arg4);
            let v3 = v2;
            let v4 = v1;
            let v5 = 0x2::table::borrow_mut<u8, PoolInfo>(&mut arg0.pools, arg3);
            v5.last_update_time = v0;
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x1::ascii::String>(&v5.coin_types)) {
                let v7 = *0x1::vector::borrow<u256>(&v4, v6);
                *0x1::vector::borrow_mut<u256>(&mut v5.index_rewards, v6) = v7;
                let v8 = 0x1::vector::borrow_mut<0x2::table::Table<address, u256>>(&mut v5.index_rewards_paids, v6);
                if (0x2::table::contains<address, u256>(v8, arg4)) {
                    0x2::table::remove<address, u256>(v8, arg4);
                };
                0x2::table::add<address, u256>(v8, arg4, v7);
                let v9 = 0x1::vector::borrow_mut<0x2::table::Table<address, u256>>(&mut v5.user_acc_rewards, v6);
                if (0x2::table::contains<address, u256>(v9, arg4)) {
                    0x2::table::remove<address, u256>(v9, arg4);
                };
                0x2::table::add<address, u256>(v9, arg4, *0x1::vector::borrow<u256>(&v3, v6));
                v6 = v6 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

