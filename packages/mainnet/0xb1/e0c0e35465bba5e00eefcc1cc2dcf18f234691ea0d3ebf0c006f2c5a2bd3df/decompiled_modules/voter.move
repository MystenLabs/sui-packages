module 0x228638b6ea17788e34971afee4b4580dbc4dcaa847ef62604d858ef5d3beb5a6::voter {
    struct EventDistributeReward has copy, drop, store {
        sender: address,
        gauge: 0x2::object::ID,
        amount: u64,
    }

    struct EventFeeRewardTokens has copy, drop, store {
        lock_id: 0x2::object::ID,
        list: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x1::type_name::TypeName>>,
    }

    struct EventBribeRewardTokens has copy, drop, store {
        lock_id: 0x2::object::ID,
        list: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x1::type_name::TypeName>>,
    }

    struct EventRewardAPR has copy, drop, store {
        total_supply: u64,
        rewards: u64,
    }

    struct EventAddBribeReward has copy, drop {
        pool: 0x2::object::ID,
        gauge: 0x2::object::ID,
        amount: u64,
        token: 0x1::type_name::TypeName,
    }

    struct ClaimableVotingFee has copy, drop, store {
        lock_id: 0x2::object::ID,
        data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>,
    }

    struct ClaimableVotingBribes has copy, drop, store {
        lock_id: 0x2::object::ID,
        data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>,
    }

    struct PoolWeight has copy, drop, store {
        id: 0x2::object::ID,
        weight: u64,
    }

    struct PoolsTally has copy, drop, store {
        list: vector<PoolWeight>,
    }

    struct EventPoolGauge has copy, drop {
        pools: vector<0x2::object::ID>,
        gauges: vector<0x2::object::ID>,
    }

    struct EventPoolIncentivesAmount has copy, drop, store {
        pool_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EventLockVotingStats has copy, drop, store {
        lock_id: 0x2::object::ID,
        last_voted_at: u64,
        pools: vector<0x2::object::ID>,
        votes: vector<u64>,
    }

    struct EventVoterTokenWhitelisted has copy, drop, store {
        token: 0x1::type_name::TypeName,
        whitelisted: bool,
    }

    public entry fun add_bribe_reward<T0, T1>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::notify_reward_amount<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward_mut<T0>(arg0, v0), 0x1::option::some<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::whitelisted_tokens::WhitelistedToken>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::prove_token_whitelisted<T0, T1>(arg0)), arg2, arg3, arg4);
        let v1 = EventAddBribeReward{
            pool   : arg1,
            gauge  : v0,
            amount : 0x2::coin::value<T1>(&arg2),
            token  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventAddBribeReward>(v1);
    }

    public fun claim_voting_bribes<T0, T1>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: vector<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2)) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T1>(arg0, arg1, 0x1::vector::borrow<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2) > 0) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_2<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: vector<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2, v0);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2) > 0) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_3<T0, T1, T2, T3>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: vector<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2, v0);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_bribe<T0, T3>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2) > 0) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_for_single_pool<T0, T1, T2, T3>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg3);
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_fee_voting_reward_mut<T0>(arg0, v0);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T1>(v1, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T2>(v1, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T3>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward_mut<T0>(arg0, v0), arg1, arg2, arg4, arg5);
    }

    public fun claim_voting_bribes_for_single_pool2<T0, T1, T2, T3, T4>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg3);
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_fee_voting_reward_mut<T0>(arg0, v0);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T1>(v1, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T2>(v1, arg1, arg2, arg4, arg5);
        let v2 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward_mut<T0>(arg0, v0);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T3>(v2, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T4>(v2, arg1, arg2, arg4, arg5);
    }

    public fun claim_voting_bribes_for_single_pool3<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg3);
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_fee_voting_reward_mut<T0>(arg0, v0);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T1>(v1, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::get_reward<T0, T2>(v1, arg1, arg2, arg4, arg5);
        let v2 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward_mut<T0>(arg0, v0);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T3>(v2, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T4>(v2, arg1, arg2, arg4, arg5);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::get_reward<T0, T5>(v2, arg1, arg2, arg4, arg5);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: vector<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2, v0);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&arg2) > 0) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg2: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claimable_voting_bribes<T0, T1>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{
            lock_id : arg1,
            data    : v0,
        };
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_2<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{
            lock_id : arg1,
            data    : v0,
        };
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_3<T0, T1, T2, T3>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T3>(), claimable_voting_bribes_internal<T0, T3>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{
            lock_id : arg1,
            data    : v0,
        };
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    fun claimable_voting_bribes_internal<T0, T1>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::voted_pools<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v3, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::earned<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, v3)), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    fun claimable_voting_fee_internal<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (0x2::vec_map::VecMap<0x2::object::ID, u64>, 0x2::vec_map::VecMap<0x2::object::ID, u64>) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::voted_pools<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        let v3 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            let v5 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_fee_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, v4));
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v4, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::earned<T1>(v5, arg1, arg2));
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v3, v4, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::earned<T2>(v5, arg1, arg2));
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public fun claimable_voting_fee_rewards<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let (v0, v1) = claimable_voting_fee_internal<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v2, 0x1::type_name::get<T1>(), v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v2, 0x1::type_name::get<T2>(), v1);
        let v3 = ClaimableVotingFee{
            lock_id : arg1,
            data    : v2,
        };
        0x2::event::emit<ClaimableVotingFee>(v3);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg3: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let (v1, v2) = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::create<T0>(arg0, arg1, 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig>(arg2), 0x2::object::id<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig>(arg3), v0, arg4);
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>>(v1);
        0x2::transfer::public_transfer<0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::notify_reward_cap::NotifyRewardCap>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T2>, arg2: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::CreateCap, arg3: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::governor_cap::GovernorCap, arg4: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T2>, arg5: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::create_gauge<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun distribute<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::Minter<T2>, arg2: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T2>, arg3: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T2>, arg4: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward_distributor::RewardDistributor<T2>, arg5: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg6: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::active_period<T2>(arg1) + 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::common::week() < 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::common::current_timestamp(arg7)) {
            0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::update_period<T2>(arg1, arg2, arg3, arg4, arg7, arg8);
        };
        assert!(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::pool_id<T0, T1, T2>(arg5) == 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>>(arg6), 9223373505733591039);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg8),
            gauge  : 0x2::object::id<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>>(arg5),
            amount : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::distribute_gauge<T0, T1, T2>(arg2, arg0, arg5, arg6, arg7, arg8),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun epoch_reward_by_pool<T0, T1>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1))), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v0);
    }

    public entry fun epoch_reward_by_pool2<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1);
        let v1 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v1);
        let v2 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T2>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T2>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v2);
    }

    public entry fun epoch_reward_by_pool3<T0, T1, T2, T3>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1);
        let v1 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v1);
        let v2 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T2>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T2>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v2);
        let v3 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T3>(),
            amount  : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T3>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v3);
    }

    public entry fun get_voting_bribe_reward_apr_by_pool<T0, T1>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1)));
        let v1 = EventRewardAPR{
            total_supply : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::total_supply(v0),
            rewards      : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_this_epoch<T1>(v0, arg2),
        };
        0x2::event::emit<EventRewardAPR>(v1);
    }

    public entry fun get_voting_bribe_reward_tokens<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_list(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventBribeRewardTokens{
            lock_id : arg1,
            list    : v0,
        };
        0x2::event::emit<EventBribeRewardTokens>(v3);
    }

    public entry fun get_voting_bribe_reward_tokens_by_pool<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, arg1, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_list(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1)))));
        let v1 = EventBribeRewardTokens{
            lock_id : 0x2::object::id_from_address(@0x0),
            list    : v0,
        };
        0x2::event::emit<EventBribeRewardTokens>(v1);
    }

    public entry fun get_voting_fee_reward_tokens<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward::rewards_list(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::fee_voting_reward::borrow_reward(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_fee_voting_reward<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventFeeRewardTokens{
            lock_id : arg1,
            list    : v0,
        };
        0x2::event::emit<EventFeeRewardTokens>(v3);
    }

    public entry fun lock_voting_stats<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::get_votes<T0>(arg0, arg1);
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::PoolID, u64>(v0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::into_pool_id(*0x1::vector::borrow<0x2::object::ID>(&v1, v3))));
            v3 = v3 + 1;
        };
        let v4 = EventLockVotingStats{
            lock_id       : arg1,
            last_voted_at : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::lock_last_voted_at<T0>(arg0, arg1),
            pools         : v1,
            votes         : v2,
        };
        0x2::event::emit<EventLockVotingStats>(v4);
    }

    public entry fun notify_bribe_reward<T0, T1>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::bribe_voting_reward::notify_reward_amount<T1>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::borrow_bribe_voting_reward_mut<T0>(arg0, 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pool_to_gauge<T0>(arg0, arg1)), 0x1::option::none<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::whitelisted_tokens::WhitelistedToken>(), arg2, arg3, arg4);
    }

    public entry fun poke<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg2: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg3: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::poke<T0>(arg1, arg2, arg0, arg3, arg4, arg5);
    }

    public entry fun pools_gauges<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>) {
        let (v0, v1) = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::pools_gauges<T0>(arg0);
        let v2 = EventPoolGauge{
            pools  : v0,
            gauges : v1,
        };
        0x2::event::emit<EventPoolGauge>(v2);
    }

    public entry fun pools_tally<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::get_pool_weight<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    public entry fun vote<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>, arg2: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>, arg3: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::vote<T0>(arg1, arg2, arg0, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun voter_is_token_whitelisted<T0, T1>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>) {
        let v0 = EventVoterTokenWhitelisted{
            token       : 0x1::type_name::get<T1>(),
            whitelisted : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::is_whitelisted_token<T0, T1>(arg0),
        };
        0x2::event::emit<EventVoterTokenWhitelisted>(v0);
    }

    // decompiled from Move bytecode v6
}

