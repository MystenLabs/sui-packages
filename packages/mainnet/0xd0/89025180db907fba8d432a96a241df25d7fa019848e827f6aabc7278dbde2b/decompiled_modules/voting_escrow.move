module 0x4d5c4c6ebd49c41afc675f585be0f0aae02771bd86c73a20ae22664ecb093293::voting_escrow {
    struct Summary has copy, drop, store {
        total_locked: u64,
        total_voting_power: u64,
        total_voted_power: u64,
        rebase_apr: u64,
        current_epoch_end: u64,
        current_epoch_vote_end: u64,
        team_emission_rate: u64,
    }

    struct LockSummary has copy, drop, store {
        voting_power: u64,
        reward_distributor_claimable: u64,
        fee_incentive_total: u64,
    }

    struct EventVotingPower has copy, drop, store {
        lock_id: 0x2::object::ID,
        voting_power: u64,
    }

    public entry fun transfer<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::transfer<T0>(arg1, arg0, arg2, arg3, arg4);
    }

    public entry fun burn_lock<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg3: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::reset<T0>(arg2, arg1, arg0, &arg3, arg4, arg5);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::withdraw<T0>(arg1, arg3, arg4, arg5);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::create<T0>(arg0, arg1, arg2, arg3));
    }

    public entry fun create_lock<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::create_lock<T0>(arg0, 0x4d5c4c6ebd49c41afc675f585be0f0aae02771bd86c73a20ae22664ecb093293::utils::merge_coins<T0>(arg1, arg5), arg2, arg3, arg4, arg5);
    }

    public entry fun create_lock_single_coin<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        create_lock<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public entry fun increase_amount<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg2: vector<0x2::coin::Coin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::increase_amount<T0>(arg0, arg1, 0x4d5c4c6ebd49c41afc675f585be0f0aae02771bd86c73a20ae22664ecb093293::utils::merge_coins<T0>(arg2, arg4), arg3, arg4);
    }

    public entry fun increase_amount_single_coin<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::increase_amount<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun increase_unlock_time<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::increase_unlock_time<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun lock_permanent<T0>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::lock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_summary<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x2::event::emit<LockSummary>(lock_summary_internal<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun lock_summary_internal<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : LockSummary {
        let v0 = 0;
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::voted_pools<T0>(arg0, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            let v4 = v0 + 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::fee_voting_reward::earned<T0>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_fee_voting_reward<T0>(arg0, v3), arg3, arg4);
            v0 = v4 + 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward::earned<T0>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::borrow_bribe_voting_reward<T0>(arg0, v3), arg3, arg4);
            v2 = v2 + 1;
        };
        LockSummary{
            voting_power                 : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::balance_of_nft_at<T0>(arg1, arg3, 0x2::clock::timestamp_ms(arg4) / 1000),
            reward_distributor_claimable : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::claimable<T0>(arg2, arg1, arg3),
            fee_incentive_total          : v0,
        }
    }

    public fun max_bps() : u64 {
        100000000
    }

    public entry fun merge_locks<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg3: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::reset<T0>(arg2, arg1, arg0, &arg3, arg5, arg6);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::merge<T0>(arg1, arg3, arg4, arg5, arg6);
    }

    public entry fun split_lock<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg3: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::is_split_allowed<T0>(arg1, 0x2::tx_context::sender(arg6)), 9223372268783009791);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::reset<T0>(arg2, arg1, arg0, &arg3, arg5, arg6);
        let (_, _) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::split<T0>(arg1, arg3, arg4, arg5, arg6);
    }

    public entry fun summary<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::Minter<T0>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::current_timestamp(arg3);
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::total_locked<T0>(arg2);
        let v2 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::epoch_emissions<T0>(arg0);
        let v3 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::calculate_rebase_growth(v2, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::total_supply<T0>(arg0), v1);
        let v4 = Summary{
            total_locked           : v1,
            total_voting_power     : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::total_supply_at<T0>(arg2, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::current_timestamp(arg3)),
            total_voted_power      : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::total_weight<T0>(arg1),
            rebase_apr             : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_floor(v3, max_bps(), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_floor(v2 + v3, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::max_bps(), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::max_bps() - 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::team_emission_rate<T0>(arg0))),
            current_epoch_end      : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::epoch_next(v0),
            current_epoch_vote_end : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::epoch_vote_end(v0),
            team_emission_rate     : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::team_emission_rate<T0>(arg0),
        };
        0x2::event::emit<Summary>(v4);
    }

    public entry fun unlock_permanent<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>, arg3: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::reset<T0>(arg2, arg1, arg0, arg3, arg4, arg5);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::unlock_permanent<T0>(arg1, arg3, arg4, arg5);
    }

    public entry fun voting_power<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventVotingPower{
            lock_id      : arg1,
            voting_power : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::balance_of_nft_at<T0>(arg0, arg1, 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::common::current_timestamp(arg2)),
        };
        0x2::event::emit<EventVotingPower>(v0);
    }

    // decompiled from Move bytecode v6
}

