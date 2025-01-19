module 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::claim {
    struct ClaimEvent<phantom T0> has copy, drop {
        genesis_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct ClaimWithStakingEvent<phantom T0> has copy, drop {
        genesis_id: 0x2::object::ID,
        staking_pool_id: 0x2::object::ID,
        lock_time: u64,
        chakra_level: u64,
        user: address,
        amount: u64,
    }

    public fun claim_a<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg1: u64, arg2: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg2);
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::claim<T0>(arg0, arg1, 1, arg3);
        let v1 = ClaimEvent<T0>{
            genesis_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>>(arg0),
            user       : 0x2::tx_context::sender(arg3),
            amount     : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimEvent<T0>>(v1);
        v0
    }

    public fun claim_b<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg3);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::assert_valid_pool_id<T0>(arg0, 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1));
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::claim<T0>(arg0, arg2, 2, arg5);
        let v1 = ClaimWithStakingEvent<T0>{
            genesis_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>>(arg0),
            staking_pool_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1),
            lock_time       : 3888000000,
            chakra_level    : 0,
            user            : 0x2::tx_context::sender(arg5),
            amount          : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimWithStakingEvent<T0>>(v1);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), 3888000000, 0, arg4, arg5)
    }

    public fun claim_b_with_chakra<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg2: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT, arg3: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::Leaderboard, arg4: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg5: u64, arg6: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg6);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::assert_valid_pool_id<T0>(arg0, 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1));
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::claim<T0>(arg0, arg5, 2, arg8);
        let v1 = (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::get_chakra_level(arg3, arg4, arg2) as u64);
        assert!(v1 >= 1 && v1 <= 7, 0);
        let v2 = ClaimWithStakingEvent<T0>{
            genesis_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>>(arg0),
            staking_pool_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1),
            lock_time       : 3888000000,
            chakra_level    : v1,
            user            : 0x2::tx_context::sender(arg8),
            amount          : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimWithStakingEvent<T0>>(v2);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg8), 3888000000, v1, arg7, arg8)
    }

    public fun claim_c<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg3);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::assert_valid_pool_id<T0>(arg0, 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1));
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::claim<T0>(arg0, arg2, 3, arg5);
        let v1 = ClaimWithStakingEvent<T0>{
            genesis_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>>(arg0),
            staking_pool_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1),
            lock_time       : 7776000000,
            chakra_level    : 0,
            user            : 0x2::tx_context::sender(arg5),
            amount          : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimWithStakingEvent<T0>>(v1);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), 7776000000, 0, arg4, arg5)
    }

    public fun claim_c_with_chakra<T0>(arg0: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>, arg2: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::ChakraNFT, arg3: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::Leaderboard, arg4: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft::GlobalConfig, arg5: u64, arg6: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakedPosition<T0> {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::version::assert_current_version(arg6);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::assert_valid_pool_id<T0>(arg0, 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1));
        let v0 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::claim<T0>(arg0, arg5, 3, arg8);
        let v1 = (0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::leaderboard::get_chakra_level(arg3, arg4, arg2) as u64);
        assert!(v1 >= 1 && v1 <= 7, 0);
        let v2 = ClaimWithStakingEvent<T0>{
            genesis_id      : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>>(arg0),
            staking_pool_id : 0x2::object::id<0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::StakingPool<T0>>(arg1),
            lock_time       : 7776000000,
            chakra_level    : v1,
            user            : 0x2::tx_context::sender(arg8),
            amount          : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimWithStakingEvent<T0>>(v2);
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool::stake<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg8), 7776000000, v1, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

