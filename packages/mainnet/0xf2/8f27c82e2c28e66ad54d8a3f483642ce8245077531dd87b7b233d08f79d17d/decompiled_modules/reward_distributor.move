module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor {
    struct REWARD_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct EventStart has copy, drop, store {
        dummy_field: bool,
    }

    struct EventCheckpointToken has copy, drop, store {
        to_distribute: u64,
    }

    struct EventClaimed has copy, drop, store {
        id: 0x2::object::ID,
        epoch_start: u64,
        epoch_end: u64,
        amount: u64,
    }

    struct RewardDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        time_cursor_of: 0x2::table::Table<0x2::object::ID, u64>,
        last_token_time: u64,
        tokens_per_period: 0x2::table::Table<u64, u64>,
        token_last_balance: u64,
        balance: 0x2::balance::Balance<T0>,
        minter_active_period: u64,
    }

    public fun checkpoint_token<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T0>>(arg0));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        checkpoint_token_internal<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg3));
    }

    fun checkpoint_token_internal<T0>(arg0: &mut RewardDistributor<T0>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = v0 - arg0.token_last_balance;
        arg0.token_last_balance = v0;
        let v2 = arg0.last_token_time;
        let v3 = arg1 - v2;
        arg0.last_token_time = arg1;
        let v4 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::to_period(v2);
        let v5 = 0;
        while (v5 < 20) {
            let v6 = if (!0x2::table::contains<u64, u64>(&arg0.tokens_per_period, v4)) {
                0
            } else {
                0x2::table::remove<u64, u64>(&mut arg0.tokens_per_period, v4)
            };
            v4 = v4 + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::week();
            if (arg1 < v4) {
                if (v3 == 0 && arg1 == v2) {
                    0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v4, v6 + v1);
                    break
                } else {
                    0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v4, v6 + v1 * (arg1 - v2) / v3);
                    break
                };
            };
            if (v3 == 0 && v4 == v2) {
                0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v4, v6 + v1);
            } else {
                0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v4, v6 + v1 * (v4 - v2) / v3);
            };
            v5 = v5 + 1;
        };
        let v7 = EventCheckpointToken{to_distribute: v1};
        0x2::event::emit<EventCheckpointToken>(v7);
    }

    public fun claim<T0>(arg0: &mut RewardDistributor<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(arg2);
        assert!(arg0.minter_active_period >= 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_period(arg3), 9223372904438169601);
        assert!(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::is_locked(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 9223372908733267971);
        let v1 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::to_period(arg0.last_token_time);
        let v2 = claim_internal<T0>(arg0, arg1, v0, v1);
        if (v2 > 0) {
            let (v3, _) = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::locked<T0>(arg1, v0);
            let v5 = v3;
            if (0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg3) >= 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::end(&v5) && !0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::is_permanent(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg4), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::owner_of<T0>(arg1, v0));
            } else {
                0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::deposit_for<T0>(arg1, 0x1::option::none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::DistributorCap>(), arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg4), arg3, arg4);
            };
            arg0.token_last_balance = arg0.token_last_balance - v2;
        };
        v2
    }

    fun claim_internal<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let (v0, v1, v2) = claimable_internal<T0>(arg0, arg1, arg2, arg3);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.time_cursor_of, arg2);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.time_cursor_of, arg2, v2);
        if (v0 == 0) {
            return 0
        };
        let v3 = EventClaimed{
            id          : arg2,
            epoch_start : v1,
            epoch_end   : v2,
            amount      : v0,
        };
        0x2::event::emit<EventClaimed>(v3);
        v0
    }

    public fun claimable<T0>(arg0: &RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        let (v0, _, _) = claimable_internal<T0>(arg0, arg1, arg2, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::to_period(arg0.last_token_time));
        v0
    }

    fun claimable_internal<T0>(arg0: &RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID, arg3: u64) : (u64, u64, u64) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)
        } else {
            0
        };
        let v1 = v0;
        let v2 = v0;
        let v3 = 0;
        if (0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::user_point_epoch<T0>(arg1, arg2) == 0) {
            return (0, v0, v0)
        };
        if (v0 == 0) {
            let v4 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::user_point_history<T0>(arg1, arg2, 1);
            let v5 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::to_period(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::user_point_ts(&v4));
            v1 = v5;
            v2 = v5;
        };
        if (v1 >= arg3) {
            return (0, v2, v1)
        };
        if (v1 < arg0.start_time) {
            v1 = arg0.start_time;
        };
        let v6 = 0;
        while (v6 < 50) {
            if (v1 >= arg3) {
                break
            };
            let v7 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::total_supply_at<T0>(arg1, v1 + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::week() - 1);
            let v8 = if (v7 == 0) {
                1
            } else {
                v7
            };
            let v9 = if (0x2::table::contains<u64, u64>(&arg0.tokens_per_period, v1)) {
                *0x2::table::borrow<u64, u64>(&arg0.tokens_per_period, v1)
            } else {
                0
            };
            v3 = v3 + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::balance_of_nft_at<T0>(arg1, arg2, v1 + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::week() - 1) * v9 / v8;
            v1 = v1 + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::week();
            v6 = v6 + 1;
        };
        (v3, v1, v2)
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (RewardDistributor<T0>, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap) {
        let v0 = RewardDistributor<T0>{
            id                   : 0x2::object::new(arg2),
            start_time           : 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg1),
            time_cursor_of       : 0x2::table::new<0x2::object::ID, u64>(arg2),
            last_token_time      : 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg1),
            tokens_per_period    : 0x2::table::new<u64, u64>(arg2),
            token_last_balance   : 0,
            balance              : 0x2::balance::zero<T0>(),
            minter_active_period : 0,
        };
        (v0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::create(*0x2::object::uid_as_inner(&v0.id), arg2))
    }

    fun init(arg0: REWARD_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<REWARD_DISTRIBUTOR>(arg0, arg1);
    }

    public fun start<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T0>>(arg0));
        let v0 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg3);
        arg0.start_time = v0;
        arg0.last_token_time = v0;
        arg0.minter_active_period = arg2;
        let v1 = EventStart{dummy_field: false};
        0x2::event::emit<EventStart>(v1);
    }

    public(friend) fun update_active_period<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap, arg2: u64) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T0>>(arg0));
        arg0.minter_active_period = arg2;
    }

    // decompiled from Move bytecode v6
}

