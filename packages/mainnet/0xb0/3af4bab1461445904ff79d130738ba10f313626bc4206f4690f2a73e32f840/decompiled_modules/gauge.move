module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge {
    struct Gauge<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        is_alive: bool,
        pool: 0x2::object::ID,
        bribe: 0x2::object::ID,
        rewards: 0x2::object::ID,
        fees_x: 0x2::balance::Balance<T0>,
        fees_y: 0x2::balance::Balance<T1>,
        sdb_balance: 0x2::balance::Balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>,
        reward_rate: u64,
        last_update_time: u64,
        period_finish: u64,
        voting_index: u256,
        claimable: u64,
        total_stakes: 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1>,
        staking_index: u256,
    }

    struct Stake<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        stakes: u64,
        staking_index: u256,
        pending_sdb: u64,
    }

    public(friend) fun new<T0, T1>(arg0: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : Gauge<T0, T1> {
        let (v0, v1) = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::new<T0, T1>(arg1);
        Gauge<T0, T1>{
            id               : 0x2::object::new(arg1),
            version          : 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(),
            is_alive         : true,
            pool             : 0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg0),
            bribe            : v0,
            rewards          : v1,
            fees_x           : 0x2::balance::zero<T0>(),
            fees_y           : 0x2::balance::zero<T1>(),
            sdb_balance      : 0x2::balance::zero<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(),
            reward_rate      : 0,
            last_update_time : 0,
            period_finish    : 0,
            voting_index     : 0,
            claimable        : 0,
            total_stakes     : 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::create_lp<T0, T1>(arg0, arg1),
            staking_index    : 0,
        }
    }

    public fun assert_pkg_version<T0, T1>(arg0: &Gauge<T0, T1>) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
    }

    public fun bribe_id<T0, T1>(arg0: &Gauge<T0, T1>) : 0x2::object::ID {
        arg0.bribe
    }

    public fun cal_staking_index<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::lp_balance<T0, T1>(&arg0.total_stakes);
        if (v0 == 0) {
            return arg0.staking_index
        };
        arg0.staking_index + ((last_time_reward_applicable<T0, T1>(arg0, arg1) - arg0.last_update_time) as u256) * (arg0.reward_rate as u256) * 1000000000000000000 / (v0 as u256)
    }

    public fun claim_fee<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let (v0, v1, v2, v3) = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::claim_fees_dev<T0, T1>(arg2, &mut arg0.total_stakes, arg4);
        let v4 = v1;
        let v5 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v5)) {
            0x2::coin::put<T0>(&mut arg0.fees_x, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v5));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v4)) {
            0x2::coin::put<T1>(&mut arg0.fees_y, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v5);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        if (v2 > 0) {
            if (0x2::balance::value<T0>(&arg0.fees_x) > 604800) {
                0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::bribe<T0, T1, T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fees_x), arg4), arg3);
            };
        };
        if (v3 > 0) {
            if (0x2::balance::value<T1>(&arg0.fees_y) > 604800) {
                0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::bribe<T0, T1, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.fees_y), arg4), arg3);
            };
        };
    }

    public fun claimable<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        arg0.claimable
    }

    public fun create_stake<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : Stake<T0, T1> {
        assert_pkg_version<T0, T1>(arg0);
        Stake<T0, T1>{
            id            : 0x2::object::new(arg1),
            stakes        : 0,
            staking_index : arg0.staking_index,
            pending_sdb   : 0,
        }
    }

    public entry fun delete_stake<T0, T1>(arg0: Stake<T0, T1>) {
        let Stake {
            id            : v0,
            stakes        : v1,
            staking_index : _,
            pending_sdb   : v3,
        } = arg0;
        assert!(v3 == 0, 107);
        assert!(v1 == 0, 108);
        0x2::object::delete(v0);
    }

    public fun distribute_emissions<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg3);
        assert!(v0 > 0, 102);
        let v1 = unix_timestamp(arg4);
        let v2 = epoch_end(v1) - v1;
        claim_fee<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        update_gauge_<T0, T1>(arg0, arg4);
        if (v1 >= arg0.period_finish) {
            0x2::coin::put<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.sdb_balance, arg3);
            arg0.reward_rate = v0 / v2;
        } else {
            0x2::coin::put<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.sdb_balance, arg3);
            arg0.reward_rate = (v0 + (arg0.period_finish - v1) * arg0.reward_rate) / v2;
        };
        assert!(arg0.reward_rate > 0, 105);
        assert!(arg0.reward_rate <= 0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.sdb_balance) / v2, 106);
        arg0.period_finish = epoch_end(v1);
        arg0.last_update_time = v1;
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::notify_reward<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(v0);
    }

    public fun epoch_end(arg0: u64) : u64 {
        arg0 / 604800 * 604800 + 604800
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun gauge_staking_index<T0, T1>(arg0: &Gauge<T0, T1>) : u256 {
        arg0.staking_index
    }

    public entry fun get_reward<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut Stake<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        update_gauge_<T0, T1>(arg0, arg2);
        update_stake_<T0, T1>(arg0, arg1);
        let v0 = arg1.pending_sdb;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(0x2::coin::take<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.sdb_balance, v0, arg3), 0x2::tx_context::sender(arg3));
        };
        arg1.pending_sdb = 0;
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::claim_reward(0x2::tx_context::sender(arg3), v0);
    }

    public fun is_alive<T0, T1>(arg0: &Gauge<T0, T1>) : bool {
        arg0.is_alive
    }

    public fun last_time_reward_applicable<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x2::math::min(unix_timestamp(arg1), arg0.period_finish)
    }

    public fun left<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = unix_timestamp(arg1);
        if (v0 >= arg0.period_finish) {
            return 0
        };
        (arg0.period_finish - v0) * arg0.reward_rate
    }

    public fun pending_sdb<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &Stake<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg1.pending_sdb;
        let v1 = v0;
        if (unix_timestamp(arg2) > arg0.last_update_time && arg1.stakes > 0) {
            let v2 = cal_staking_index<T0, T1>(arg0, arg2) - arg1.staking_index;
            if (v2 > 0) {
                v1 = v0 + (((arg1.stakes as u256) * v2 / 1000000000000000000) as u64);
            };
        };
        v1
    }

    public fun period_finish<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        arg0.period_finish
    }

    public fun pool_bribes<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>) : (u64, u64) {
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::claimable<T0, T1>(arg1, &arg0.total_stakes)
    }

    public fun pool_id<T0, T1>(arg0: &Gauge<T0, T1>) : 0x2::object::ID {
        arg0.pool
    }

    public fun reward_rate<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        arg0.reward_rate
    }

    public fun rewards_id<T0, T1>(arg0: &Gauge<T0, T1>) : 0x2::object::ID {
        arg0.rewards
    }

    public fun sdb_balance<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.sdb_balance)
    }

    public entry fun stake<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1>, arg3: &mut Stake<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::lp_balance<T0, T1>(arg2) >= arg4, 102);
        assert!(arg4 > 0, 102);
        update_gauge_<T0, T1>(arg0, arg5);
        update_stake_<T0, T1>(arg0, arg3);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::join_lp<T0, T1>(arg1, &mut arg0.total_stakes, arg2, arg4);
        arg3.stakes = arg3.stakes + arg4;
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::deposit_lp<T0, T1>(0x2::tx_context::sender(arg6), arg4);
    }

    public entry fun stake_all<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1>, arg3: &mut Stake<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::lp_balance<T0, T1>(arg2);
        assert!(v0 > 0, 102);
        stake<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5);
    }

    public fun stake_stakes<T0, T1>(arg0: &Stake<T0, T1>) : u64 {
        arg0.stakes
    }

    public fun total_stakes<T0, T1>(arg0: &Gauge<T0, T1>) : &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1> {
        &arg0.total_stakes
    }

    fun unix_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun unstake<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1>, arg3: &mut Stake<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        update_gauge_<T0, T1>(arg0, arg5);
        update_stake_<T0, T1>(arg0, arg3);
        assert!(arg4 <= arg3.stakes, 103);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::join_lp<T0, T1>(arg1, arg2, &mut arg0.total_stakes, arg4);
        arg3.stakes = arg3.stakes - arg4;
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::withdraw_lp<T0, T1>(0x2::tx_context::sender(arg6), arg4);
    }

    public fun unstake_all<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::LP<T0, T1>, arg3: &mut Stake<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = arg3.stakes;
        assert!(v0 <= arg3.stakes, 103);
        unstake<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5);
    }

    public(friend) fun update_claimable<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: u64) {
        assert_pkg_version<T0, T1>(arg0);
        arg0.claimable = arg1;
    }

    fun update_gauge_<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0x2::clock::Clock) {
        arg0.staking_index = cal_staking_index<T0, T1>(arg0, arg1);
        arg0.last_update_time = last_time_reward_applicable<T0, T1>(arg0, arg1);
    }

    public(friend) fun update_is_alive<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: bool) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        arg0.is_alive = arg1;
    }

    fun update_stake_<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut Stake<T0, T1>) {
        let v0 = arg1.stakes;
        if (v0 > 0) {
            let v1 = arg0.staking_index - arg1.staking_index;
            if (v1 > 0) {
                arg1.pending_sdb = arg1.pending_sdb + (((v0 as u256) * v1 / 1000000000000000000) as u64);
            };
        };
        arg1.staking_index = arg0.staking_index;
    }

    public(friend) fun update_voting_index<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: u256) {
        assert_pkg_version<T0, T1>(arg0);
        arg0.voting_index = arg1;
    }

    public fun voting_index<T0, T1>(arg0: &Gauge<T0, T1>) : u256 {
        arg0.voting_index
    }

    // decompiled from Move bytecode v6
}

