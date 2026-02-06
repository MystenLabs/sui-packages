module 0xc66313cc4815b4fc6ecd2bdf4ccbf3c0277da40b2cb2562c6ab996b91b25c9c5::vacuum {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoundRewards has store {
        total_shares: u64,
        rewards: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DustVault has key {
        id: 0x2::object::UID,
        admin: address,
        tokens: 0x2::bag::Bag,
        token_types: 0x2::vec_set::VecSet<0x1::ascii::String>,
        history: 0x2::table::Table<u64, RoundRewards>,
        current_round_shares: u64,
        target_usd_value: u64,
        current_usd_value: u64,
        staked_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        round: u64,
        is_open: bool,
        depositors_count: u64,
        total_lifetime_shares: u64,
        total_fees_collected: u64,
    }

    struct DustDAOMembership has store, key {
        id: 0x2::object::UID,
        member: address,
        lifetime_shares: u64,
        total_sui_earned: u64,
        staked_amount: u64,
        reward_preference: u8,
        joined_at_ms: u64,
    }

    struct DepositReceipt has store, key {
        id: 0x2::object::UID,
        depositor: address,
        shares: u64,
        round: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        title: vector<u8>,
        creator: address,
        votes_for: u64,
        votes_against: u64,
        voters: 0x2::table::Table<address, bool>,
        start_time_ms: u64,
        end_time_ms: u64,
        is_active: bool,
    }

    struct DustDepositedEvent has copy, drop {
        user: address,
        token_type: 0x1::ascii::String,
        amount: u64,
        usd_value: u64,
        shares: u64,
        round: u64,
        timestamp_ms: u64,
    }

    struct BatchSwapEvent has copy, drop {
        token_type: 0x1::ascii::String,
        amount_swapped: u64,
        sui_received: u64,
        round: u64,
        timestamp_ms: u64,
    }

    struct RewardsClaimedEvent has copy, drop {
        user: address,
        shares: u64,
        sui_amount: u64,
        round: u64,
        timestamp_ms: u64,
    }

    struct RewardsStakedEvent has copy, drop {
        user: address,
        shares: u64,
        sui_amount: u64,
        round: u64,
        timestamp_ms: u64,
    }

    struct MembershipCreatedEvent has copy, drop {
        user: address,
        initial_shares: u64,
        timestamp_ms: u64,
    }

    struct VoteCastEvent has copy, drop {
        voter: address,
        proposal_id: u64,
        vote_for: bool,
        voting_power: u64,
        timestamp_ms: u64,
    }

    struct IndividualSwapEvent has copy, drop {
        user: address,
        token_type: 0x1::ascii::String,
        amount: u64,
        sui_received: u64,
        timestamp_ms: u64,
    }

    struct BatchSwapCompleteEvent has copy, drop {
        round: u64,
        total_sui_received: u64,
        admin_fee: u64,
        user_rewards: u64,
        depositors_count: u64,
        timestamp_ms: u64,
    }

    public fun admin_fee_bps() : u64 {
        200
    }

    public fun claim_rewards(arg0: &mut DustVault, arg1: DepositReceipt, arg2: &mut DustDAOMembership, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let DepositReceipt {
            id        : v0,
            depositor : _,
            shares    : v2,
            round     : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(0x2::table::contains<u64, RoundRewards>(&arg0.history, v3), 9);
        let v4 = 0x2::table::borrow_mut<u64, RoundRewards>(&mut arg0.history, v3);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4.rewards);
        assert!(v5 > 0, 1);
        let v6 = (((v2 as u128) * (v5 as u128) / (v4.total_shares as u128)) as u64);
        arg2.lifetime_shares = arg2.lifetime_shares + v2;
        arg2.total_sui_earned = arg2.total_sui_earned + v6;
        let v7 = RewardsClaimedEvent{
            user         : 0x2::tx_context::sender(arg4),
            shares       : v2,
            sui_amount   : v6,
            round        : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardsClaimedEvent>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4.rewards, v6), arg4)
    }

    public fun close_proposal(arg0: &AdminCap, arg1: &mut Proposal) {
        arg1.is_active = false;
    }

    public fun close_vault(arg0: &AdminCap, arg1: &mut DustVault) {
        arg1.is_open = false;
    }

    public fun create_membership(arg0: &DustVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DustDAOMembership {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MembershipCreatedEvent{
            user           : v0,
            initial_shares : 0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<MembershipCreatedEvent>(v1);
        DustDAOMembership{
            id                : 0x2::object::new(arg2),
            member            : v0,
            lifetime_shares   : 0,
            total_sui_earned  : 0,
            staked_amount     : 0,
            reward_preference : 0,
            joined_at_ms      : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun create_proposal(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Proposal{
            id            : 0x2::object::new(arg4),
            proposal_id   : v0,
            title         : arg1,
            creator       : 0x2::tx_context::sender(arg4),
            votes_for     : 0,
            votes_against : 0,
            voters        : 0x2::table::new<address, bool>(arg4),
            start_time_ms : v0,
            end_time_ms   : v0 + arg2,
            is_active     : true,
        };
        0x2::transfer::share_object<Proposal>(v1);
    }

    public fun deposit_dust<T0>(arg0: &mut DustVault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 0);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 100000000, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.tokens, v1)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.tokens, v1, 0x2::balance::zero<T0>());
            0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.token_types, v1);
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.tokens, v1), 0x2::coin::into_balance<T0>(arg1));
        arg0.current_round_shares = arg0.current_round_shares + arg2;
        arg0.current_usd_value = arg0.current_usd_value + arg2;
        arg0.total_lifetime_shares = arg0.total_lifetime_shares + arg2;
        arg0.depositors_count = arg0.depositors_count + 1;
        let v2 = DepositReceipt{
            id        : 0x2::object::new(arg4),
            depositor : v0,
            shares    : arg2,
            round     : arg0.round,
        };
        0x2::transfer::public_transfer<DepositReceipt>(v2, v0);
        let v3 = DustDepositedEvent{
            user         : v0,
            token_type   : v1,
            amount       : 0x2::coin::value<T0>(&arg1),
            usd_value    : arg2,
            shares       : arg2,
            round        : arg0.round,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DustDepositedEvent>(v3);
    }

    public fun deposit_sui_rewards_with_fee(arg0: &AdminCap, arg1: &mut DustVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = v0 * 200 / 10000;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = RoundRewards{
            total_shares : arg1.current_round_shares,
            rewards      : v2,
        };
        0x2::table::add<u64, RoundRewards>(&mut arg1.history, arg1.round, v3);
        arg1.total_fees_collected = arg1.total_fees_collected + v1;
        let v4 = BatchSwapCompleteEvent{
            round              : arg1.round,
            total_sui_received : v0,
            admin_fee          : v1,
            user_rewards       : v0 - v1,
            depositors_count   : arg1.depositors_count,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchSwapCompleteEvent>(v4);
        arg1.round = arg1.round + 1;
        arg1.current_round_shares = 0;
        arg1.depositors_count = 0;
        arg1.current_usd_value = 0;
        arg1.is_open = true;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v1), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = DustVault{
            id                    : 0x2::object::new(arg0),
            admin                 : v0,
            tokens                : 0x2::bag::new(arg0),
            token_types           : 0x2::vec_set::empty<0x1::ascii::String>(),
            history               : 0x2::table::new<u64, RoundRewards>(arg0),
            current_round_shares  : 0,
            target_usd_value      : 0,
            current_usd_value     : 0,
            staked_sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            round                 : 1,
            is_open               : true,
            depositors_count      : 0,
            total_lifetime_shares : 0,
            total_fees_collected  : 0,
        };
        0x2::transfer::share_object<DustVault>(v2);
    }

    public fun log_batch_swap<T0>(arg0: &AdminCap, arg1: &DustVault, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = BatchSwapEvent{
            token_type     : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount_swapped : arg2,
            sui_received   : arg3,
            round          : arg1.round,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchSwapEvent>(v0);
    }

    public fun log_individual_swap<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = IndividualSwapEvent{
            user         : 0x2::tx_context::sender(arg3),
            token_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount       : arg0,
            sui_received : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<IndividualSwapEvent>(v0);
    }

    public fun membership_lifetime_shares(arg0: &DustDAOMembership) : u64 {
        arg0.lifetime_shares
    }

    public fun membership_preference(arg0: &DustDAOMembership) : u8 {
        arg0.reward_preference
    }

    public fun membership_staked(arg0: &DustDAOMembership) : u64 {
        arg0.staked_amount
    }

    public fun membership_total_earned(arg0: &DustDAOMembership) : u64 {
        arg0.total_sui_earned
    }

    public fun open_vault(arg0: &AdminCap, arg1: &mut DustVault) {
        arg1.is_open = true;
    }

    public fun proposal_is_active(arg0: &Proposal) : bool {
        arg0.is_active
    }

    public fun proposal_votes_against(arg0: &Proposal) : u64 {
        arg0.votes_against
    }

    public fun proposal_votes_for(arg0: &Proposal) : u64 {
        arg0.votes_for
    }

    public fun receipt_round(arg0: &DepositReceipt) : u64 {
        arg0.round
    }

    public fun receipt_shares(arg0: &DepositReceipt) : u64 {
        arg0.shares
    }

    public fun set_target_usd_value(arg0: &AdminCap, arg1: &mut DustVault, arg2: u64) {
        arg1.target_usd_value = arg2;
    }

    public fun stake_rewards(arg0: &mut DustVault, arg1: DepositReceipt, arg2: &mut DustDAOMembership, arg3: &0x2::clock::Clock) {
        let DepositReceipt {
            id        : v0,
            depositor : _,
            shares    : v2,
            round     : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(0x2::table::contains<u64, RoundRewards>(&arg0.history, v3), 9);
        let v4 = 0x2::table::borrow_mut<u64, RoundRewards>(&mut arg0.history, v3);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4.rewards);
        assert!(v5 > 0, 1);
        let v6 = (((v2 as u128) * (v5 as u128) / (v4.total_shares as u128)) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staked_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v4.rewards, v6));
        arg2.lifetime_shares = arg2.lifetime_shares + v2;
        arg2.staked_amount = arg2.staked_amount + v6;
        arg2.reward_preference = 1;
        let v7 = RewardsStakedEvent{
            user         : arg2.member,
            shares       : v2,
            sui_amount   : v6,
            round        : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardsStakedEvent>(v7);
    }

    public fun vault_admin(arg0: &DustVault) : address {
        arg0.admin
    }

    public fun vault_current_value(arg0: &DustVault) : u64 {
        arg0.current_usd_value
    }

    public fun vault_depositors_count(arg0: &DustVault) : u64 {
        arg0.depositors_count
    }

    public fun vault_is_open(arg0: &DustVault) : bool {
        arg0.is_open
    }

    public fun vault_lifetime_shares(arg0: &DustVault) : u64 {
        arg0.total_lifetime_shares
    }

    public fun vault_round(arg0: &DustVault) : u64 {
        arg0.round
    }

    public fun vault_staked_sui(arg0: &DustVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.staked_sui)
    }

    public fun vault_target_value(arg0: &DustVault) : u64 {
        arg0.target_usd_value
    }

    public fun vault_token_balance<T0>(arg0: &DustVault) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.tokens, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.tokens, v0))
        } else {
            0
        }
    }

    public fun vault_token_types(arg0: &DustVault) : vector<0x1::ascii::String> {
        *0x2::vec_set::keys<0x1::ascii::String>(&arg0.token_types)
    }

    public fun vault_total_fees(arg0: &DustVault) : u64 {
        arg0.total_fees_collected
    }

    public fun vault_total_shares(arg0: &DustVault) : u64 {
        arg0.current_round_shares
    }

    public fun vote(arg0: &mut Proposal, arg1: &DustDAOMembership, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = arg1.member;
        let v1 = arg1.lifetime_shares;
        assert!(v1 > 0, 7);
        assert!(arg0.is_active, 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.end_time_ms, 6);
        assert!(!0x2::table::contains<address, bool>(&arg0.voters, v0), 5);
        0x2::table::add<address, bool>(&mut arg0.voters, v0, arg2);
        if (arg2) {
            arg0.votes_for = arg0.votes_for + v1;
        } else {
            arg0.votes_against = arg0.votes_against + v1;
        };
        let v2 = VoteCastEvent{
            voter        : v0,
            proposal_id  : arg0.proposal_id,
            vote_for     : arg2,
            voting_power : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VoteCastEvent>(v2);
    }

    public fun withdraw_for_swap<T0>(arg0: &AdminCap, arg1: &mut DustVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.tokens, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.tokens, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 > 0, 1);
        0x2::coin::take<T0>(v1, v2, arg2)
    }

    public fun withdraw_staked(arg0: &mut DustVault, arg1: &mut DustDAOMembership, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.staked_amount >= arg2, 1);
        arg1.staked_amount = arg1.staked_amount - arg2;
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.staked_sui, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

