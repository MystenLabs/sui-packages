module 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking {
    struct StakeEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        duration: u64,
        chakra_level: u64,
        timestamp: u64,
        position_id: 0x2::object::ID,
    }

    struct UnstakeEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
        position_id: 0x2::object::ID,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
        position_id: 0x2::object::ID,
    }

    public fun claim_rewards<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>, arg2: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg2);
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::claim<T0>(arg0, arg1, arg3, arg4);
        let v1 = ClaimEvent<T0>{
            pool_id     : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg0),
            user        : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<T0>(&v0),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            position_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>>(arg1),
        };
        0x2::event::emit<ClaimEvent<T0>>(v1);
        v0
    }

    public fun stake<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg3);
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg0, arg1, arg2, 0, arg4, arg5);
        let v1 = StakeEvent<T0>{
            pool_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg0),
            user         : 0x2::tx_context::sender(arg5),
            amount       : 0x2::coin::value<T0>(&arg1),
            duration     : arg2,
            chakra_level : 0,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            position_id  : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>>(&v0),
        };
        0x2::event::emit<StakeEvent<T0>>(v1);
        v0
    }

    public fun stake_with_chakra<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg1: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT, arg2: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::Leaderboard, arg3: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg6);
        let v0 = (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::get_chakra_level(arg2, arg3, arg1) as u64);
        assert!(v0 >= 1 && v0 <= 7, 0);
        let v1 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg0, arg4, arg5, v0, arg7, arg8);
        let v2 = StakeEvent<T0>{
            pool_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg0),
            user         : 0x2::tx_context::sender(arg8),
            amount       : 0x2::coin::value<T0>(&arg4),
            duration     : arg5,
            chakra_level : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg7),
            position_id  : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>>(&v1),
        };
        0x2::event::emit<StakeEvent<T0>>(v2);
        v1
    }

    public fun unstake<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg1: 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>, arg2: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg2);
        let (v0, v1) = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::unstake<T0>(arg0, arg1, arg3, arg4);
        let v2 = v0;
        let v3 = UnstakeEvent<T0>{
            pool_id     : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg0),
            user        : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<T0>(&v2),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            position_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0>>(&arg1),
        };
        0x2::event::emit<UnstakeEvent<T0>>(v3);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

