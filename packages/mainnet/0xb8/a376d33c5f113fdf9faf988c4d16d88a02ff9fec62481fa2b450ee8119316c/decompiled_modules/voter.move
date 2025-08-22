module 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter {
    struct VOTER has drop {
        dummy_field: bool,
    }

    struct PoolID has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct LockID has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct GaugeID has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct VolumeVote has drop, store {
        volume: u64,
        votes: u64,
    }

    struct Voter has store, key {
        id: 0x2::object::UID,
        global_config: 0x2::object::ID,
        distribution_config: 0x2::object::ID,
        revoked_gauge_create_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        epoch_governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        used_weights: 0x2::table::Table<LockID, u64>,
        pools: vector<PoolID>,
        pool_to_gauger: 0x2::table::Table<PoolID, GaugeID>,
        votes: 0x2::table::Table<LockID, 0x2::table::Table<PoolID, VolumeVote>>,
        weights: 0x2::table::Table<GaugeID, u64>,
        epoch: u64,
        voter_cap: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap,
        balances: 0x2::bag::Bag,
        current_epoch_token: 0x1::option::Option<0x1::type_name::TypeName>,
        reward_tokens: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, bool>,
        whitelisted_manager: 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::WhitelistManager,
        whitelisted_manager_cap: 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::WhitelistManagerCap,
        is_whitelisted_nft: 0x2::table::Table<LockID, bool>,
        max_voting_num: u64,
        last_voted: 0x2::table::Table<LockID, u64>,
        pool_vote: 0x2::table::Table<LockID, vector<PoolID>>,
        gauge_to_fee: 0x2::table::Table<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>,
        exercise_fee_reward: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::ExerciseFeeReward,
        voting_escrow_cap: 0x1::option::Option<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>,
        bag: 0x2::bag::Bag,
    }

    struct EventNotifyEpochToken has copy, drop, store {
        notifier: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
    }

    struct EventWhitelistNFT has copy, drop, store {
        sender: address,
        id: 0x2::object::ID,
        listed: bool,
    }

    struct EventVoted has copy, drop, store {
        sender: address,
        pool: 0x2::object::ID,
        lock: 0x2::object::ID,
        voting_weight: u64,
        volume: u64,
        pool_weight: u64,
    }

    struct EventAbstained has copy, drop, store {
        sender: address,
        pool: 0x2::object::ID,
        lock: 0x2::object::ID,
        votes: u64,
        pool_weight: u64,
    }

    struct EventAddGovernor has copy, drop, store {
        who: address,
        cap: 0x2::object::ID,
    }

    struct EventRemoveGovernor has copy, drop, store {
        cap: 0x2::object::ID,
    }

    struct EventAddEpochGovernor has copy, drop, store {
        who: address,
        cap: 0x2::object::ID,
    }

    struct EventRemoveEpochGovernor has copy, drop, store {
        cap: 0x2::object::ID,
    }

    struct EventClaimBribeReward has copy, drop, store {
        who: address,
        amount: u64,
        pool: 0x2::object::ID,
        gauge: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        lock: 0x2::object::ID,
    }

    struct EventClaimVotingFeeReward has copy, drop, store {
        who: address,
        amount: u64,
        pool: 0x2::object::ID,
        gauge: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        lock: 0x2::object::ID,
    }

    struct EventClaimExerciseFeeReward has copy, drop, store {
        who: address,
        amount: u64,
        token: 0x1::type_name::TypeName,
        lock: 0x2::object::ID,
    }

    struct EventDistributeGauge has copy, drop, store {
        pool: 0x2::object::ID,
        gauge: 0x2::object::ID,
        fee_a_amount: u64,
        fee_b_amount: u64,
        usd_amount: u64,
        ended_epoch_o_sail_emission: u64,
    }

    public fun deposit_managed<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg4: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg3));
        assert_only_new_epoch(arg0, v0, arg5);
        assert!(0x1::option::is_some<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), 742033984283866600);
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::current_timestamp(arg5);
        assert!(v1 <= 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_vote_end(v1), 922337530103326315);
        if (0x2::table::contains<LockID, u64>(&arg0.last_voted, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.last_voted, v0);
        };
        0x2::table::add<LockID, u64>(&mut arg0.last_voted, v0, v1);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::deposit_managed<T0>(arg1, 0x1::option::borrow<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), arg3, arg4, arg5, arg6);
        let v2 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::balance_of_nft_at<T0>(arg1, v0.id, v1);
        poke_internal<T0>(arg0, arg1, arg2, into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg4)), v2, arg5, arg6);
    }

    public fun withdraw_managed<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg4: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg3));
        assert_only_new_epoch(arg0, v0, arg5);
        assert!(0x1::option::is_some<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), 445278511513513150);
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::id_to_managed<T0>(arg1, v0.id);
        assert!(v1 == 0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg4), 922337537833933209);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::validate_ownership<T0>(arg1, arg3, arg6);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::withdraw_managed<T0>(arg1, 0x1::option::borrow<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), arg3, arg4, arg5, arg6);
        let v2 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::balance_of_nft_at<T0>(arg1, v1, 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::current_timestamp(arg5));
        if (v2 == 0) {
            reset_internal<T0>(arg0, arg1, arg2, into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg4)), arg5, arg6);
            if (0x2::table::contains<LockID, u64>(&arg0.last_voted, into_lock_id(v1))) {
                0x2::table::remove<LockID, u64>(&mut arg0.last_voted, into_lock_id(v1));
            };
        } else {
            poke_internal<T0>(arg0, arg1, arg2, into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg4)), v2, arg5, arg6);
        };
    }

    public fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (Voter, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap) {
        assert!(0x2::package::from_module<VOTER>(arg0), 831911472280262500);
        let v0 = 0x2::object::new(arg3);
        let v1 = *0x2::object::uid_as_inner(&v0);
        let (v2, v3) = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::create(v1, arg3);
        let v4 = Voter{
            id                        : v0,
            global_config             : arg1,
            distribution_config       : arg2,
            revoked_gauge_create_caps : 0x2::vec_set::empty<0x2::object::ID>(),
            governors                 : 0x2::vec_set::empty<0x2::object::ID>(),
            epoch_governors           : 0x2::vec_set::empty<0x2::object::ID>(),
            used_weights              : 0x2::table::new<LockID, u64>(arg3),
            pools                     : 0x1::vector::empty<PoolID>(),
            pool_to_gauger            : 0x2::table::new<PoolID, GaugeID>(arg3),
            votes                     : 0x2::table::new<LockID, 0x2::table::Table<PoolID, VolumeVote>>(arg3),
            weights                   : 0x2::table::new<GaugeID, u64>(arg3),
            epoch                     : 0,
            voter_cap                 : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::create_voter_cap(v1, arg3),
            balances                  : 0x2::bag::new(arg3),
            current_epoch_token       : 0x1::option::none<0x1::type_name::TypeName>(),
            reward_tokens             : 0x2::linked_table::new<0x1::type_name::TypeName, bool>(arg3),
            whitelisted_manager       : v2,
            whitelisted_manager_cap   : v3,
            is_whitelisted_nft        : 0x2::table::new<LockID, bool>(arg3),
            max_voting_num            : 10,
            last_voted                : 0x2::table::new<LockID, u64>(arg3),
            pool_vote                 : 0x2::table::new<LockID, vector<PoolID>>(arg3),
            gauge_to_fee              : 0x2::table::new<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(arg3),
            exercise_fee_reward       : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::create(v1, 0x1::vector::empty<0x1::type_name::TypeName>(), arg3),
            voting_escrow_cap         : 0x1::option::none<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(),
            bag                       : 0x2::bag::new(arg3),
        };
        (v4, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::create_internal(v1, arg3))
    }

    public fun is_whitelisted_token<T0>(arg0: &Voter) : bool {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::is_whitelisted_token<T0>(&arg0.whitelisted_manager)
    }

    public fun prove_token_whitelisted<T0>(arg0: &Voter) : 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::WhitelistedToken {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::prove_token_whitelisted<T0>(&arg0.whitelisted_manager)
    }

    public fun whitelist_token<T0>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        assert!(is_governor(arg0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(arg1)), 922337389657712232);
        whitelist_token_internal(arg0, 0x1::type_name::get<T0>(), arg2, 0x2::tx_context::sender(arg3));
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::get_position_reward<T0, T1, T2>(arg3, arg4, &arg0.voter_cap, arg2, arg5, arg6, arg7)
    }

    public fun notify_epoch_token<T0>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.current_epoch_token, v0);
        0x2::object::id<Voter>(arg0);
        let v1 = EventNotifyEpochToken{
            notifier : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::who(arg1),
            token    : v0,
        };
        0x2::event::emit<EventNotifyEpochToken>(v1);
    }

    public fun add_epoch_governor(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_governor(arg0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(arg1)), 922337326521692981);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::create_epoch_governor_cap(0x2::object::id<Voter>(arg0), arg3);
        let v1 = 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::EpochGovernorCap>(&v0);
        0x2::transfer::public_transfer<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::EpochGovernorCap>(v0, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.epoch_governors, v1);
        let v2 = EventAddEpochGovernor{
            who : arg2,
            cap : v1,
        };
        0x2::event::emit<EventAddEpochGovernor>(v2);
    }

    public fun add_governor(arg0: &mut Voter, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<VOTER>(arg1), 155939257957301570);
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::create_governor_cap(0x2::object::id<Voter>(arg0), arg2, arg3);
        let v1 = 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.governors, v1);
        0x2::transfer::public_transfer<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(v0, arg2);
        let v2 = EventAddGovernor{
            who : arg2,
            cap : v1,
        };
        0x2::event::emit<EventAddGovernor>(v2);
    }

    fun assert_only_new_epoch(arg0: &Voter, arg1: LockID, arg2: &0x2::clock::Clock) {
        let v0 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::current_timestamp(arg2);
        assert!(v0 > 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_vote_start(v0), 922337333393679977);
    }

    public fun borrow_exercise_fee_reward(arg0: &Voter) : &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::ExerciseFeeReward {
        &arg0.exercise_fee_reward
    }

    public fun borrow_exercise_fee_reward_mut(arg0: &mut Voter) : &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::ExerciseFeeReward {
        &mut arg0.exercise_fee_reward
    }

    public fun borrow_fee_voting_reward(arg0: &Voter, arg1: 0x2::object::ID) : &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward {
        0x2::table::borrow<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1))
    }

    public fun borrow_fee_voting_reward_mut(arg0: &mut Voter, arg1: 0x2::object::ID) : &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward {
        0x2::table::borrow_mut<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(arg1))
    }

    public fun borrow_voter_cap(arg0: &Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap) : &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        &arg0.voter_cap
    }

    fun check_vote(arg0: &Voter, arg1: &vector<0x2::object::ID>, arg2: &vector<u64>, arg3: &vector<u64>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg1);
        assert!(v0 <= arg0.max_voting_num, 922337416716058627);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 922337416286430823);
        assert!(v0 == 0x1::vector::length<u64>(arg3), 379359304918467140);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(*0x1::vector::borrow<0x2::object::ID>(arg1, v1))), 922337418433927579);
            assert!(*0x1::vector::borrow<u64>(arg2, v1) <= 10000, 922337418863437416);
            v1 = v1 + 1;
        };
    }

    public fun claim_exercise_fee_reward<T0, T1>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg2));
        let v1 = EventClaimExerciseFeeReward{
            who    : 0x2::tx_context::sender(arg4),
            amount : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::get_reward<T0, T1>(&mut arg0.exercise_fee_reward, &arg0.voter_cap, arg1, arg2, arg3, arg4),
            token  : 0x1::type_name::get<T1>(),
            lock   : v0.id,
        };
        0x2::event::emit<EventClaimExerciseFeeReward>(v1);
    }

    public fun claim_voting_fee<T0, T1>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(arg3));
        let v1 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg2));
        let v2 = EventClaimVotingFeeReward{
            who    : 0x2::tx_context::sender(arg5),
            amount : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::get_reward<T0, T1>(0x2::table::borrow_mut<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, v0), &arg0.voter_cap, arg1, arg2, arg4, arg5),
            pool   : arg3,
            gauge  : v0.id,
            token  : 0x1::type_name::get<T1>(),
            lock   : v1.id,
        };
        0x2::event::emit<EventClaimVotingFeeReward>(v2);
    }

    public fun claim_voting_fee_by_pool<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T2>, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg3: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg3);
        claim_voting_fee<T2, T0>(arg0, arg1, arg2, v0, arg4, arg5);
        claim_voting_fee<T2, T1>(arg0, arg1, arg2, v0, arg4, arg5);
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &0xc543ef4485b43149ff6a4f3e8df3a0e9d7ea73ea25381b2948c8a6c3efc62672::gauge_cap::CreateCap, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg4: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T2>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1> {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg3, 0x2::object::id<Voter>(arg0));
        assert!(is_valid_gauge_create_cap(arg0, arg2), 951701448926939500);
        assert!(arg0.distribution_config == 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig>(arg1), 922337388798568038);
        assert!(0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::get_voter_id<T2>(arg4) == 0x2::object::id<Voter>(arg0), 247841512148847520);
        assert!(!0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg5))), 379600280551732200);
        let v0 = return_new_gauge<T0, T1>(arg1, arg2, arg5, arg7);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<T1>());
        let v2 = 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(&v0);
        0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T2>>(arg4);
        0x2::table::add<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(v2), 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::create(0x2::object::id<Voter>(arg0), v2, v1, arg7));
        let v3 = 0x1::type_name::get<T2>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v3)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v3);
        };
        let v4 = &mut v0;
        receive_gauger<T0, T1>(arg0, arg3, v4, arg6);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v5, v2);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::update_gauge_liveness(arg1, v5, true);
        v0
    }

    public(friend) fun distribute_gauge<T0, T1, T2>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(is_valid_epoch_token<T2>(arg0), 727114932399146200);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::is_gauge_alive(arg1, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(arg2)), 519025590138764600);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg2, arg3), 922337598392972083);
        let v0 = into_gauge_id(0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(arg2));
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::notify_epoch_token<T0, T1, T2>(arg2, arg1, arg3, &arg0.voter_cap, arg6, arg7);
        let (v2, v3) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::notify_reward<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::table::borrow_mut<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, v0);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::notify_reward_amount<T0>(v6, &arg0.voter_cap, 0x2::coin::from_balance<T0>(v5, arg7), arg6, arg7);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::notify_reward_amount<T1>(v6, &arg0.voter_cap, 0x2::coin::from_balance<T1>(v4, arg7), arg6, arg7);
        let v7 = EventDistributeGauge{
            pool                        : 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg3),
            gauge                       : v0.id,
            fee_a_amount                : 0x2::balance::value<T0>(&v5),
            fee_b_amount                : 0x2::balance::value<T1>(&v4),
            usd_amount                  : arg4,
            ended_epoch_o_sail_emission : v1,
        };
        0x2::event::emit<EventDistributeGauge>(v7);
        v1
    }

    public fun earned_exercise_fee<T0>(arg0: &Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::earned<T0>(&arg0.exercise_fee_reward, arg1, arg2)
    }

    public fun earned_voting_fee<T0>(arg0: &Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::earned<T0>(borrow_fee_voting_reward(arg0, pool_to_gauge(arg0, arg2)), arg1, arg3)
    }

    public fun fee_voting_reward_balance<T0>(arg0: &Voter, arg1: 0x2::object::ID) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::balance<T0>(0x2::table::borrow<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1)))
    }

    public fun get_balance<T0>(arg0: &Voter) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    public fun get_current_epoch_token(arg0: &Voter) : 0x1::type_name::TypeName {
        *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token)
    }

    public fun get_gauge_weight(arg0: &Voter, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<GaugeID, u64>(&arg0.weights, into_gauge_id(arg1))
    }

    public fun get_multiple_position_rewards<T0, T1, T2>(arg0: &Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &vector<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::get_reward<T0, T1, T2>(arg3, arg4, &arg0.voter_cap, arg2, arg5, arg6, arg7)
    }

    public fun get_pool_weight(arg0: &Voter, arg1: 0x2::object::ID) : u64 {
        let v0 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(arg1));
        get_gauge_weight(arg0, v0.id)
    }

    public fun get_votes(arg0: &Voter, arg1: 0x2::object::ID) : &0x2::table::Table<PoolID, VolumeVote> {
        let v0 = into_lock_id(arg1);
        assert!(0x2::table::contains<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, v0), 922337561885750067);
        0x2::table::borrow<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, v0)
    }

    fun init(arg0: VOTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VOTER>(arg0, arg1);
    }

    public fun inject_voting_fee_reward<T0>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::notify_reward_amount<T0>(0x2::table::borrow_mut<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(arg2)), &arg0.voter_cap, arg3, arg4, arg5);
    }

    public(friend) fun into_gauge_id(arg0: 0x2::object::ID) : GaugeID {
        GaugeID{id: arg0}
    }

    public(friend) fun into_lock_id(arg0: 0x2::object::ID) : LockID {
        LockID{id: arg0}
    }

    public(friend) fun into_pool_id(arg0: 0x2::object::ID) : PoolID {
        PoolID{id: arg0}
    }

    public fun is_epoch_governor(arg0: &Voter, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.epoch_governors, &arg1)
    }

    public fun is_governor(arg0: &Voter, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.governors, &arg1)
    }

    public fun is_valid_epoch_token<T0>(arg0: &Voter) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::object::id<Voter>(arg0);
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token) == &v0
    }

    public fun is_valid_gauge_create_cap(arg0: &Voter, arg1: &0xc543ef4485b43149ff6a4f3e8df3a0e9d7ea73ea25381b2948c8a6c3efc62672::gauge_cap::CreateCap) : bool {
        let v0 = 0x2::object::id<0xc543ef4485b43149ff6a4f3e8df3a0e9d7ea73ea25381b2948c8a6c3efc62672::gauge_cap::CreateCap>(arg1);
        !0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_gauge_create_caps, &v0)
    }

    public fun is_whitelisted_nft(arg0: &Voter, arg1: 0x2::object::ID) : bool {
        let v0 = into_lock_id(arg1);
        0x2::table::contains<LockID, bool>(&arg0.is_whitelisted_nft, v0) && *0x2::table::borrow<LockID, bool>(&arg0.is_whitelisted_nft, v0)
    }

    public fun lock_last_voted_at(arg0: &Voter, arg1: 0x2::object::ID) : u64 {
        let v0 = into_lock_id(arg1);
        if (!0x2::table::contains<LockID, u64>(&arg0.last_voted, v0)) {
            0
        } else {
            *0x2::table::borrow<LockID, u64>(&arg0.last_voted, v0)
        }
    }

    public fun notify_exercise_fee_reward_amount<T0>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::notify_reward_amount<T0>(&mut arg0.exercise_fee_reward, &arg0.voter_cap, arg2, arg3, arg4);
    }

    public(friend) fun notify_gauge_reward_without_claim<T0, T1>(arg0: &Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::is_gauge_alive(arg1, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(arg2)), 855951837524523600);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::notify_reward_without_claim<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7);
    }

    public fun poke<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::current_timestamp(arg4);
        assert!(v0 > 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_vote_start(v0), 922337443344842755);
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::get_voting_power<T0>(arg1, arg3, arg4);
        poke_internal<T0>(arg0, arg1, arg2, into_lock_id(arg3), v1, arg4, arg5);
    }

    fun poke_internal<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: LockID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, arg3)) {
            0x1::vector::length<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, arg3))
        } else {
            0
        };
        if (v0 > 0) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = 0x1::vector::empty<u64>();
            let v3 = 0;
            let v4 = 0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, arg3);
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            assert!(0x2::table::contains<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3), 922337451075875639);
            while (v3 < v0) {
                0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x1::vector::borrow<PoolID>(v4, v3).id);
                let v6 = 0x2::table::borrow<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3);
                assert!(0x2::table::contains<PoolID, VolumeVote>(v6, *0x1::vector::borrow<PoolID>(v4, v3)), 922337452793862558);
                let v7 = 0x2::table::borrow<PoolID, VolumeVote>(v6, *0x1::vector::borrow<PoolID>(v4, v3));
                0x1::vector::push_back<u64>(&mut v1, v7.votes);
                0x1::vector::push_back<u64>(&mut v2, v7.volume);
                v3 = v3 + 1;
            };
            vote_internal<T0>(arg0, arg1, arg2, arg3, arg4, v5, v1, v2, arg5, arg6);
        };
    }

    public fun pool_to_gauge(arg0: &Voter, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(arg1)).id
    }

    public fun pools_gauges(arg0: &Voter) : (vector<0x2::object::ID>, vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<PoolID>(&arg0.pools)) {
            let v3 = 0x1::vector::borrow<PoolID>(&arg0.pools, v2).id;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, pool_to_gauge(arg0, v3));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun receive_gauger<T0, T1>(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg3: &0x2::clock::Clock) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        let v0 = into_gauge_id(0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(arg2));
        let v1 = into_pool_id(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::pool_id<T0, T1>(arg2));
        assert!(!0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, v1), 922337372477987230);
        0x2::table::add<GaugeID, u64>(&mut arg0.weights, v0, 0);
        0x1::vector::push_back<PoolID>(&mut arg0.pools, v1);
        0x2::table::add<PoolID, GaugeID>(&mut arg0.pool_to_gauger, v1, v0);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::set_voter<T0, T1>(arg2, 0x2::object::id<Voter>(arg0));
    }

    public fun remove_epoch_governor(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap, arg2: 0x2::object::ID) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        assert!(is_governor(arg0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(arg1)), 922337331246157007);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.epoch_governors, &arg2);
        let v0 = EventRemoveEpochGovernor{cap: arg2};
        0x2::event::emit<EventRemoveEpochGovernor>(v0);
    }

    public fun remove_governor(arg0: &mut Voter, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<VOTER>(arg1), 774314565719218300);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.governors, &arg2);
        let v0 = EventRemoveGovernor{cap: arg2};
        0x2::event::emit<EventRemoveGovernor>(v0);
    }

    public fun reset<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg3));
        assert_only_new_epoch(arg0, v0, arg4);
        reset_internal<T0>(arg0, arg1, arg2, v0, arg4, arg5);
    }

    fun reset_internal<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: LockID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), 466338960180442200);
        let v0 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::balance_of(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::borrow_reward(&arg0.exercise_fee_reward), arg3.id, arg4);
        if (v0 > 0) {
            0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::withdraw(&mut arg0.exercise_fee_reward, &arg0.voter_cap, v0, arg3.id, arg4, arg5);
        };
        let v1 = if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, arg3)) {
            0x1::vector::length<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, arg3))
        } else {
            0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, arg3), v3);
            let v5 = 0x2::table::borrow<PoolID, VolumeVote>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3), v4).votes;
            let v6 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, v4);
            if (v5 != 0) {
                0x2::table::add<GaugeID, u64>(&mut arg0.weights, v6, 0x2::table::remove<GaugeID, u64>(&mut arg0.weights, v6) - v5);
                0x2::table::remove<PoolID, VolumeVote>(0x2::table::borrow_mut<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&mut arg0.votes, arg3), v4);
                v2 = v2 + v5;
                let v7 = EventAbstained{
                    sender      : 0x2::tx_context::sender(arg5),
                    pool        : v4.id,
                    lock        : arg3.id,
                    votes       : v5,
                    pool_weight : *0x2::table::borrow<GaugeID, u64>(&arg0.weights, v6),
                };
                0x2::event::emit<EventAbstained>(v7);
            };
            v3 = v3 + 1;
        };
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::voting<T0>(arg1, 0x1::option::borrow<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), arg3.id, false);
        if (0x2::table::contains<LockID, u64>(&arg0.used_weights, arg3)) {
            0x2::table::remove<LockID, u64>(&mut arg0.used_weights, arg3);
        };
        if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, arg3)) {
            0x2::table::remove<LockID, vector<PoolID>>(&mut arg0.pool_vote, arg3);
        };
    }

    fun return_new_gauge<T0, T1>(arg0: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg1: &0xc543ef4485b43149ff6a4f3e8df3a0e9d7ea73ea25381b2948c8a6c3efc62672::gauge_cap::CreateCap, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1> {
        let v0 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg2);
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::create<T0, T1>(arg0, v0, arg3);
        let v2 = 0xc543ef4485b43149ff6a4f3e8df3a0e9d7ea73ea25381b2948c8a6c3efc62672::gauge_cap::create_gauge_cap(arg1, v0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>>(&v1), arg3);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::init_fullsail_distribution_gauge<T0, T1>(arg2, &v2);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::receive_gauge_cap<T0, T1>(&mut v1, v2);
        v1
    }

    public fun revoke_gauge_create_cap(arg0: &mut Voter, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<VOTER>(arg1), 740613477966525400);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_gauge_create_caps, &arg2), 525186290931396700);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_gauge_create_caps, arg2);
    }

    public fun set_max_voting_num(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap, arg2: u64) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        assert!(is_governor(arg0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(arg1)), 922337318361255119);
        assert!(arg2 >= 10, 922337318790764956);
        assert!(arg2 != arg0.max_voting_num, 922337319649594572);
        arg0.max_voting_num = arg2;
    }

    public fun set_voting_escrow_cap(arg0: &mut Voter, arg1: &0x2::package::Publisher, arg2: 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap) {
        assert!(0x2::package::from_module<VOTER>(arg1), 180901439185181760);
        0x1::option::fill<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&mut arg0.voting_escrow_cap, arg2);
    }

    public fun update_exercise_fee_weights(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::update_balances(&mut arg0.exercise_fee_reward, &arg0.voter_cap, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_voted_weights(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::DistributeCap, arg2: 0x2::object::ID, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribute_cap::validate_distribute_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::update_balances(0x2::table::borrow_mut<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(arg2)), &arg0.voter_cap, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun used_weights(arg0: &Voter, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<LockID, u64>(&arg0.used_weights, into_lock_id(arg1))
    }

    public fun vote<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg3));
        assert_only_new_epoch(arg0, v0, arg7);
        check_vote(arg0, &arg4, &arg5, &arg6);
        assert!(!0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::deactivated<T0>(arg1, v0.id), 922337463101718531);
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::current_timestamp(arg7);
        let v2 = v1 > 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_vote_end(v1) && (!0x2::table::contains<LockID, bool>(&arg0.is_whitelisted_nft, v0) || *0x2::table::borrow<LockID, bool>(&arg0.is_whitelisted_nft, v0) == false);
        assert!(!v2, 922337464819718557);
        if (0x2::table::contains<LockID, u64>(&arg0.last_voted, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.last_voted, v0);
        };
        0x2::table::add<LockID, u64>(&mut arg0.last_voted, v0, v1);
        let v3 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::get_voting_power<T0>(arg1, v0.id, arg7);
        assert!(v3 > 0, 922337468685202231);
        vote_internal<T0>(arg0, arg1, arg2, v0, v3, arg4, arg5, arg6, arg7, arg8);
    }

    fun vote_internal<T0>(arg0: &mut Voter, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: LockID, arg4: u64, arg5: vector<0x2::object::ID>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), 120698940230993040);
        reset_internal<T0>(arg0, arg1, arg2, arg3, arg8, arg9);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::exercise_fee_reward::deposit(&mut arg0.exercise_fee_reward, &arg0.voter_cap, arg4, arg3.id, arg8, arg9);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<0x2::object::ID>(&arg5);
        while (v2 < v3) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg6, v2);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v3) {
            let v4 = into_pool_id(*0x1::vector::borrow<0x2::object::ID>(&arg5, v2));
            assert!(0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, v4), 922337479851920589);
            let v5 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, v4);
            assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::is_gauge_alive(arg2, v5.id), 922337480710992693);
            let v6 = if (*0x1::vector::borrow<u64>(&arg6, v2) == 0) {
                0
            } else {
                0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(*0x1::vector::borrow<u64>(&arg6, v2), arg4, v0)
            };
            let v7 = if (0x2::table::contains<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3)) {
                if (0x2::table::contains<PoolID, VolumeVote>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3), v4)) {
                    0x2::table::borrow<PoolID, VolumeVote>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3), v4).votes != 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(!v7, 922337483288104144);
            assert!(v6 > 0, 922337484147110711);
            if (!0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, arg3)) {
                0x2::table::add<LockID, vector<PoolID>>(&mut arg0.pool_vote, arg3, 0x1::vector::empty<PoolID>());
            };
            0x1::vector::push_back<PoolID>(0x2::table::borrow_mut<LockID, vector<PoolID>>(&mut arg0.pool_vote, arg3), v4);
            let v8 = if (0x2::table::contains<GaugeID, u64>(&arg0.weights, v5)) {
                0x2::table::remove<GaugeID, u64>(&mut arg0.weights, v5)
            } else {
                0
            };
            0x2::table::add<GaugeID, u64>(&mut arg0.weights, v5, v8 + v6);
            if (!0x2::table::contains<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&arg0.votes, arg3)) {
                0x2::table::add<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&mut arg0.votes, arg3, 0x2::table::new<PoolID, VolumeVote>(arg9));
            };
            let v9 = 0x2::table::borrow_mut<LockID, 0x2::table::Table<PoolID, VolumeVote>>(&mut arg0.votes, arg3);
            let v10 = if (0x2::table::contains<PoolID, VolumeVote>(v9, v4)) {
                let VolumeVote {
                    volume : _,
                    votes  : v12,
                } = 0x2::table::remove<PoolID, VolumeVote>(v9, v4);
                v12
            } else {
                0
            };
            let v13 = VolumeVote{
                volume : *0x1::vector::borrow<u64>(&arg7, v2),
                votes  : v10 + v6,
            };
            0x2::table::add<PoolID, VolumeVote>(v9, v4, v13);
            v1 = v1 + v6;
            let v14 = EventVoted{
                sender        : 0x2::tx_context::sender(arg9),
                pool          : v4.id,
                lock          : arg3.id,
                voting_weight : v6,
                volume        : *0x1::vector::borrow<u64>(&arg7, v2),
                pool_weight   : *0x2::table::borrow<GaugeID, u64>(&arg0.weights, v5),
            };
            0x2::event::emit<EventVoted>(v14);
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::voting<T0>(arg1, 0x1::option::borrow<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow_cap::VotingEscrowCap>(&arg0.voting_escrow_cap), arg3.id, true);
        };
        if (0x2::table::contains<LockID, u64>(&arg0.used_weights, arg3)) {
            0x2::table::remove<LockID, u64>(&mut arg0.used_weights, arg3);
        };
        0x2::table::add<LockID, u64>(&mut arg0.used_weights, arg3, v1);
    }

    public fun voted_pools(arg0: &Voter, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = into_lock_id(arg1);
        let v2 = if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, v1)) {
            0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, v1)
        } else {
            let v3 = 0x1::vector::empty<PoolID>();
            &v3
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<PoolID>(v2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1::vector::borrow<PoolID>(v2, v4).id);
            v4 = v4 + 1;
        };
        v0
    }

    public fun voting_fee_rewards_at_epoch<T0>(arg0: &Voter, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::rewards_at_epoch<T0>(0x2::table::borrow<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1)), arg2)
    }

    public fun voting_fee_rewards_this_epoch<T0>(arg0: &Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::rewards_this_epoch<T0>(0x2::table::borrow<GaugeID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1)), arg2)
    }

    public fun whitelist_nft(arg0: &mut Voter, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter>(arg0));
        assert!(is_governor(arg0, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::GovernorCap>(arg1)), 922337395670666447);
        let v0 = into_lock_id(arg2);
        if (0x2::table::contains<LockID, bool>(&arg0.is_whitelisted_nft, v0)) {
            0x2::table::remove<LockID, bool>(&mut arg0.is_whitelisted_nft, v0);
        };
        0x2::table::add<LockID, bool>(&mut arg0.is_whitelisted_nft, v0, arg3);
        let v1 = EventWhitelistNFT{
            sender : 0x2::tx_context::sender(arg4),
            id     : arg2,
            listed : arg3,
        };
        0x2::event::emit<EventWhitelistNFT>(v1);
    }

    fun whitelist_token_internal(arg0: &mut Voter, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: address) {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::whitelisted_tokens::whitelist_token(&mut arg0.whitelisted_manager, &arg0.whitelisted_manager_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

