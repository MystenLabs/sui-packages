module 0xf899bbc12e73e254bcb4ab3e3eb886a4ca5a65022402c312e07f8ad3480bc185::voter {
    struct EventDistributeReward has copy, drop, store {
        sender: address,
        gauge: 0x2::object::ID,
        amount: u64,
    }

    struct EventRewardTokens has copy, drop, store {
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

    struct ClaimableVotingBribes has copy, drop, store {
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

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let (v1, v2) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::create<T0>(arg0, 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig>(arg1), 0x2::object::id<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig>(arg2), v0, arg3);
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>>(v1);
        0x2::transfer::public_transfer<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::notify_reward_cap::NotifyRewardCap>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T2>, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::CreateCap, arg3: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter_cap::GovernorCap, arg4: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T2>, arg5: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::create_gauge<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun poke<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg3: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::poke<T0>(arg1, arg2, arg0, arg3, arg4, arg5);
    }

    public entry fun pools_gauges<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>) {
        let (v0, v1) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pools_gauges<T0>(arg0);
        let v2 = EventPoolGauge{
            pools  : v0,
            gauges : v1,
        };
        0x2::event::emit<EventPoolGauge>(v2);
    }

    public entry fun vote<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg3: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::vote<T0>(arg1, arg2, arg0, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun add_bribe_reward<T0, T1>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::notify_reward_amount<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward_mut<T0>(arg0, v0), 0x1::option::some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::prove_token_whitelisted<T0, T1>(arg0)), arg2, arg3, arg4);
        let v1 = EventAddBribeReward{
            pool   : arg1,
            gauge  : v0,
            amount : 0x2::coin::value<T1>(&arg2),
            token  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventAddBribeReward>(v1);
    }

    public fun claim_voting_bribes<T0, T1>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: vector<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2)) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T1>(arg0, arg1, 0x1::vector::borrow<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2) > 0) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_2<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: vector<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2, v0);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2) > 0) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_3<T0, T1, T2, T3>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: vector<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2, v0);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_bribe<T0, T3>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2) > 0) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: vector<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2, v0);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&arg2) > 0) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claimable_voting_bribes<T0, T1>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_2<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_3<T0, T1, T2, T3>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T3>(), claimable_voting_bribes_internal<T0, T3>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    fun claimable_voting_bribes_internal<T0, T1>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::voted_pools<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v3, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::earned<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, v3)), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    public entry fun distribute<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::Minter<T2>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T2>, arg3: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T2>, arg4: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::RewardDistributor<T2>, arg5: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg6: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::active_period<T2>(arg1) + 604800 < 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::current_timestamp(arg7)) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::update_period<T2>(arg1, arg2, arg3, arg4, arg7, arg8);
        };
        assert!(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::pool_id<T0, T1, T2>(arg5) == 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(arg6), 9223373187906011135);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg8),
            gauge  : 0x2::object::id<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>>(arg5),
            amount : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::distribute_gauge<T0, T1, T2>(arg2, arg0, arg5, arg6, arg7, arg8),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun epoch_reward_by_pool<T0, T1>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1))), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v0);
    }

    public entry fun epoch_reward_by_pool2<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1);
        let v1 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v1);
        let v2 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T2>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T2>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v2);
    }

    public entry fun epoch_reward_by_pool3<T0, T1, T2, T3>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1);
        let v1 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T1>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v1);
        let v2 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T2>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T2>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v2);
        let v3 = EventPoolIncentivesAmount{
            pool_id : arg1,
            token   : 0x1::type_name::get<T3>(),
            amount  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T3>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v0)), arg2),
        };
        0x2::event::emit<EventPoolIncentivesAmount>(v3);
    }

    public entry fun get_voting_bribe_reward_apr_by_pool<T0, T1>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1)));
        let v1 = EventRewardAPR{
            total_supply : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::total_supply(v0),
            rewards      : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_this_epoch<T1>(v0, arg2),
        };
        0x2::event::emit<EventRewardAPR>(v1);
    }

    public entry fun get_voting_bribe_reward_tokens<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v3);
    }

    public entry fun get_voting_bribe_reward_tokens_by_pool<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, arg1, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1)))));
        let v1 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v1);
    }

    public entry fun get_voting_fee_reward_tokens<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::fee_voting_reward::borrow_reward(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_fee_voting_reward<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v3);
    }

    public entry fun notify_bribe_reward<T0, T1>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::notify_reward_amount<T1>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward_mut<T0>(arg0, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, arg1)), 0x1::option::none<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(), arg2, arg3, arg4);
    }

    public entry fun pools_tally<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::get_pool_weight<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    // decompiled from Move bytecode v6
}

