module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe {
    struct Bribe<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        total_votes: u64,
        supply_checkpoints: 0x2::table_vec::TableVec<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>,
        vsdb_votes: 0x2::table::Table<0x2::object::ID, u64>,
        checkpoints: 0x2::table::Table<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>,
    }

    struct Rewards<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        rewards_type: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Reward<phantom T0, phantom T1, phantom T2> has store {
        balance: 0x2::balance::Balance<T2>,
        rewards_per_epoch: 0x2::table::Table<u64, u64>,
        last_earn: 0x2::table::Table<0x2::object::ID, u64>,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let v0 = Bribe<T0, T1>{
            id                 : 0x2::object::new(arg0),
            version            : 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(),
            total_votes        : 0,
            supply_checkpoints : 0x2::table_vec::empty<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(arg0),
            vsdb_votes         : 0x2::table::new<0x2::object::ID, u64>(arg0),
            checkpoints        : 0x2::table::new<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(arg0),
        };
        0x2::transfer::share_object<Bribe<T0, T1>>(v0);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x1::type_name::get<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>();
        let v4 = 0x1::type_name::get<0x2::sui::SUI>();
        let v5 = Rewards<T0, T1>{
            id           : 0x2::object::new(arg0),
            version      : 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(),
            rewards_type : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v6 = &mut v5;
        new_reward_<T0, T1, T0>(v6, arg0);
        let v7 = &mut v5;
        new_reward_<T0, T1, T1>(v7, arg0);
        if (v4 != v1 && v4 != v2) {
            let v8 = &mut v5;
            new_reward_<T0, T1, 0x2::sui::SUI>(v8, arg0);
        };
        if (v3 != v1 && v3 != v2) {
            let v9 = &mut v5;
            new_reward_<T0, T1, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(v9, arg0);
        };
        0x2::transfer::share_object<Rewards<T0, T1>>(v5);
        (0x2::object::id<Bribe<T0, T1>>(&v0), 0x2::object::id<Rewards<T0, T1>>(&v5))
    }

    public entry fun bribe<T0, T1, T2>(arg0: &mut Rewards<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert_rewards_type<T0, T1, T2>();
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = borrow_reward_mut<T0, T1, T2>(arg0);
        assert!(v0 > 0, 104);
        0x2::coin::put<T2>(&mut v1.balance, arg1);
        let v2 = round_down_week(unix_timestamp(arg2));
        if (0x2::table::contains<u64, u64>(&v1.rewards_per_epoch, v2)) {
            *0x2::table::borrow_mut<u64, u64>(&mut v1.rewards_per_epoch, v2) = *0x2::table::borrow<u64, u64>(&v1.rewards_per_epoch, v2) + v0;
        } else {
            0x2::table::add<u64, u64>(&mut v1.rewards_per_epoch, v2, v0);
        };
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::notify_reward<T2>(v0);
    }

    public fun assert_rewards_type<T0, T1, T2>() {
        let v0 = 0x1::type_name::get<T2>();
        assert!(v0 == 0x1::type_name::get<T0>() || v0 == 0x1::type_name::get<T1>() || v0 == 0x1::type_name::get<0x2::sui::SUI>() || v0 == 0x1::type_name::get<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(), 100);
    }

    public fun borrow_reward<T0, T1, T2>(arg0: &Rewards<T0, T1>) : &Reward<T0, T1, T2> {
        assert_rewards_type<T0, T1, T2>();
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Reward<T0, T1, T2>>(&arg0.id, 0x1::type_name::get<T2>())
    }

    fun borrow_reward_mut<T0, T1, T2>(arg0: &mut Rewards<T0, T1>) : &mut Reward<T0, T1, T2> {
        assert_rewards_type<T0, T1, T2>();
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Reward<T0, T1, T2>>(&mut arg0.id, 0x1::type_name::get<T2>())
    }

    public(friend) fun cast<T0, T1>(arg0: &mut Bribe<T0, T1>, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(arg2 > 0, 104);
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg1);
        arg0.total_votes = arg0.total_votes + arg2;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.vsdb_votes, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.vsdb_votes, v0) = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vsdb_votes, v0) + arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.vsdb_votes, v0, arg2);
        };
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vsdb_votes, v0);
        write_checkpoint_<T0, T1>(arg0, arg1, v1, arg3);
        write_supply_checkpoint_<T0, T1>(arg0, arg3);
    }

    public fun earned<T0, T1, T2>(arg0: &Bribe<T0, T1>, arg1: &Rewards<T0, T1>, arg2: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg3: &0x2::clock::Clock) : u64 {
        assert_rewards_type<T0, T1, T2>();
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg2);
        let v1 = borrow_reward<T0, T1, T2>(arg1);
        if (!0x2::table::contains<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&arg0.checkpoints, v0) || 0x2::table::length<u64, u64>(&v1.rewards_per_epoch) == 0) {
            return 0
        };
        let v2 = 0x2::table::borrow<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&arg0.checkpoints, v0);
        if (0x1::vector::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2) == 0) {
            return 0
        };
        let v3 = if (0x2::table::contains<0x2::object::ID, u64>(&v1.last_earn, v0)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v1.last_earn, v0)
        } else {
            0
        };
        if (0x1::vector::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2) == 0) {
            return 0
        };
        let v4 = 0;
        let v5 = round_down_week(v3);
        let v6 = 0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2, get_prior_balance_index<T0, T1>(arg0, arg2, v5));
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance(v6);
        let v7 = 0x2::math::max(v5, round_down_week(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(v6)));
        let v8 = (round_down_week(0x2::math::min(unix_timestamp(arg3), 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::locked_end(arg2))) - v7) / 604800;
        if (v8 > 0) {
            let v9 = 0;
            while (v9 < v8) {
                let v10 = 0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2, get_prior_balance_index<T0, T1>(arg0, arg2, v7 + 604800));
                let v11 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance(v10);
                0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(v10);
                let v12 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::supply(0x2::table_vec::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints, get_prior_supply_index<T0, T1>(arg0, v7 + 604800)));
                let v13 = if (0x2::table::contains<u64, u64>(&v1.rewards_per_epoch, v7)) {
                    *0x2::table::borrow<u64, u64>(&v1.rewards_per_epoch, v7)
                } else {
                    0
                };
                if (v11 > 0 && v12 > 0) {
                    v4 = v4 + (((v11 as u128) * (v13 as u128) / (v12 as u128)) as u64);
                };
                v7 = v7 + 604800;
                v9 = v9 + 1;
            };
        };
        v4
    }

    public(friend) fun get_all_rewards<T0, T1>(arg0: &mut Bribe<T0, T1>, arg1: &mut Rewards<T0, T1>, arg2: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(arg1.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>();
        let v3 = 0x1::type_name::get<0x2::sui::SUI>();
        get_reward<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4);
        get_reward<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4);
        if (v3 != v0 && v3 != v1) {
            get_reward<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
        };
        if (v2 != v0 && v2 != v1) {
            get_reward<T0, T1, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(arg0, arg1, arg2, arg3, arg4);
        };
    }

    public fun get_prior_balance_index<T0, T1>(arg0: &Bribe<T0, T1>, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg2: u64) : u64 {
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg1);
        if (!0x2::table::contains<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&arg0.checkpoints, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&arg0.checkpoints, v0);
        let v2 = 0x1::vector::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v1);
        if (v2 == 0) {
            return 0
        };
        if (0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v1, v2 - 1)) <= arg2) {
            return v2 - 1
        };
        if (0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v1, 0)) > arg2) {
            return 0
        };
        let v3 = 0;
        let v4 = v2 - 1;
        while (v3 < v4) {
            let v5 = v4 - (v4 - v3) / 2;
            let v6 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v1, v5));
            if (v6 == arg2) {
                return v5
            };
            if (v6 < arg2) {
                v3 = v5;
                continue
            };
            v4 = v5 - 1;
        };
        v3
    }

    public fun get_prior_supply_index<T0, T1>(arg0: &Bribe<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::table_vec::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints);
        if (v0 == 0) {
            return 0
        };
        if (0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::supply_ts(0x2::table_vec::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1)) <= arg1) {
            return v0 - 1
        };
        if (0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::supply_ts(0x2::table_vec::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints, 0)) > arg1) {
            return 0
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v1 < v2) {
            let v3 = v2 - (v2 - v1) / 2;
            let v4 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::supply_ts(0x2::table_vec::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints, v3));
            if (v4 == arg1) {
                return v3
            };
            if (v4 < arg1) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1
    }

    public(friend) fun get_reward<T0, T1, T2>(arg0: &mut Bribe<T0, T1>, arg1: &mut Rewards<T0, T1>, arg2: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(arg1.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert_rewards_type<T0, T1, T2>();
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg2);
        let v1 = earned<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = borrow_reward_mut<T0, T1, T2>(arg1);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v2.last_earn, v0)) {
            0x2::table::add<0x2::object::ID, u64>(&mut v2.last_earn, v0, 0);
        };
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v2.last_earn, v0) = unix_timestamp(arg3);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::take<T2>(&mut v2.balance, v1, arg4), 0x2::tx_context::sender(arg4));
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::claim_reward(0x2::tx_context::sender(arg4), v1);
        };
    }

    public(friend) fun new_reward_<T0, T1, T2>(arg0: &mut Rewards<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward<T0, T1, T2>{
            balance           : 0x2::balance::zero<T2>(),
            rewards_per_epoch : 0x2::table::new<u64, u64>(arg1),
            last_earn         : 0x2::table::new<0x2::object::ID, u64>(arg1),
        };
        let v1 = 0x1::type_name::get<T2>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rewards_type, v1);
        0x2::dynamic_field::add<0x1::type_name::TypeName, Reward<T0, T1, T2>>(&mut arg0.id, v1, v0);
    }

    public(friend) fun revoke<T0, T1>(arg0: &mut Bribe<T0, T1>, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(arg2 > 0, 104);
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.vsdb_votes, v0), 101);
        let v1 = arg0.total_votes;
        let v2 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vsdb_votes, v0);
        assert!(v1 >= arg2, 103);
        assert!(v2 >= arg2, 103);
        arg0.total_votes = v1 - arg2;
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.vsdb_votes, v0) = v2 - arg2;
        let v3 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vsdb_votes, v0);
        write_checkpoint_<T0, T1>(arg0, arg1, v3, arg3);
        write_supply_checkpoint_<T0, T1>(arg0, arg3);
    }

    public fun reward_balance<T0, T1, T2>(arg0: &Rewards<T0, T1>) : u64 {
        0x2::balance::value<T2>(&borrow_reward<T0, T1, T2>(arg0).balance)
    }

    public fun rewards_per_epoch<T0, T1, T2>(arg0: &Rewards<T0, T1>, arg1: u64) : u64 {
        let v0 = round_down_week(arg1);
        let v1 = borrow_reward<T0, T1, T2>(arg0);
        if (!0x2::table::contains<u64, u64>(&v1.rewards_per_epoch, v0)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(&v1.rewards_per_epoch, v0)
    }

    public fun rewards_type<T0, T1>(arg0: &Rewards<T0, T1>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.rewards_type
    }

    public fun round_down_week(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun total_votes<T0, T1>(arg0: &Bribe<T0, T1>) : u64 {
        arg0.total_votes
    }

    fun unix_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun vsdb_votes<T0, T1>(arg0: &Bribe<T0, T1>, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vsdb_votes, 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg1))
    }

    fun write_checkpoint_<T0, T1>(arg0: &mut Bribe<T0, T1>, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg1);
        let v1 = unix_timestamp(arg3);
        if (!0x2::table::contains<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&arg0.checkpoints, v0)) {
            0x2::table::add<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&mut arg0.checkpoints, v0, 0x1::vector::empty<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>());
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>>(&mut arg0.checkpoints, v0);
        let v3 = 0x1::vector::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2);
        if (v3 > 0 && round_down_week(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::balance_ts(0x1::vector::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2, v3 - 1))) == round_down_week(v1)) {
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::update_balance(0x1::vector::borrow_mut<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2, v3 - 1), arg2);
        } else {
            0x1::vector::push_back<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::BalanceCheckpoint>(v2, 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::new_cp(v1, arg2));
        };
    }

    fun write_supply_checkpoint_<T0, T1>(arg0: &mut Bribe<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = unix_timestamp(arg1);
        let v1 = 0x2::table_vec::length<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints);
        if (v1 > 0 && round_down_week(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::supply_ts(0x2::table_vec::borrow<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&arg0.supply_checkpoints, v1 - 1))) == round_down_week(v0)) {
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::update_supply(0x2::table_vec::borrow_mut<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&mut arg0.supply_checkpoints, v1 - 1), arg0.total_votes);
        } else {
            0x2::table_vec::push_back<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::SupplyCheckpoint>(&mut arg0.supply_checkpoints, 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints::new_sp(v0, arg0.total_votes));
        };
    }

    // decompiled from Move bytecode v6
}

