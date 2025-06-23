module 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::voting_escrow {
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

    public entry fun transfer<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::transfer<T0>(arg1, arg0, arg2, arg3, arg4);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>>(0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::create<T0>(arg0, arg1, arg2, arg3));
    }

    public entry fun create_lock<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::create_lock<T0>(arg0, 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::merge_coins<T0>(arg1, arg5), arg2, arg3, arg4, arg5);
    }

    public entry fun create_lock_single_coin<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        create_lock<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public entry fun increase_amount<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: vector<0x2::coin::Coin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::increase_amount<T0>(arg0, arg1, 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::merge_coins<T0>(arg2, arg4), arg3, arg4);
    }

    public entry fun increase_amount_single_coin<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::increase_amount<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun increase_unlock_time<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::increase_unlock_time<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun lock_permanent<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::lock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_summary<T0>(arg0: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::Voter<T0>, arg1: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg2: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x2::event::emit<LockSummary>(lock_summary_internal<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun lock_summary_internal<T0>(arg0: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::Voter<T0>, arg1: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg2: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : LockSummary {
        let v0 = 0;
        let v1 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::voted_pools<T0>(arg0, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            let v4 = v0 + 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::fee_voting_reward::earned<T0>(0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::borrow_fee_voting_reward<T0>(arg0, v3), arg3, arg4);
            v0 = v4 + 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::bribe_voting_reward::earned<T0>(0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::borrow_bribe_voting_reward<T0>(arg0, v3), arg3, arg4);
            v2 = v2 + 1;
        };
        LockSummary{
            voting_power                 : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::balance_of_nft_at<T0>(arg1, arg3, 0x2::clock::timestamp_ms(arg4) / 1000),
            reward_distributor_claimable : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_distributor::claimable<T0>(arg2, arg1, arg3),
            fee_incentive_total          : v0,
        }
    }

    public fun max_bps() : u64 {
        100000000
    }

    public entry fun merge_locks<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::merge<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun summary<T0>(arg0: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::Minter<T0>, arg1: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::Voter<T0>, arg2: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::common::current_timestamp(arg3);
        let v1 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::total_locked<T0>(arg2);
        let v2 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::epoch_emissions<T0>(arg0);
        let v3 = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::calculate_rebase_growth(v2, 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::total_supply<T0>(arg0), v1);
        let v4 = Summary{
            total_locked           : v1,
            total_voting_power     : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::total_supply_at<T0>(arg2, 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::common::current_timestamp(arg3)),
            total_voted_power      : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::total_weight<T0>(arg1),
            rebase_apr             : 0x810344e626dbc98b93565b08cc435ead55513182604bae4f34b4228dfb2a680d::full_math_u64::mul_div_floor(v3, max_bps(), 0x810344e626dbc98b93565b08cc435ead55513182604bae4f34b4228dfb2a680d::full_math_u64::mul_div_floor(v2 + v3, 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::max_bps(), 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::max_bps() - 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::team_emission_rate<T0>(arg0))),
            current_epoch_end      : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::common::epoch_next(v0),
            current_epoch_vote_end : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::common::epoch_vote_end(v0),
            team_emission_rate     : 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::team_emission_rate<T0>(arg0),
        };
        0x2::event::emit<Summary>(v4);
    }

    public entry fun unlock_permanent<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::unlock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

