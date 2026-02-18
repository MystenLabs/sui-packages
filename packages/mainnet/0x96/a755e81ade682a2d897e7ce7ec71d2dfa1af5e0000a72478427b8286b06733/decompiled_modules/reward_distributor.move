module 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor {
    struct REWARD_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct EventStart has copy, drop, store {
        dummy_field: bool,
    }

    struct EventCheckpointToken has copy, drop, store {
        wrapper_distributor_id: 0x2::object::ID,
        to_distribute: u64,
        timestamp: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventClaimed has copy, drop, store {
        wrapper_distributor_id: 0x2::object::ID,
        id: 0x2::object::ID,
        epoch_start: u64,
        epoch_end: u64,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct RewardDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        wrapper_distributor_id: 0x2::object::ID,
        start_time: u64,
        time_cursor_of: 0x2::table::Table<0x2::object::ID, u64>,
        last_token_time: u64,
        tokens_per_period: 0x2::table::Table<u64, u64>,
        token_last_balance: u64,
        balance: 0x2::balance::Balance<T0>,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &RewardDistributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun check_voting_escrow_id<T0>(arg0: &RewardDistributor<T0>, arg1: 0x2::object::ID) {
        if (0x2::bag::contains<u8>(&arg0.bag, 1)) {
            assert!(*0x2::bag::borrow<u8, 0x2::object::ID>(&arg0.bag, 1) == arg1, 579201231184384600);
        };
    }

    public fun checkpoint_token<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T0>>(arg0));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        checkpoint_token_internal<T0>(arg0, 0x2::coin::value<T0>(&arg2), 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg3));
    }

    fun checkpoint_token_internal<T0>(arg0: &mut RewardDistributor<T0>, arg1: u64, arg2: u64) {
        let v0 = arg0.last_token_time;
        let v1 = arg2 - v0;
        let v2 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::to_period(v0);
        let v3 = 0;
        while (v3 < 20) {
            let v4 = if (!0x2::table::contains<u64, u64>(&arg0.tokens_per_period, v2)) {
                0
            } else {
                0x2::table::remove<u64, u64>(&mut arg0.tokens_per_period, v2)
            };
            v2 = v2 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch();
            if (arg2 < v2) {
                if (v1 == 0 && arg2 == v0) {
                    0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v2, v4 + arg1);
                    break
                } else {
                    0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v2, v4 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg1, arg2 - v0, v1));
                    break
                };
            };
            if (v1 == 0 && v2 == v0) {
                0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v2, v4 + arg1);
            } else {
                0x2::table::add<u64, u64>(&mut arg0.tokens_per_period, v2, v4 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg1, v2 - v0, v1));
            };
            v3 = v3 + 1;
        };
        arg0.token_last_balance = 0x2::balance::value<T0>(&arg0.balance);
        arg0.last_token_time = arg2;
        let v5 = EventCheckpointToken{
            wrapper_distributor_id : arg0.wrapper_distributor_id,
            to_distribute          : arg1,
            timestamp              : arg2,
            token_type             : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventCheckpointToken>(v5);
    }

    public fun claim<T0, T1>(arg0: &mut RewardDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap, arg2: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T1>>(arg0));
        check_voting_escrow_id<T1>(arg0, 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>>(arg2));
        let v0 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::to_period(arg0.last_token_time);
        let v1 = claim_internal<T0, T1>(arg0, arg2, arg3, v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, v1), arg4)
    }

    fun claim_internal<T0, T1>(arg0: &mut RewardDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let (v0, v1, v2) = claimable_internal<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.time_cursor_of, arg2);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.time_cursor_of, arg2, v2);
        if (v0 == 0) {
            return 0
        };
        let v3 = EventClaimed{
            wrapper_distributor_id : arg0.wrapper_distributor_id,
            id                     : arg2,
            epoch_start            : v1,
            epoch_end              : v2,
            amount                 : v0,
            token_type             : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventClaimed>(v3);
        v0
    }

    public fun claimable<T0, T1>(arg0: &RewardDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        check_voting_escrow_id<T1>(arg0, 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>>(arg1));
        let (v0, _, _) = claimable_internal<T0, T1>(arg0, arg1, arg2, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::to_period(arg0.last_token_time));
        v0
    }

    fun claimable_internal<T0, T1>(arg0: &RewardDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID, arg3: u64) : (u64, u64, u64) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.time_cursor_of, arg2)
        } else {
            0
        };
        let v1 = v0;
        let v2 = v0;
        let v3 = 0;
        if (0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::user_point_epoch<T0>(arg1, arg2) == 0) {
            return (0, v0, v0)
        };
        if (v0 == 0) {
            let v4 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::user_point_history<T0>(arg1, arg2, 1);
            let v5 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::to_period(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::user_point_ts(&v4));
            v1 = v5;
            v2 = v5;
        };
        if (v1 >= arg3) {
            return (0, v2, v1)
        };
        if (v1 < arg0.start_time) {
            v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::to_period(arg0.start_time);
        };
        let v6 = 0;
        while (v6 < 50) {
            if (v1 >= arg3) {
                break
            };
            let v7 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::total_supply_at<T0>(arg1, v1 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() - 1);
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
            v3 = v3 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::balance_of_nft_at<T0>(arg1, arg2, v1 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() - 1), v9, v8);
            v1 = v1 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch();
            v6 = v6 + 1;
        };
        (v3, v2, v1)
    }

    public fun create<T0>(arg0: 0x2::object::ID, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (RewardDistributor<T0>, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap) {
        let v0 = RewardDistributor<T0>{
            id                     : 0x2::object::new(arg2),
            wrapper_distributor_id : arg0,
            start_time             : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg1),
            time_cursor_of         : 0x2::table::new<0x2::object::ID, u64>(arg2),
            last_token_time        : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg1),
            tokens_per_period      : 0x2::table::new<u64, u64>(arg2),
            token_last_balance     : 0,
            balance                : 0x2::balance::zero<T0>(),
            bag                    : 0x2::bag::new(arg2),
        };
        (v0, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::create(*0x2::object::uid_as_inner(&v0.id), arg2))
    }

    public fun create_v2<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (RewardDistributor<T0>, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap) {
        let v0 = 0x2::bag::new(arg3);
        0x2::bag::add<u8, 0x2::object::ID>(&mut v0, 1, arg1);
        let v1 = RewardDistributor<T0>{
            id                     : 0x2::object::new(arg3),
            wrapper_distributor_id : arg0,
            start_time             : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg2),
            time_cursor_of         : 0x2::table::new<0x2::object::ID, u64>(arg3),
            last_token_time        : 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg2),
            tokens_per_period      : 0x2::table::new<u64, u64>(arg3),
            token_last_balance     : 0,
            balance                : 0x2::balance::zero<T0>(),
            bag                    : v0,
        };
        (v1, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::create(*0x2::object::uid_as_inner(&v1.id), arg3))
    }

    public fun last_token_time<T0>(arg0: &RewardDistributor<T0>) : u64 {
        arg0.last_token_time
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun start<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap, arg2: &0x2::clock::Clock) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::validate(arg1, 0x2::object::id<RewardDistributor<T0>>(arg0));
        assert!(0x2::table::is_empty<u64, u64>(&arg0.tokens_per_period), 83171767535347600);
        let v0 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg2);
        arg0.start_time = v0;
        arg0.last_token_time = v0;
        let v1 = EventStart{dummy_field: false};
        0x2::event::emit<EventStart>(v1);
    }

    public fun start_time<T0>(arg0: &RewardDistributor<T0>) : u64 {
        arg0.start_time
    }

    public fun tokens_per_period<T0>(arg0: &RewardDistributor<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.tokens_per_period, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.tokens_per_period, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

