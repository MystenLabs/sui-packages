module 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::staking {
    struct StakeKey has copy, drop, store {
        stake: 0x2::object::ID,
    }

    struct Unstaked has copy, drop {
        controller: 0x2::object::ID,
        stake: 0x2::object::ID,
        returned: u64,
    }

    public(friend) fun stake(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::staking_policy::authorize(0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::policies::borrow_mut<0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::staking_policy::StakingPolicy>(0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::policies_mut(arg0)), 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::controller(arg0), arg3, 0x2::balance::value<0x2::sui::SUI>(&arg2), arg4);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg5), arg3, arg5);
        let v1 = 0x2::object::id<0x3::staking_pool::StakedSui>(&v0);
        let v2 = StakeKey{stake: v1};
        0x2::bag::add<StakeKey, 0x3::staking_pool::StakedSui>(0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::positions_mut(arg0), v2, v0);
        v1
    }

    public fun stake_key(arg0: 0x2::object::ID) : StakeKey {
        StakeKey{stake: arg0}
    }

    public(friend) fun unstake(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::policies::borrow<0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::staking_policy::StakingPolicy>(0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::policies(arg0));
        let v0 = 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::positions_mut(arg0);
        let v1 = StakeKey{stake: arg2};
        assert!(0x2::bag::contains_with_type<StakeKey, 0x3::staking_pool::StakedSui>(v0, v1), 0);
        let v2 = StakeKey{stake: arg2};
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x2::bag::remove<StakeKey, 0x3::staking_pool::StakedSui>(v0, v2), arg3);
        let v4 = Unstaked{
            controller : 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::controller(arg0),
            stake      : arg2,
            returned   : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        0x2::event::emit<Unstaked>(v4);
        v3
    }

    // decompiled from Move bytecode v7
}

