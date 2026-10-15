module 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining {
    struct MiningVault has key {
        id: 0x2::object::UID,
        version: u64,
        pools: 0x2::table::Table<u64, SeasonPool>,
    }

    struct SeasonPool has store {
        season: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        total_staked: u64,
        reward_manager: 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining_reward_manager::PoolRewardManager,
        staked_nfts: 0x2::table::Table<address, StakePosition>,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        nfts: vector<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>,
    }

    struct PoolCreated has copy, drop {
        season: u64,
        reward_index: u64,
        amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct Staked has copy, drop {
        season: u64,
        position_id: 0x2::object::ID,
        owner: address,
        shares_added: u64,
        total_user_shares: u64,
        total_staked: u64,
        time: u64,
    }

    fun borrow_pool(arg0: &MiningVault, arg1: u64) : &SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::pool_not_found());
        0x2::table::borrow<u64, SeasonPool>(&arg0.pools, arg1)
    }

    fun borrow_pool_mut(arg0: &mut MiningVault, arg1: u64) : &mut SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::pool_not_found());
        0x2::table::borrow_mut<u64, SeasonPool>(&mut arg0.pools, arg1)
    }

    public fun create_pool(arg0: &mut MiningVault, arg1: 0x2::coin::Coin<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::s3_reward::S3_REWARD>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::wrong_version());
        assert!(!0x2::table::contains<u64, SeasonPool>(&arg0.pools, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season()), 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::pool_already_exists());
        assert!(arg3 > arg2, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::bad_pool_params());
        let v0 = 0x2::coin::value<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::s3_reward::S3_REWARD>(&arg1);
        assert!(v0 == 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::s3_reward::max_points(), 0);
        let v1 = 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining_reward_manager::new_pool_reward_manager(arg5);
        let v2 = 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining_reward_manager::add_pool_reward<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::s3_reward::S3_REWARD>(&mut v1, 0x2::coin::into_balance<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::s3_reward::S3_REWARD>(arg1), arg2, arg3, arg4, arg5);
        assert!(v2 == 0, 0);
        let v3 = SeasonPool{
            season         : 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season(),
            start_time_ms  : arg2,
            end_time_ms    : arg3,
            total_staked   : 0,
            reward_manager : v1,
            staked_nfts    : 0x2::table::new<address, StakePosition>(arg5),
        };
        0x2::table::add<u64, SeasonPool>(&mut arg0.pools, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season(), v3);
        let v4 = PoolCreated{
            season        : 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season(),
            reward_index  : v2,
            amount        : v0,
            start_time_ms : arg2,
            end_time_ms   : arg3,
        };
        0x2::event::emit<PoolCreated>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MiningVault{
            id      : 0x2::object::new(arg0),
            version : 1,
            pools   : 0x2::table::new<u64, SeasonPool>(arg0),
        };
        0x2::transfer::share_object<MiningVault>(v0);
    }

    public fun pending_reward(arg0: &MiningVault, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = borrow_pool(arg0, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season());
        if (!0x2::table::contains<address, StakePosition>(&v0.staked_nfts, arg1)) {
            return 0
        };
        0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining_reward_manager::pending_rewards(&v0.reward_manager, 0x2::object::id<StakePosition>(0x2::table::borrow<address, StakePosition>(&v0.staked_nfts, arg1)), 0, arg2)
    }

    public fun pool_times(arg0: &MiningVault, arg1: u64) : (u64, u64) {
        let v0 = borrow_pool(arg0, arg1);
        (v0.start_time_ms, v0.end_time_ms)
    }

    public fun stake(arg0: &mut MiningVault, arg1: vector<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season());
        let v1 = 0x1::vector::length<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>(&arg1);
        assert!(v1 > 0, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::empty_stake());
        assert!(0x2::clock::timestamp_ms(arg2) < v0.end_time_ms, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::pool_ended());
        let v2 = 0;
        while (v2 < v1) {
            assert!(0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::nft_season(0x1::vector::borrow<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>(&arg1, v2)) == v0.season, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::season_mismatch());
            v2 = v2 + 1;
        };
        v0.total_staked = v0.total_staked + v1;
        let v3 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, StakePosition>(&v0.staked_nfts, v3)) {
            let v4 = StakePosition{
                id   : 0x2::object::new(arg3),
                nfts : 0x1::vector::empty<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>(),
            };
            0x2::table::add<address, StakePosition>(&mut v0.staked_nfts, v3, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, StakePosition>(&mut v0.staked_nfts, v3);
        let v6 = 0x2::object::id<StakePosition>(v5);
        0x1::vector::append<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>(&mut v5.nfts, arg1);
        let v7 = 0x1::vector::length<0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::GoggleNFT>(&v5.nfts);
        assert!(v7 <= 100, 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::errors::position_full());
        0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::liquidity_mining_reward_manager::set_position_share(&mut v0.reward_manager, v6, v7, arg2);
        let v8 = Staked{
            season            : 0xe52dc1d23fcbfb737c80da1c0ef47606d923ae4f4b0ecf719ad68e2475b1d907::goggle::season(),
            position_id       : v6,
            owner             : 0x2::tx_context::sender(arg3),
            shares_added      : v1,
            total_user_shares : v7,
            total_staked      : v0.total_staked,
            time              : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Staked>(v8);
    }

    public fun total_staked(arg0: &MiningVault, arg1: u64) : u64 {
        borrow_pool(arg0, arg1).total_staked
    }

    // decompiled from Move bytecode v7
}

