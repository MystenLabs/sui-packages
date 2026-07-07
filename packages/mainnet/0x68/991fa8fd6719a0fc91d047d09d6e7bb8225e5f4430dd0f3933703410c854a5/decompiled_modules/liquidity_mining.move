module 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining {
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
        reward_manager: 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::PoolRewardManager,
        staked_nfts: 0x2::table::Table<0x2::object::ID, vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>>,
    }

    struct StakePosition has key {
        id: 0x2::object::UID,
        season: u64,
        count: u64,
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

    struct RewardCancelled has copy, drop {
        season: u64,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RewardClosed has copy, drop {
        season: u64,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Staked has copy, drop {
        season: u64,
        position_id: 0x2::object::ID,
        owner: address,
        count: u64,
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

    public fun add_reward<T0>(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, arg2);
        assert!(arg4 >= v0.start_time_ms && arg5 <= v0.end_time_ms, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::reward_outside_season());
        let v1 = RewardAdded{
            season        : arg2,
            reward_index  : 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::add_pool_reward<T0>(&mut v0.reward_manager, 0x2::coin::into_balance<T0>(arg3), arg4, arg5, arg6, arg7),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            amount        : 0x2::coin::value<T0>(&arg3),
            start_time_ms : arg4,
            end_time_ms   : arg5,
        };
        0x2::event::emit<RewardAdded>(v1);
    }

    fun borrow_pool(arg0: &MiningVault, arg1: u64) : &SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_not_found());
        0x2::table::borrow<u64, SeasonPool>(&arg0.pools, arg1)
    }

    fun borrow_pool_mut(arg0: &mut MiningVault, arg1: u64) : &mut SeasonPool {
        assert!(0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1), 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_not_found());
        0x2::table::borrow_mut<u64, SeasonPool>(&mut arg0.pools, arg1)
    }

    public fun cancel_reward<T0>(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::cancel_pool_reward<T0>(&mut borrow_pool_mut(arg0, arg2).reward_manager, arg3, arg4);
        let v1 = RewardCancelled{
            season       : arg2,
            reward_index : arg3,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            amount       : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RewardCancelled>(v1);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    public fun claim_reward<T0>(arg0: &mut MiningVault, arg1: &StakePosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = arg1.season;
        let v1 = borrow_pool_mut(arg0, v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.end_time_ms, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_not_ended());
        let v2 = 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::claim_rewards<T0>(&mut v1.reward_manager, 0x2::object::id<StakePosition>(arg1), arg3, arg2);
        let v3 = RewardClaimed{
            who           : 0x2::tx_context::sender(arg4),
            season        : v0,
            position_id   : 0x2::object::id<StakePosition>(arg1),
            reward_index  : arg2,
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            reward_amount : 0x2::balance::value<T0>(&v2),
            time          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardClaimed>(v3);
        0x2::coin::from_balance<T0>(v2, arg4)
    }

    public fun close_reward<T0>(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, arg2);
        assert!(v0.total_staked == 0, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_not_ended());
        let v1 = 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::close_pool_reward<T0>(&mut v0.reward_manager, arg3, arg4);
        let v2 = RewardClosed{
            season       : arg2,
            reward_index : arg3,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            amount       : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<RewardClosed>(v2);
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    public fun create_pool(arg0: &mut MiningVault, arg1: &PoolAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        assert!(!0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg2), 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_already_exists());
        assert!(arg4 > arg3, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::bad_pool_params());
        let v0 = SeasonPool{
            season         : arg2,
            start_time_ms  : arg3,
            end_time_ms    : arg4,
            total_staked   : 0,
            reward_manager : 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::new_pool_reward_manager(arg5),
            staked_nfts    : 0x2::table::new<0x2::object::ID, vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>>(arg5),
        };
        0x2::table::add<u64, SeasonPool>(&mut arg0.pools, arg2, v0);
        let v1 = PoolCreated{
            season        : arg2,
            start_time_ms : arg3,
            end_time_ms   : arg4,
        };
        0x2::event::emit<PoolCreated>(v1);
    }

    public fun has_pool(arg0: &MiningVault, arg1: u64) : bool {
        0x2::table::contains<u64, SeasonPool>(&arg0.pools, arg1)
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
        assert!(arg1.version < 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        arg1.version = 1;
    }

    public fun pending_reward(arg0: &MiningVault, arg1: &StakePosition, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::pending_rewards(&borrow_pool(arg0, arg1.season).reward_manager, 0x2::object::id<StakePosition>(arg1), arg2, arg3)
    }

    public fun pool_reward_manager(arg0: &MiningVault, arg1: u64) : &0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::PoolRewardManager {
        &borrow_pool(arg0, arg1).reward_manager
    }

    public fun pool_times(arg0: &MiningVault, arg1: u64) : (u64, u64) {
        let v0 = borrow_pool(arg0, arg1);
        (v0.start_time_ms, v0.end_time_ms)
    }

    public fun position_count(arg0: &StakePosition) : u64 {
        arg0.count
    }

    public fun position_season(arg0: &StakePosition) : u64 {
        arg0.season
    }

    public fun redeem(arg0: &mut MiningVault, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, arg1.season);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_not_ended());
        let v1 = 0x2::object::id<StakePosition>(&arg1);
        0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::set_position_share(&mut v0.reward_manager, v1, 0, arg2);
        0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::remove_position_reward_manager(&mut v0.reward_manager, v1);
        v0.total_staked = v0.total_staked - arg1.count;
        let v2 = 0x2::table::remove<0x2::object::ID, vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>>(&mut v0.staked_nfts, v1);
        while (!0x1::vector::is_empty<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>(&v2)) {
            0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::burn(0x1::vector::pop_back<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>(&mut v2));
        };
        0x1::vector::destroy_empty<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>(v2);
        let StakePosition {
            id     : v3,
            season : v4,
            count  : v5,
        } = arg1;
        let v6 = Redeemed{
            season      : v4,
            position_id : v1,
            owner       : 0x2::tx_context::sender(arg3),
            count       : v5,
        };
        0x2::event::emit<Redeemed>(v6);
        0x2::object::delete(v3);
    }

    public fun stake(arg0: &mut MiningVault, arg1: u64, arg2: vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakePosition {
        assert!(arg0.version == 1, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::wrong_version());
        let v0 = borrow_pool_mut(arg0, arg1);
        let v1 = 0x1::vector::length<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>(&arg2);
        assert!(v1 > 0, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::empty_stake());
        assert!(0x2::clock::timestamp_ms(arg3) < v0.end_time_ms, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::pool_ended());
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::nft_season(0x1::vector::borrow<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>(&arg2, v2)) == v0.season, 0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::errors::season_mismatch());
            v2 = v2 + 1;
        };
        v0.total_staked = v0.total_staked + v1;
        let v3 = 0x2::object::new(arg4);
        0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::liquidity_mining_reward_manager::set_position_share(&mut v0.reward_manager, 0x2::object::uid_to_inner(&v3), v1, arg3);
        0x2::table::add<0x2::object::ID, vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>>(&mut v0.staked_nfts, 0x2::object::uid_to_inner(&v3), arg2);
        let v4 = Staked{
            season       : arg1,
            position_id  : 0x2::object::uid_to_inner(&v3),
            owner        : 0x2::tx_context::sender(arg4),
            count        : v1,
            total_staked : v0.total_staked,
            time         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Staked>(v4);
        StakePosition{
            id     : v3,
            season : arg1,
            count  : v1,
        }
    }

    entry fun stake_and_keep(arg0: &mut MiningVault, arg1: u64, arg2: vector<0x68991fa8fd6719a0fc91d047d09d6e7bb8225e5f4430dd0f3933703410c854a5::surf::SurfNFT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<StakePosition>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun total_staked(arg0: &MiningVault, arg1: u64) : u64 {
        borrow_pool(arg0, arg1).total_staked
    }

    // decompiled from Move bytecode v7
}

