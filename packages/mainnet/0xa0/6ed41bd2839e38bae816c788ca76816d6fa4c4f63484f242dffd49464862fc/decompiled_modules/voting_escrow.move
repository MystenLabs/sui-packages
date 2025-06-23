module 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::voting_escrow {
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
        voted_pools: vector<0x2::object::ID>,
    }

    public entry fun transfer<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::transfer<T0>(arg1, arg0, arg2, arg3, arg4);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>>(0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::create<T0>(arg0, arg1, arg2, arg3));
    }

    public entry fun create_lock<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::create_lock<T0>(arg0, 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg1, arg5), arg2, arg3, arg4, arg5);
    }

    public entry fun create_lock_single_coin<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        create_lock<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public entry fun increase_amount<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: vector<0x2::coin::Coin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::increase_amount<T0>(arg0, arg1, 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg2, arg4), arg3, arg4);
    }

    public entry fun increase_amount_single_coin<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::increase_amount<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun increase_unlock_time<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::increase_unlock_time<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun lock_permanent<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::lock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_summary<T0>(arg0: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::Voter<T0>, arg1: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg2: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x2::event::emit<LockSummary>(lock_summary_internal<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun lock_summary_internal<T0>(arg0: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::Voter<T0>, arg1: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg2: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::reward_distributor::RewardDistributor<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : LockSummary {
        let v0 = 0;
        let v1 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::voted_pools<T0>(arg0, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            let v4 = v0 + 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::fee_voting_reward::earned<T0>(0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::borrow_fee_voting_reward<T0>(arg0, v3), arg3, arg4);
            v0 = v4 + 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::bribe_voting_reward::earned<T0>(0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::borrow_bribe_voting_reward<T0>(arg0, v3), arg3, arg4);
            v2 = v2 + 1;
        };
        LockSummary{
            voting_power                 : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::balance_of_nft_at<T0>(arg1, arg3, 0x2::clock::timestamp_ms(arg4) / 1000),
            reward_distributor_claimable : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::reward_distributor::claimable<T0>(arg2, arg1, arg3),
            fee_incentive_total          : v0,
            voted_pools                  : v1,
        }
    }

    public fun max_bps() : u64 {
        100000000
    }

    public entry fun merge_locks<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::merge<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun summary<T0>(arg0: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::Minter<T0>, arg1: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::Voter<T0>, arg2: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::common::current_timestamp(arg3);
        let v1 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::total_locked<T0>(arg2);
        let v2 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::epoch_emissions<T0>(arg0);
        let v3 = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::calculate_rebase_growth(v2, 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::total_supply<T0>(arg0), v1);
        let v4 = Summary{
            total_locked           : v1,
            total_voting_power     : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::total_supply_at<T0>(arg2, 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::common::current_timestamp(arg3)),
            total_voted_power      : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::total_weight<T0>(arg1),
            rebase_apr             : 0x273edb422b3404487a0e700224f541852e799957e4e289363a1675a8dcee158b::full_math_u64::mul_div_floor(v3, max_bps(), 0x273edb422b3404487a0e700224f541852e799957e4e289363a1675a8dcee158b::full_math_u64::mul_div_floor(v2 + v3, 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::max_bps(), 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::max_bps() - 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::team_emission_rate<T0>(arg0))),
            current_epoch_end      : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::common::epoch_next(v0),
            current_epoch_vote_end : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::common::epoch_vote_end(v0),
            team_emission_rate     : 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::team_emission_rate<T0>(arg0),
        };
        0x2::event::emit<Summary>(v4);
    }

    public entry fun unlock_permanent<T0>(arg0: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>, arg1: &mut 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::unlock_permanent<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

