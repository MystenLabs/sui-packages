module 0x50ffb58d2c2d2458f8358e4cb29ee1d2f4062c228f1fcc1d7cf874f8b0935c3d::stride_move {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StrideFiPlatform has key {
        id: 0x2::object::UID,
        total_challenges: u64,
        total_participants: u64,
        total_sui_staked: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        challenges: 0x2::table::Table<0x2::object::ID, ChallengeInfo>,
    }

    struct ChallengeInfo has drop, store {
        creator: address,
        stake_amount: u64,
        total_pool: u64,
        participant_count: u64,
        is_active: bool,
    }

    struct Challenge has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        stake_amount: u64,
        duration_days: u64,
        start_time: u64,
        end_time: u64,
        creator: address,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        participants: 0x2::table::Table<address, Participant>,
        participant_count: u64,
        is_active: bool,
        is_finalized: bool,
        daily_step_goal: u64,
    }

    struct Participant has store {
        joined_at: u64,
        stake: u64,
        daily_steps: vector<u64>,
        is_successful: bool,
        has_claimed: bool,
    }

    struct ParticipationBadge has key {
        id: 0x2::object::UID,
        challenge_id: 0x2::object::ID,
        challenge_name: 0x1::string::String,
        participant: address,
        stake_amount: u64,
        completed: bool,
        reward_earned: u64,
    }

    struct ChallengeCreated has copy, drop {
        challenge_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        stake_amount: u64,
        duration_days: u64,
        daily_step_goal: u64,
    }

    struct ParticipantJoined has copy, drop {
        challenge_id: 0x2::object::ID,
        participant: address,
        stake_amount: u64,
    }

    struct StepsSubmitted has copy, drop {
        challenge_id: 0x2::object::ID,
        participant: address,
        day: u64,
        steps: u64,
    }

    struct ChallengeFinalized has copy, drop {
        challenge_id: 0x2::object::ID,
        winner_count: u64,
        total_pool: u64,
    }

    struct RewardClaimed has copy, drop {
        challenge_id: 0x2::object::ID,
        participant: address,
        reward_amount: u64,
    }

    entry fun claim_reward(arg0: &mut StrideFiPlatform, arg1: &mut Challenge, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<Challenge>(arg1);
        assert!(!arg1.is_active, 0);
        assert!(arg1.is_finalized, 6);
        assert!(0x2::table::contains<address, Participant>(&arg1.participants, v0), 4);
        let v2 = 0x2::table::borrow_mut<address, Participant>(&mut arg1.participants, v0);
        assert!(!v2.has_claimed, 7);
        assert!(v2.is_successful, 4);
        v2.has_claimed = true;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pool);
        let v4 = v3 * 250 / 10000;
        let v5 = v3 - v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, v5), arg2), v0);
        let v6 = ParticipationBadge{
            id             : 0x2::object::new(arg2),
            challenge_id   : v1,
            challenge_name : arg1.name,
            participant    : v0,
            stake_amount   : v2.stake,
            completed      : true,
            reward_earned  : v5,
        };
        0x2::transfer::transfer<ParticipationBadge>(v6, v0);
        let v7 = RewardClaimed{
            challenge_id  : v1,
            participant   : v0,
            reward_amount : v5,
        };
        0x2::event::emit<RewardClaimed>(v7);
    }

    entry fun create_challenge(arg0: &mut StrideFiPlatform, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1000000000, 2);
        assert!(arg4 >= 1 && arg4 <= 30, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg3, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = Challenge{
            id                : 0x2::object::new(arg8),
            name              : 0x1::string::utf8(arg1),
            description       : 0x1::string::utf8(arg2),
            stake_amount      : arg3,
            duration_days     : arg4,
            start_time        : v1,
            end_time          : v1 + arg4 * 24 * 60 * 60 * 1000,
            creator           : v0,
            pool              : 0x2::coin::into_balance<0x2::sui::SUI>(arg6),
            participants      : 0x2::table::new<address, Participant>(arg8),
            participant_count : 1,
            is_active         : true,
            is_finalized      : false,
            daily_step_goal   : arg5,
        };
        let v3 = 0x2::object::id<Challenge>(&v2);
        let v4 = Participant{
            joined_at     : v1,
            stake         : arg3,
            daily_steps   : 0x1::vector::empty<u64>(),
            is_successful : false,
            has_claimed   : false,
        };
        0x2::table::add<address, Participant>(&mut v2.participants, v0, v4);
        arg0.total_challenges = arg0.total_challenges + 1;
        arg0.total_participants = arg0.total_participants + 1;
        arg0.total_sui_staked = arg0.total_sui_staked + arg3;
        let v5 = ChallengeInfo{
            creator           : v0,
            stake_amount      : arg3,
            total_pool        : arg3,
            participant_count : 1,
            is_active         : true,
        };
        0x2::table::add<0x2::object::ID, ChallengeInfo>(&mut arg0.challenges, v3, v5);
        let v6 = ChallengeCreated{
            challenge_id    : v3,
            creator         : v0,
            name            : 0x1::string::utf8(arg1),
            stake_amount    : arg3,
            duration_days   : arg4,
            daily_step_goal : arg5,
        };
        0x2::event::emit<ChallengeCreated>(v6);
        0x2::transfer::share_object<Challenge>(v2);
    }

    entry fun finalize_challenge(arg0: &mut StrideFiPlatform, arg1: &mut Challenge, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 6);
        assert!(!arg1.is_finalized, 7);
        arg1.is_active = false;
        arg1.is_finalized = true;
        let v0 = 0x2::object::id<Challenge>(arg1);
        0x2::table::borrow_mut<0x2::object::ID, ChallengeInfo>(&mut arg0.challenges, v0).is_active = false;
        let v1 = ChallengeFinalized{
            challenge_id : v0,
            winner_count : 0,
            total_pool   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool),
        };
        0x2::event::emit<ChallengeFinalized>(v1);
    }

    public fun get_challenge_pool(arg0: &Challenge) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun get_participant_count(arg0: &Challenge) : u64 {
        arg0.participant_count
    }

    public fun get_platform_stats(arg0: &StrideFiPlatform) : (u64, u64, u64) {
        (arg0.total_challenges, arg0.total_participants, arg0.total_sui_staked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StrideFiPlatform{
            id                 : 0x2::object::new(arg0),
            total_challenges   : 0,
            total_participants : 0,
            total_sui_staked   : 0,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            challenges         : 0x2::table::new<0x2::object::ID, ChallengeInfo>(arg0),
        };
        0x2::transfer::share_object<StrideFiPlatform>(v1);
    }

    public fun is_challenge_active(arg0: &Challenge) : bool {
        arg0.is_active
    }

    entry fun join_challenge(arg0: &mut StrideFiPlatform, arg1: &mut Challenge, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.is_active, 0);
        assert!(v1 < arg1.end_time, 1);
        assert!(!0x2::table::contains<address, Participant>(&arg1.participants, v0), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.stake_amount, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = Participant{
            joined_at     : v1,
            stake         : arg1.stake_amount,
            daily_steps   : 0x1::vector::empty<u64>(),
            is_successful : false,
            has_claimed   : false,
        };
        0x2::table::add<address, Participant>(&mut arg1.participants, v0, v2);
        arg1.participant_count = arg1.participant_count + 1;
        arg0.total_participants = arg0.total_participants + 1;
        arg0.total_sui_staked = arg0.total_sui_staked + arg1.stake_amount;
        let v3 = 0x2::object::id<Challenge>(arg1);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, ChallengeInfo>(&mut arg0.challenges, v3);
        v4.total_pool = v4.total_pool + arg1.stake_amount;
        v4.participant_count = v4.participant_count + 1;
        let v5 = ParticipantJoined{
            challenge_id : v3,
            participant  : v0,
            stake_amount : arg1.stake_amount,
        };
        0x2::event::emit<ParticipantJoined>(v5);
    }

    entry fun submit_steps(arg0: &mut Challenge, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.is_active, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 1);
        assert!(0x2::table::contains<address, Participant>(&arg0.participants, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, Participant>(&mut arg0.participants, v0);
        0x1::vector::push_back<u64>(&mut v1.daily_steps, arg1);
        let v2 = StepsSubmitted{
            challenge_id : 0x2::object::id<Challenge>(arg0),
            participant  : v0,
            day          : 0x1::vector::length<u64>(&v1.daily_steps),
            steps        : arg1,
        };
        0x2::event::emit<StepsSubmitted>(v2);
    }

    // decompiled from Move bytecode v6
}

