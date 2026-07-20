module 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining {
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
        reward_manager: 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::PoolRewardManager,
        staked_nfts: 0x2::table::Table<address, StakePosition>,
        user_claimed: 0x2::table::Table<address, u64>,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        nfts: vector<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        season: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct RewardAdded has copy, drop {
        season: u64,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
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

    struct RewardClaimed has copy, drop {
        who: address,
        season: u64,
        position_id: 0x2::object::ID,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        time: u64,
    }

    struct Redeemed has copy, drop {
        season: u64,
        position_id: 0x2::object::ID,
        owner: address,
        count: u64,
    }

    public fun add_reward(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season());
        assert!(arg3 >= v0.start_time_ms && arg4 <= v0.end_time_ms, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::reward_outside_season());
        let v1 = RewardAdded{
            season        : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
            reward_index  : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::add_pool_reward<0x2::sui::SUI>(&mut v0.reward_manager, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), arg3, arg4, arg5, arg6),
            coin_type     : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            amount        : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            start_time_ms : arg3,
            end_time_ms   : arg4,
        };
        0x2::event::emit<RewardAdded>(v1);
    }

    fun borrow_pool(arg0: &MiningVault, arg1: u64) : &SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::pool_not_found());
        0x2::table::borrow<u64, SeasonPool>(&arg0.pools, arg1)
    }

    fun borrow_pool_mut(arg0: &mut MiningVault, arg1: u64) : &mut SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::pool_not_found());
        0x2::table::borrow_mut<u64, SeasonPool>(&mut arg0.pools, arg1)
    }

    fun claim_reward(arg0: &mut 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::PoolRewardManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::claim_rewards<0x2::sui::SUI>(arg0, arg1, arg3, arg2);
        let v1 = RewardClaimed{
            who           : 0x2::tx_context::sender(arg4),
            season        : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
            position_id   : arg1,
            reward_index  : arg2,
            coin_type     : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            reward_amount : 0x2::balance::value<0x2::sui::SUI>(&v0),
            time          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4)
    }

    public fun create_pool(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::wrong_version());
        assert!(!0x2::table::contains<u64, SeasonPool>(&arg0.pools, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season()), 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::pool_already_exists());
        assert!(arg3 > arg2, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::bad_pool_params());
        let v0 = SeasonPool{
            season         : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
            start_time_ms  : arg2,
            end_time_ms    : arg3,
            total_staked   : 0,
            reward_manager : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::new_pool_reward_manager(arg4),
            staked_nfts    : 0x2::table::new<address, StakePosition>(arg4),
            user_claimed   : 0x2::table::new<address, u64>(arg4),
        };
        0x2::table::add<u64, SeasonPool>(&mut arg0.pools, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(), v0);
        let v1 = PoolCreated{
            season        : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
            start_time_ms : arg2,
            end_time_ms   : arg3,
        };
        0x2::event::emit<PoolCreated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MiningVault{
            id      : 0x2::object::new(arg0),
            version : 1,
            pools   : 0x2::table::new<u64, SeasonPool>(arg0),
        };
        0x2::transfer::share_object<MiningVault>(v0);
        let v1 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &PoolAdminCap, arg1: &mut MiningVault) {
        assert!(arg1.version < 1, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::wrong_version());
        arg1.version = 1;
    }

    public fun pending_reward(arg0: &MiningVault, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = borrow_pool(arg0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season());
        if (!0x2::table::contains<address, StakePosition>(&v0.staked_nfts, arg1)) {
            return 0
        };
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::pending_rewards(&v0.reward_manager, 0x2::object::id<StakePosition>(0x2::table::borrow<address, StakePosition>(&v0.staked_nfts, arg1)), arg2, arg3)
    }

    public fun pool_times(arg0: &MiningVault, arg1: u64) : (u64, u64) {
        let v0 = borrow_pool(arg0, arg1);
        (v0.start_time_ms, v0.end_time_ms)
    }

    public fun redeem(arg0: &mut MiningVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season());
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::pool_not_ended());
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, StakePosition>(&v0.staked_nfts, v1), 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::liquidity_mining_no_reward_to_claim());
        let StakePosition {
            id   : v2,
            nfts : v3,
        } = 0x2::table::remove<address, StakePosition>(&mut v0.staked_nfts, v1);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = 0x1::vector::length<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&v4);
        v0.total_staked = v0.total_staked - v7;
        while (!0x1::vector::is_empty<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&v4)) {
            0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::burn(0x1::vector::pop_back<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&mut v4));
        };
        0x1::vector::destroy_empty<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(v4);
        let v8 = &mut v0.reward_manager;
        let v9 = claim_reward(v8, v6, arg1, arg2, arg3);
        assert!(!0x2::table::contains<address, u64>(&v0.user_claimed, v1), 0);
        0x2::table::add<address, u64>(&mut v0.user_claimed, v1, 0x2::coin::value<0x2::sui::SUI>(&v9));
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::set_position_share(&mut v0.reward_manager, v6, 0, arg2);
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::remove_position_reward_manager(&mut v0.reward_manager, v6);
        let v10 = Redeemed{
            season      : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
            position_id : v6,
            owner       : 0x2::tx_context::sender(arg3),
            count       : v7,
        };
        0x2::event::emit<Redeemed>(v10);
        0x2::object::delete(v5);
        v9
    }

    public fun stake(arg0: &mut MiningVault, arg1: vector<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season());
        let v1 = 0x1::vector::length<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&arg1);
        assert!(v1 > 0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::empty_stake());
        assert!(0x2::clock::timestamp_ms(arg2) < v0.end_time_ms, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::pool_ended());
        let v2 = 0;
        while (v2 < v1) {
            assert!(0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::nft_season(0x1::vector::borrow<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&arg1, v2)) == v0.season, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::season_mismatch());
            v2 = v2 + 1;
        };
        v0.total_staked = v0.total_staked + v1;
        let v3 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, StakePosition>(&v0.staked_nfts, v3)) {
            let v4 = StakePosition{
                id   : 0x2::object::new(arg3),
                nfts : 0x1::vector::empty<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(),
            };
            0x2::table::add<address, StakePosition>(&mut v0.staked_nfts, v3, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, StakePosition>(&mut v0.staked_nfts, v3);
        let v6 = 0x2::object::id<StakePosition>(v5);
        0x1::vector::append<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&mut v5.nfts, arg1);
        let v7 = 0x1::vector::length<0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::SurfNFT>(&v5.nfts);
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::liquidity_mining_reward_manager::set_position_share(&mut v0.reward_manager, v6, v7, arg2);
        let v8 = Staked{
            season            : 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf::season(),
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

