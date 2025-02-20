module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter {
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

    struct GaugeRepresent has drop, store {
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        weight: u64,
        last_reward_time: u64,
    }

    struct Voter<phantom T0> has store, key {
        id: 0x2::object::UID,
        global_config: 0x2::object::ID,
        distribution_config: 0x2::object::ID,
        governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        epoch_governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        emergency_council: 0x2::object::ID,
        total_weight: u64,
        used_weights: 0x2::table::Table<LockID, u64>,
        pools: vector<PoolID>,
        pool_to_gauger: 0x2::table::Table<PoolID, GaugeID>,
        gauge_represents: 0x2::table::Table<GaugeID, GaugeRepresent>,
        votes: 0x2::table::Table<LockID, 0x2::table::Table<PoolID, u64>>,
        rewards: 0x2::table::Table<GaugeID, 0x2::balance::Balance<T0>>,
        weights: 0x2::table::Table<GaugeID, u64>,
        epoch: u64,
        voter_cap: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::VoterCap,
        balances: 0x2::bag::Bag,
        index: u128,
        supply_index: 0x2::table::Table<GaugeID, u128>,
        claimable: 0x2::table::Table<GaugeID, u64>,
        is_whitelisted_token: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        is_whitelisted_nft: 0x2::table::Table<LockID, bool>,
        max_voting_num: u64,
        last_voted: 0x2::table::Table<LockID, u64>,
        pool_vote: 0x2::table::Table<LockID, vector<PoolID>>,
        gauge_to_fee_authorized_cap: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::reward_authorized_cap::RewardAuthorizedCap,
        gauge_to_fee: 0x2::table::Table<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>,
        gauge_to_bribe_authorized_cap: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::reward_authorized_cap::RewardAuthorizedCap,
        gauge_to_bribe: 0x2::table::Table<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>,
    }

    struct EventNotifyReward has copy, drop, store {
        notifier: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EventExtractClaimable has copy, drop, store {
        gauger: 0x2::object::ID,
        amount: u64,
    }

    struct EventWhitelistToken has copy, drop, store {
        sender: address,
        token: 0x1::type_name::TypeName,
        listed: bool,
    }

    struct EventWhitelistNFT has copy, drop, store {
        sender: address,
        id: 0x2::object::ID,
        listed: bool,
    }

    struct EventKillGauge has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EventReviveGauge has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EventVoted has copy, drop, store {
        sender: address,
        pool: 0x2::object::ID,
        lock: 0x2::object::ID,
        voting_weight: u64,
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

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : (Voter<T0>, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::NotifyRewardCap) {
        let v0 = 0x2::object::new(arg4);
        let v1 = *0x2::object::uid_as_inner(&v0);
        let v2 = Voter<T0>{
            id                            : v0,
            global_config                 : arg1,
            distribution_config           : arg2,
            governors                     : 0x2::vec_set::empty<0x2::object::ID>(),
            epoch_governors               : 0x2::vec_set::empty<0x2::object::ID>(),
            emergency_council             : 0x2::object::id_from_address(@0x0),
            total_weight                  : 0,
            used_weights                  : 0x2::table::new<LockID, u64>(arg4),
            pools                         : 0x1::vector::empty<PoolID>(),
            pool_to_gauger                : 0x2::table::new<PoolID, GaugeID>(arg4),
            gauge_represents              : 0x2::table::new<GaugeID, GaugeRepresent>(arg4),
            votes                         : 0x2::table::new<LockID, 0x2::table::Table<PoolID, u64>>(arg4),
            rewards                       : 0x2::table::new<GaugeID, 0x2::balance::Balance<T0>>(arg4),
            weights                       : 0x2::table::new<GaugeID, u64>(arg4),
            epoch                         : 0,
            voter_cap                     : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::create_voter_cap(v1, arg4),
            balances                      : 0x2::bag::new(arg4),
            index                         : 0,
            supply_index                  : 0x2::table::new<GaugeID, u128>(arg4),
            claimable                     : 0x2::table::new<GaugeID, u64>(arg4),
            is_whitelisted_token          : 0x2::table::new<0x1::type_name::TypeName, bool>(arg4),
            is_whitelisted_nft            : 0x2::table::new<LockID, bool>(arg4),
            max_voting_num                : 10,
            last_voted                    : 0x2::table::new<LockID, u64>(arg4),
            pool_vote                     : 0x2::table::new<LockID, vector<PoolID>>(arg4),
            gauge_to_fee_authorized_cap   : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::reward_authorized_cap::create(v1, arg4),
            gauge_to_fee                  : 0x2::table::new<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(arg4),
            gauge_to_bribe_authorized_cap : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::reward_authorized_cap::create(v1, arg4),
            gauge_to_bribe                : 0x2::table::new<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(arg4),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&arg3)) {
            let v4 = &mut v2;
            whitelist_token_internal<T0>(v4, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg3, v3), true, 0x2::tx_context::sender(arg4));
            v3 = v3 + 1;
        };
        let v5 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&v2.is_whitelisted_token, v5)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut v2.is_whitelisted_token, v5, true);
        };
        (v2, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::create_internal(0x2::object::id<Voter<T0>>(&v2), arg4))
    }

    public fun add_epoch_governor<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_governor<T0>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223373175022616600);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::create_epoch_governor_cap(0x2::object::id<Voter<T0>>(arg0), arg3);
        let v1 = 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::EpochGovernorCap>(&v0);
        0x2::transfer::public_transfer<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::EpochGovernorCap>(v0, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.epoch_governors, v1);
        let v2 = EventAddEpochGovernor{
            who : arg2,
            cap : v1,
        };
        0x2::event::emit<EventAddEpochGovernor>(v2);
    }

    public fun add_governor<T0>(arg0: &mut Voter<T0>, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::create_governor_cap(0x2::object::id<Voter<T0>>(arg0), arg2, arg3);
        let v1 = 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.governors, v1);
        0x2::transfer::public_transfer<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(v0, arg2);
        let v2 = EventAddGovernor{
            who : arg2,
            cap : v1,
        };
        0x2::event::emit<EventAddGovernor>(v2);
    }

    fun assert_only_new_epoch<T0>(arg0: &Voter<T0>, arg1: LockID, arg2: &0x2::clock::Clock) {
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::current_timestamp(arg2);
        assert!(!0x2::table::contains<LockID, u64>(&arg0.last_voted, arg1) || 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::epoch_start(v0) > *0x2::table::borrow<LockID, u64>(&arg0.last_voted, arg1), 9223373398361178140);
        assert!(v0 > 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::epoch_vote_start(v0), 9223373402656276510);
    }

    public fun borrow_bribe_voting_reward<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward {
        0x2::table::borrow<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&arg0.gauge_to_bribe, into_gauge_id(arg1))
    }

    public fun borrow_bribe_voting_reward_mut<T0>(arg0: &mut Voter<T0>, arg1: 0x2::object::ID) : &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward {
        0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&mut arg0.gauge_to_bribe, into_gauge_id(arg1))
    }

    public fun borrow_fee_voting_reward<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward {
        0x2::table::borrow<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1))
    }

    public fun borrow_fee_voting_reward_mut<T0>(arg0: &mut Voter<T0>, arg1: 0x2::object::ID) : &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward {
        0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(arg1))
    }

    public fun borrow_voter_cap<T0>(arg0: &Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::NotifyRewardCap) : &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::VoterCap {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::validate_notify_reward_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        &arg0.voter_cap
    }

    fun check_vote<T0>(arg0: &Voter<T0>, arg1: &vector<0x2::object::ID>, arg2: &vector<u64>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg1);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 9223374253058621452);
        assert!(v0 <= arg0.max_voting_num, 9223374257354899488);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(*0x1::vector::borrow<0x2::object::ID>(arg1, v1))), 9223374274533589006);
            assert!(*0x1::vector::borrow<u64>(arg2, v1) <= 10000, 9223374278828687376);
            v1 = v1 + 1;
        };
    }

    public fun claim_voting_bribe<T0, T1>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg2)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolID>(v0)) {
            0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::get_reward<T0, T1>(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&mut arg0.gauge_to_bribe, *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, *0x1::vector::borrow<PoolID>(v0, v1))), arg1, arg2, arg3, arg4);
            v1 = v1 + 1;
        };
    }

    public fun claim_voting_fee_reward<T0, T1>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg2)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolID>(v0)) {
            0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::get_reward<T0, T1>(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, *0x1::vector::borrow<PoolID>(v0, v1))), arg1, arg2, arg3, arg4);
            v1 = v1 + 1;
        };
    }

    public fun claimable<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = into_gauge_id(arg1);
        if (0x2::table::contains<GaugeID, u64>(&arg0.claimable, v0)) {
            *0x2::table::borrow<GaugeID, u64>(&arg0.claimable, v0)
        } else {
            0
        }
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut Voter<T2>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::CreateCap, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg4: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T2>, arg5: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2> {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg3, 0x2::object::id<Voter<T2>>(arg0));
        assert!(is_governor<T2>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg3)), 9223373694713659416);
        assert!(arg0.distribution_config == 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig>(arg1), 9223373703302086655);
        let v0 = return_new_gauge<T0, T1, T2>(arg1, arg2, arg5, arg7);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<T1>());
        let v2 = 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>>(&v0);
        let v3 = 0x2::object::id<Voter<T2>>(arg0);
        let v4 = 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T2>>(arg4);
        0x2::table::add<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, into_gauge_id(v2), 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::create(v3, v4, v2, v1, arg7));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<T2>());
        0x2::table::add<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&mut arg0.gauge_to_bribe, into_gauge_id(v2), 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::create(v3, v4, v2, v1, arg7));
        let v5 = &mut v0;
        receive_gauger<T0, T1, T2>(arg0, arg3, v5, arg6, arg7);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v6, v2);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::update_gauge_liveness(arg1, v6, true, arg7);
        v0
    }

    public fun deposit_managed<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        assert_only_new_epoch<T0>(arg0, v0, arg5);
        let v1 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::current_timestamp(arg5);
        assert!(v1 <= 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::epoch_vote_end(v1), 9223375335393001524);
        if (0x2::table::contains<LockID, u64>(&arg0.last_voted, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.last_voted, v0);
        };
        0x2::table::add<LockID, u64>(&mut arg0.last_voted, v0, v1);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::deposit_managed<T0>(arg1, &arg0.voter_cap, arg3, arg4, arg5, arg6);
        let v2 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::balance_of_nft_at<T0>(arg1, v0.id, v1);
        poke_internal<T0>(arg0, arg1, arg2, arg4, v2, arg5, arg6);
    }

    public fun distribute_gauge<T0, T1, T2>(arg0: &mut Voter<T2>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg3: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = into_gauge_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>>(arg2));
        let v1 = 0x2::table::borrow<GaugeID, GaugeRepresent>(&arg0.gauge_represents, v0);
        assert!(v1.pool_id == 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(arg3) && v1.gauger_id == v0.id, 9223376005404557311);
        let v2 = extract_claimable_for<T2>(arg0, arg1, v0.id);
        let (v3, v4) = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::notify_reward<T0, T1, T2>(arg2, &arg0.voter_cap, arg3, v2, arg4, arg5);
        let v5 = 0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, v0);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::notify_reward_amount<T0>(v5, &arg0.gauge_to_fee_authorized_cap, 0x2::coin::from_balance<T0>(v3, arg5), arg4, arg5);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::notify_reward_amount<T1>(v5, &arg0.gauge_to_fee_authorized_cap, 0x2::coin::from_balance<T1>(v4, arg5), arg4, arg5);
        0x2::balance::value<T2>(&v2)
    }

    fun extract_claimable_for<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        let v0 = into_gauge_id(arg2);
        update_for_internal<T0>(arg0, arg1, v0);
        let v1 = *0x2::table::borrow<GaugeID, u64>(&arg0.claimable, v0);
        0x2::table::remove<GaugeID, u64>(&mut arg0.claimable, v0);
        0x2::table::add<GaugeID, u64>(&mut arg0.claimable, v0, 0);
        let v2 = EventExtractClaimable{
            gauger : v0.id,
            amount : v1,
        };
        0x2::event::emit<EventExtractClaimable>(v2);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v1)
    }

    public fun fee_voting_reward_balance<T0, T1>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : u64 {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::balance<T1>(0x2::table::borrow<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&arg0.gauge_to_fee, into_gauge_id(arg1)))
    }

    public fun get_balance<T0, T1>(arg0: &Voter<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0))
        }
    }

    public fun get_gauge_weight<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<GaugeID, u64>(&arg0.weights, into_gauge_id(arg1))
    }

    public fun get_pool_weight<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(arg1));
        get_gauge_weight<T0>(arg0, v0.id)
    }

    public fun get_total_weight<T0>(arg0: &Voter<T0>) : u64 {
        arg0.total_weight
    }

    public fun get_votes<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : &0x2::table::Table<PoolID, u64> {
        let v0 = into_lock_id(arg1);
        assert!(0x2::table::contains<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0), 9223375640336072762);
        0x2::table::borrow<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0)
    }

    fun init(arg0: VOTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VOTER>(arg0, arg1);
    }

    public fun into_gauge_id(arg0: 0x2::object::ID) : GaugeID {
        GaugeID{id: arg0}
    }

    public fun into_lock_id(arg0: 0x2::object::ID) : LockID {
        LockID{id: arg0}
    }

    public fun into_pool_id(arg0: 0x2::object::ID) : PoolID {
        PoolID{id: arg0}
    }

    public fun is_epoch_governor<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.epoch_governors, &arg1)
    }

    public fun is_governor<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.governors, &arg1)
    }

    public fun is_whitelisted_nft<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = into_lock_id(arg1);
        0x2::table::contains<LockID, bool>(&arg0.is_whitelisted_nft, v0) && *0x2::table::borrow<LockID, bool>(&arg0.is_whitelisted_nft, v0)
    }

    public fun is_whitelisted_token<T0, T1>(arg0: &Voter<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.is_whitelisted_token, v0)) {
            let v2 = true;
            &v2 == 0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.is_whitelisted_token, v0)
        } else {
            false
        }
    }

    public fun kill_gauge<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::emergency_council::validate_emergency_council_voter_id(arg2, 0x2::object::id<Voter<T0>>(arg0));
        assert!(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 9223374124212748348);
        assert!(0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::is_gauge_alive(arg1, arg3), 9223374128505094164);
        let v0 = into_gauge_id(arg3);
        update_for_internal<T0>(arg0, arg1, v0);
        let v1 = if (0x2::table::contains<GaugeID, u64>(&arg0.claimable, v0)) {
            0x2::table::remove<GaugeID, u64>(&mut arg0.claimable, v0)
        } else {
            0
        };
        let v2 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v1));
        };
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, v0.id);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::update_gauge_liveness(arg1, v3, false, arg5);
        let v4 = EventKillGauge{id: v0.id};
        0x2::event::emit<EventKillGauge>(v4);
        v2
    }

    public fun notify_rewards<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::NotifyRewardCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::validate_notify_reward_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v2)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2)
        } else {
            0x2::balance::zero<T0>()
        };
        let v4 = v3;
        0x2::balance::join<T0>(&mut v4, v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, v4);
        let v5 = if (arg0.total_weight == 0) {
            1
        } else {
            arg0.total_weight
        };
        let v6 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::mul_div_floor((v1 as u128), 18446744073709551616, (v5 as u128));
        if (v6 > 0) {
            arg0.index = arg0.index + v6;
        };
        let v7 = EventNotifyReward{
            notifier : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::notify_reward_cap::who(arg1),
            token    : v2,
            amount   : v1,
        };
        0x2::event::emit<EventNotifyReward>(v7);
    }

    public fun poke<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::current_timestamp(arg4);
        assert!(v0 > 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::epoch_vote_start(v0), 9223374523642740766);
        let v1 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::get_voting_power<T0>(arg1, arg3, arg4);
        poke_internal<T0>(arg0, arg1, arg2, arg3, v1, arg4, arg5);
    }

    fun poke_internal<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        let v1 = if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, v0)) {
            0x1::vector::length<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, v0))
        } else {
            0
        };
        if (v1 > 0) {
            let v2 = 0x1::vector::empty<u64>();
            let v3 = 0;
            let v4 = 0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, v0);
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            assert!(0x2::table::contains<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0), 9223374600953069612);
            while (v3 < v1) {
                0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x1::vector::borrow<PoolID>(v4, v3).id);
                let v6 = 0x2::table::borrow<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0);
                assert!(0x2::table::contains<PoolID, u64>(v6, *0x1::vector::borrow<PoolID>(v4, v3)), 9223374618132938796);
                0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<PoolID, u64>(v6, *0x1::vector::borrow<PoolID>(v4, v3)));
                v3 = v3 + 1;
            };
            vote_internal<T0>(arg0, arg1, arg2, arg3, arg4, v5, v2, arg5, arg6);
        };
    }

    public fun pool_to_gauge<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, into_pool_id(arg1)).id
    }

    public fun prove_pair_whitelisted<T0, T1, T2>(arg0: &Voter<T0>) : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::whitelisted_tokens::WhitelistedTokenPair {
        assert!(is_whitelisted_token<T0, T1>(arg0), 9223373991064895487);
        assert!(is_whitelisted_token<T0, T2>(arg0), 9223373995359862783);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::whitelisted_tokens::create_pair<T1, T2>(0x2::object::id<Voter<T0>>(arg0))
    }

    public fun prove_token_whitelisted<T0, T1>(arg0: &Voter<T0>) : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::whitelisted_tokens::WhitelistedToken {
        assert!(is_whitelisted_token<T0, T1>(arg0), 9223373973885026303);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::whitelisted_tokens::create<T1>(0x2::object::id<Voter<T0>>(arg0))
    }

    public fun receive_gauger<T0, T1, T2>(arg0: &mut Voter<T2>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T2>>(arg0));
        assert!(is_governor<T2>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223373806382809112);
        let v0 = into_gauge_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>>(arg2));
        let v1 = into_pool_id(0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::pool_id<T0, T1, T2>(arg2));
        assert!(!0x2::table::contains<GaugeID, GaugeRepresent>(&arg0.gauge_represents, v0), 9223373823561498630);
        assert!(!0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, v1), 9223373827859087406);
        let v2 = GaugeRepresent{
            gauger_id        : 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>>(arg2),
            pool_id          : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::pool_id<T0, T1, T2>(arg2),
            weight           : 0,
            last_reward_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<GaugeID, GaugeRepresent>(&mut arg0.gauge_represents, v0, v2);
        0x2::table::add<GaugeID, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x2::balance::zero<T2>());
        0x2::table::add<GaugeID, u64>(&mut arg0.weights, v0, 0);
        0x1::vector::push_back<PoolID>(&mut arg0.pools, v1);
        0x2::table::add<PoolID, GaugeID>(&mut arg0.pool_to_gauger, v1, v0);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::set_voter<T0, T1, T2>(arg2, 0x2::object::id<Voter<T2>>(arg0), arg4);
        whitelist_token<T2, T0>(arg0, arg1, true, arg4);
        whitelist_token<T2, T1>(arg0, arg1, true, arg4);
        if (!is_whitelisted_token<T2, T2>(arg0)) {
            whitelist_token<T2, T2>(arg0, arg1, true, arg4);
        };
    }

    public fun remove_epoch_governor<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: 0x2::object::ID) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        assert!(is_governor<T0>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223373222267256856);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.epoch_governors, &arg2);
        let v0 = EventRemoveEpochGovernor{cap: arg2};
        0x2::event::emit<EventRemoveEpochGovernor>(v0);
    }

    public fun remove_governor<T0>(arg0: &mut Voter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.governors, &arg2);
        let v0 = EventRemoveGovernor{cap: arg2};
        0x2::event::emit<EventRemoveGovernor>(v0);
    }

    public fun reset<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_only_new_epoch<T0>(arg0, into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3)), arg4);
        reset_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun reset_internal<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        let v1 = if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, v0)) {
            0x1::vector::length<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, v0))
        } else {
            0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<PoolID>(0x2::table::borrow<LockID, vector<PoolID>>(&arg0.pool_vote, v0), v3);
            let v5 = *0x2::table::borrow<PoolID, u64>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0), v4);
            let v6 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, v4);
            if (v5 != 0) {
                update_for_internal<T0>(arg0, arg2, v6);
                0x2::table::add<GaugeID, u64>(&mut arg0.weights, v6, 0x2::table::remove<GaugeID, u64>(&mut arg0.weights, v6) - v5);
                0x2::table::remove<PoolID, u64>(0x2::table::borrow_mut<LockID, 0x2::table::Table<PoolID, u64>>(&mut arg0.votes, v0), v4);
                0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::withdraw(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, v6), &arg0.gauge_to_fee_authorized_cap, v5, v0.id, arg4, arg5);
                0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::withdraw(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&mut arg0.gauge_to_bribe, v6), &arg0.gauge_to_bribe_authorized_cap, v5, v0.id, arg4, arg5);
                v2 = v2 + v5;
                let v7 = EventAbstained{
                    sender      : 0x2::tx_context::sender(arg5),
                    pool        : v4.id,
                    lock        : v0.id,
                    votes       : v5,
                    pool_weight : *0x2::table::borrow<GaugeID, u64>(&arg0.weights, v6),
                };
                0x2::event::emit<EventAbstained>(v7);
            };
            v3 = v3 + 1;
        };
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::voting<T0>(arg1, &arg0.voter_cap, v0.id, false);
        arg0.total_weight = arg0.total_weight - v2;
        if (0x2::table::contains<LockID, u64>(&arg0.used_weights, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.used_weights, v0);
        };
        if (0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, v0)) {
            0x2::table::remove<LockID, vector<PoolID>>(&mut arg0.pool_vote, v0);
        };
    }

    public(friend) fun return_new_gauge<T0, T1, T2>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg1: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::CreateCap, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2> {
        let v0 = 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(arg2);
        let v1 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::create<T0, T1, T2>(arg0, v0, arg3);
        let v2 = 0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::create_gauge_cap(arg1, v0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>>(&v1), arg3);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::init_magma_distribution_gauge<T0, T1>(arg2, &v2);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::receive_gauge_cap<T0, T1, T2>(&mut v1, v2);
        v1
    }

    public fun revive_gauge<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::emergency_council::validate_emergency_council_voter_id(arg2, 0x2::object::id<Voter<T0>>(arg0));
        assert!(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 9223374218702028860);
        assert!(!0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::is_gauge_alive(arg1, arg3), 9223374222996734008);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::update_gauge_liveness(arg1, v0, true, arg4);
        let v1 = EventReviveGauge{id: arg3};
        0x2::event::emit<EventReviveGauge>(v1);
    }

    public fun set_max_voting_num<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: u64) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        assert!(is_governor<T0>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223373252332027928);
        assert!(arg2 >= 10, 9223373256627126298);
        assert!(arg2 != arg0.max_voting_num, 9223373265215422463);
        arg0.max_voting_num = arg2;
    }

    public fun total_weight<T0>(arg0: &Voter<T0>) : u64 {
        arg0.total_weight
    }

    public fun update_for<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: 0x2::object::ID) {
        update_for_internal<T0>(arg0, arg1, into_gauge_id(arg2));
    }

    fun update_for_internal<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: GaugeID) {
        let v0 = if (0x2::table::contains<GaugeID, u64>(&arg0.weights, arg2)) {
            *0x2::table::borrow<GaugeID, u64>(&arg0.weights, arg2)
        } else {
            0
        };
        if (v0 > 0) {
            let v1 = if (0x2::table::contains<GaugeID, u128>(&arg0.supply_index, arg2)) {
                0x2::table::remove<GaugeID, u128>(&mut arg0.supply_index, arg2)
            } else {
                0
            };
            let v2 = arg0.index;
            0x2::table::add<GaugeID, u128>(&mut arg0.supply_index, arg2, v2);
            let v3 = v2 - v1;
            if (v3 > 0) {
                assert!(0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::is_gauge_alive(arg1, arg2.id), 9223375696169992240);
                let v4 = if (0x2::table::contains<GaugeID, u64>(&arg0.claimable, arg2)) {
                    0x2::table::remove<GaugeID, u64>(&mut arg0.claimable, arg2)
                } else {
                    0
                };
                0x2::table::add<GaugeID, u64>(&mut arg0.claimable, arg2, v4 + (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::mul_div_floor((v0 as u128), v3, 18446744073709551616) as u64));
            };
        } else {
            if (0x2::table::contains<GaugeID, u128>(&arg0.supply_index, arg2)) {
                0x2::table::remove<GaugeID, u128>(&mut arg0.supply_index, arg2);
            };
            0x2::table::add<GaugeID, u128>(&mut arg0.supply_index, arg2, arg0.index);
        };
    }

    public fun update_for_many<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            update_for_internal<T0>(arg0, arg1, into_gauge_id(*0x1::vector::borrow<0x2::object::ID>(&arg2, v0)));
            v0 = v0 + 1;
        };
    }

    public fun update_for_range<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: u64, arg3: u64) {
        let v0 = 0;
        let v1 = 0x1::vector::length<PoolID>(&arg0.pools);
        let v2 = v1;
        if (v1 > arg3) {
            v2 = arg3;
        };
        while (arg2 + v0 < v2) {
            let v3 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, *0x1::vector::borrow<PoolID>(&arg0.pools, arg2 + v0));
            update_for_internal<T0>(arg0, arg1, v3);
            v0 = v0 + 1;
        };
    }

    public fun used_weights<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<LockID, u64>(&arg0.used_weights, into_lock_id(arg1))
    }

    public fun vote<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        assert_only_new_epoch<T0>(arg0, v0, arg6);
        check_vote<T0>(arg0, &arg4, &arg5);
        assert!(!0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::deactivated<T0>(arg1, v0.id), 9223374712621563938);
        let v1 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::current_timestamp(arg6);
        if (v1 > 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::epoch_vote_end(v1) && (!0x2::table::contains<LockID, bool>(&arg0.is_whitelisted_nft, v0) || *0x2::table::borrow<LockID, bool>(&arg0.is_whitelisted_nft, v0) == false)) {
            abort 9223374729801564196
        };
        if (0x2::table::contains<LockID, u64>(&arg0.last_voted, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.last_voted, v0);
        };
        0x2::table::add<LockID, u64>(&mut arg0.last_voted, v0, v1);
        let v2 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::get_voting_power<T0>(arg1, arg3, arg6);
        assert!(v2 > 0, 9223374768456400934);
        vote_internal<T0>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg6, arg7);
    }

    fun vote_internal<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: u64, arg5: vector<0x2::object::ID>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        reset_internal<T0>(arg0, arg1, arg2, arg3, arg7, arg8);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg5);
        while (v4 < v5) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg6, v4);
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < v5) {
            let v6 = into_pool_id(*0x1::vector::borrow<0x2::object::ID>(&arg5, v4));
            assert!(0x2::table::contains<PoolID, GaugeID>(&arg0.pool_to_gauger, v6), 9223374862943715336);
            let v7 = *0x2::table::borrow<PoolID, GaugeID>(&arg0.pool_to_gauger, v6);
            assert!(0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::is_gauge_alive(arg2, v7.id), 9223374871534436372);
            let v8 = if (*0x1::vector::borrow<u64>(&arg6, v4) == 0) {
                0
            } else {
                0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_floor(*0x1::vector::borrow<u64>(&arg6, v4), arg4, v1)
            };
            let v9 = if (0x2::table::contains<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0)) {
                if (0x2::table::contains<PoolID, u64>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0), v6)) {
                    let v10 = 0;
                    0x2::table::borrow<PoolID, u64>(0x2::table::borrow<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0), v6) != &v10
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                abort 9223374897305550888
            };
            assert!(v8 > 0, 9223374905895616554);
            update_for_internal<T0>(arg0, arg2, v7);
            if (!0x2::table::contains<LockID, vector<PoolID>>(&arg0.pool_vote, v0)) {
                0x2::table::add<LockID, vector<PoolID>>(&mut arg0.pool_vote, v0, 0x1::vector::empty<PoolID>());
            };
            0x1::vector::push_back<PoolID>(0x2::table::borrow_mut<LockID, vector<PoolID>>(&mut arg0.pool_vote, v0), v6);
            let v11 = if (0x2::table::contains<GaugeID, u64>(&arg0.weights, v7)) {
                0x2::table::remove<GaugeID, u64>(&mut arg0.weights, v7)
            } else {
                0
            };
            0x2::table::add<GaugeID, u64>(&mut arg0.weights, v7, v11 + v8);
            if (!0x2::table::contains<LockID, 0x2::table::Table<PoolID, u64>>(&arg0.votes, v0)) {
                0x2::table::add<LockID, 0x2::table::Table<PoolID, u64>>(&mut arg0.votes, v0, 0x2::table::new<PoolID, u64>(arg8));
            };
            let v12 = 0x2::table::borrow_mut<LockID, 0x2::table::Table<PoolID, u64>>(&mut arg0.votes, v0);
            let v13 = if (0x2::table::contains<PoolID, u64>(v12, v6)) {
                0x2::table::remove<PoolID, u64>(v12, v6)
            } else {
                0
            };
            0x2::table::add<PoolID, u64>(v12, v6, v13 + v8);
            0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::deposit(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::fee_voting_reward::FeeVotingReward>(&mut arg0.gauge_to_fee, v7), &arg0.gauge_to_fee_authorized_cap, v8, v0.id, arg7, arg8);
            0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::deposit(0x2::table::borrow_mut<GaugeID, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::bribe_voting_reward::BribeVotingReward>(&mut arg0.gauge_to_bribe, v7), &arg0.gauge_to_bribe_authorized_cap, v8, v0.id, arg7, arg8);
            v2 = v2 + v8;
            v3 = v3 + v8;
            let v14 = EventVoted{
                sender        : 0x2::tx_context::sender(arg8),
                pool          : v6.id,
                lock          : v0.id,
                voting_weight : v8,
                pool_weight   : *0x2::table::borrow<GaugeID, u64>(&arg0.weights, v7),
            };
            0x2::event::emit<EventVoted>(v14);
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::voting<T0>(arg1, &arg0.voter_cap, v0.id, true);
        };
        arg0.total_weight = arg0.total_weight + v3;
        if (0x2::table::contains<LockID, u64>(&arg0.used_weights, v0)) {
            0x2::table::remove<LockID, u64>(&mut arg0.used_weights, v0);
        };
        0x2::table::add<LockID, u64>(&mut arg0.used_weights, v0, v2);
    }

    public fun voted_pools<T0>(arg0: &Voter<T0>, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
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

    public fun whitelist_nft<T0>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        assert!(is_governor<T0>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223374076965748760);
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

    public fun whitelist_token<T0, T1>(arg0: &mut Voter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::validate_governor_voter_id(arg1, 0x2::object::id<Voter<T0>>(arg0));
        assert!(is_governor<T0>(arg0, 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter_cap::GovernorCap>(arg1)), 9223374016836206616);
        whitelist_token_internal<T0>(arg0, 0x1::type_name::get<T1>(), arg2, 0x2::tx_context::sender(arg3));
    }

    fun whitelist_token_internal<T0>(arg0: &mut Voter<T0>, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: address) {
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.is_whitelisted_token, arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.is_whitelisted_token, arg1);
        };
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.is_whitelisted_token, arg1, arg2);
        let v0 = EventWhitelistToken{
            sender : arg3,
            token  : arg1,
            listed : arg2,
        };
        0x2::event::emit<EventWhitelistToken>(v0);
    }

    public fun withdraw_managed<T0>(arg0: &mut Voter<T0>, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>, arg2: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg3: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg4: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = into_lock_id(0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg3));
        assert_only_new_epoch<T0>(arg0, v0, arg5);
        let v1 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::id_to_managed<T0>(arg1, v0.id);
        assert!(v1 == 0x2::object::id<0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::Lock>(arg4), 9223375408407576630);
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::withdraw_managed<T0>(arg1, &arg0.voter_cap, arg3, arg4, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::owner_proof<T0>(arg1, arg3, arg6), arg5, arg6);
        let v2 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::balance_of_nft_at<T0>(arg1, v1, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::common::current_timestamp(arg5));
        if (v2 == 0) {
            reset_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
            if (0x2::table::contains<LockID, u64>(&arg0.last_voted, into_lock_id(v1))) {
                0x2::table::remove<LockID, u64>(&mut arg0.last_voted, into_lock_id(v1));
            };
        } else {
            poke_internal<T0>(arg0, arg1, arg2, arg4, v2, arg5, arg6);
        };
    }

    // decompiled from Move bytecode v6
}

