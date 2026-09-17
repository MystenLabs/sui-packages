module 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner {
    struct LiquidityMiner<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_rewards: 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::PoolRewardManager,
        version: u16,
    }

    struct StakingPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        miner: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        miner: 0x2::object::ID,
    }

    public fun add_reward<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::add_pool_reward<T1>(&mut arg0.pool_rewards, 0x2::coin::into_balance<T1>(arg2), arg3, arg4, arg5, arg6);
    }

    public fun cancel_reward<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::cancel_pool_reward<T1>(&mut arg0.pool_rewards, arg2, arg3)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: &mut StakingPosition<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        0x2::coin::from_balance<T1>(0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::claim_rewards<T1>(&mut arg0.pool_rewards, 0x2::object::id<StakingPosition<T0>>(arg1), arg2, arg3), arg4)
    }

    public fun close_reward<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::close_pool_reward<T1>(&mut arg0.pool_rewards, arg2, arg3)
    }

    public fun destroy<T0>(arg0: &LiquidityMiner<T0>, arg1: StakingPosition<T0>) {
        ensure_version_matches<T0>(arg0);
        let StakingPosition {
            id      : v0,
            miner   : _,
            balance : v2,
        } = arg1;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun ensure_version_matches<T0>(arg0: &LiquidityMiner<T0>) {
        assert!(arg0.version == 0, 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::version_mismatch());
    }

    public fun enter<T0>(arg0: &LiquidityMiner<T0>, arg1: &mut 0x2::tx_context::TxContext) : StakingPosition<T0> {
        ensure_version_matches<T0>(arg0);
        StakingPosition<T0>{
            id      : 0x2::object::new(arg1),
            miner   : 0x2::object::id<LiquidityMiner<T0>>(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun get_pool_reward_manager<T0>(arg0: &LiquidityMiner<T0>) : &0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::PoolRewardManager {
        &arg0.pool_rewards
    }

    public fun new_liquidity_miner<T0>(arg0: &mut 0x2::tx_context::TxContext) : (LiquidityMiner<T0>, AdminCap) {
        let v0 = LiquidityMiner<T0>{
            id           : 0x2::object::new(arg0),
            pool_rewards : 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::new_pool_reward_manager(arg0),
            version      : 0,
        };
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            miner : 0x2::object::id<LiquidityMiner<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun stake<T0>(arg0: &mut LiquidityMiner<T0>, arg1: &mut StakingPosition<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        update_obligation_reward_manager<T0>(arg0, 0x2::object::id<StakingPosition<T0>>(arg1), 0x2::balance::value<T0>(&arg1.balance), arg3);
    }

    public(friend) fun update_obligation_reward_manager<T0>(arg0: &mut LiquidityMiner<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.pool_rewards;
        if (!0x2::table::contains<0x2::object::ID, 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::ObligationRewardManager>(0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::borrow_obligation_reward_managers(v0), arg1)) {
            0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::new_obligation_reward_manager(v0, arg1, arg3);
        };
        0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_mining_reward_manager::change_obligation_reward_manager_share(v0, arg1, arg2, arg3);
    }

    public fun withdraw<T0>(arg0: &mut LiquidityMiner<T0>, arg1: &mut StakingPosition<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        ensure_version_matches<T0>(arg0);
        assert!(arg1.miner == 0x2::object::id<LiquidityMiner<T0>>(arg0), 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error::wrong_miner());
        update_obligation_reward_manager<T0>(arg0, 0x2::object::id<StakingPosition<T0>>(arg1), 0x2::balance::value<T0>(&arg1.balance), arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

