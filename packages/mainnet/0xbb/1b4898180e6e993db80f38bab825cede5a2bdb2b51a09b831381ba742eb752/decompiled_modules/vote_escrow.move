module 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::vote_escrow {
    struct NewVoteEscrowEvent has copy, drop {
        id: u64,
        owner: address,
        amount_deposited: u64,
        start_timestampms: u64,
        end_timestampms: u64,
        total_ve_score_after: u64,
    }

    struct ClaimVoteEscrowEvent has copy, drop {
        id: u64,
        amount: u64,
        penalty: u64,
        total_ve_score_after: u64,
    }

    struct System has key {
        id: 0x2::object::UID,
        reward_balance: 0x2::balance::Balance<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>,
        locked_fund: 0x2::balance::Balance<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>,
        global_vote_escrow_id: u64,
        vote_escrow_by_voter: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>,
        ve_scores_by_voter: 0x2::table::Table<address, u64>,
        reward_per_ms: u64,
        last_updated_ms: u64,
        total_active_ve_score: u64,
        acc_reward_per_weight: u128,
    }

    struct VoteEscrow has copy, drop, store {
        amount_deposited: u64,
        start_timestampms: u64,
        end_timestampms: u64,
        reward_debt: u128,
        reward_pending: u64,
    }

    public fun claim(arg0: &mut System, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW> {
        let v0 = claim_reward(arg0, arg1, arg2, arg3);
        let (v1, v2) = remove_vesting(arg0, 0x2::tx_context::sender(arg3), arg1, 0x2::clock::timestamp_ms(arg2));
        let v3 = ClaimVoteEscrowEvent{
            id                   : arg1,
            amount               : v1,
            penalty              : v2,
            total_ve_score_after : get_ve_score(arg0, 0x2::tx_context::sender(arg3)),
        };
        0x2::event::emit<ClaimVoteEscrowEvent>(v3);
        let v4 = 0x2::coin::take<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.locked_fund, v1 - v2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>>(0x2::coin::take<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.locked_fund, v2, arg3), @0x0);
        0x2::coin::join<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut v4, v0);
        v4
    }

    public fun claim_reward(arg0: &mut System, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW> {
        update_reward(arg0, 0x2::tx_context::sender(arg3), arg1, arg2);
        let v0 = 0x2::vec_map::get_mut<u64, VoteEscrow>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, 0x2::tx_context::sender(arg3)), &arg1);
        v0.reward_pending = 0;
        0x2::coin::take<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.reward_balance, v0.reward_pending, arg3)
    }

    public fun claim_reward_all(arg0: &mut System, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW> {
        let v0 = 0x2::vec_map::keys<u64, VoteEscrow>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, 0x2::tx_context::sender(arg2)));
        let v1 = 0;
        let v2 = 0x2::coin::zero<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(arg2);
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            0x2::coin::join<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut v2, claim_reward(arg0, *0x1::vector::borrow<u64>(&v0, v1), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    public fun get_end_timestampms(arg0: &VoteEscrow) : u64 {
        arg0.end_timestampms
    }

    public fun get_start_timestampms(arg0: &VoteEscrow) : u64 {
        arg0.start_timestampms
    }

    public fun get_ve_score(arg0: &System, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.ve_scores_by_voter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.ve_scores_by_voter, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = System{
            id                    : 0x2::object::new(arg0),
            reward_balance        : 0x2::balance::zero<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(),
            locked_fund           : 0x2::balance::zero<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(),
            global_vote_escrow_id : 0,
            vote_escrow_by_voter  : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(arg0),
            ve_scores_by_voter    : 0x2::table::new<address, u64>(arg0),
            reward_per_ms         : 0,
            last_updated_ms       : 0,
            total_active_ve_score : 0,
            acc_reward_per_weight : 0,
        };
        0x2::transfer::share_object<System>(v0);
    }

    fun new_vesting(arg0: &mut System, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = VoteEscrow{
            amount_deposited  : arg2,
            start_timestampms : arg4,
            end_timestampms   : arg4 + arg3 * 60 * 1000,
            reward_debt       : 0,
            reward_pending    : 0,
        };
        arg0.global_vote_escrow_id = arg0.global_vote_escrow_id + 1;
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&arg0.vote_escrow_by_voter, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, arg1, 0x2::vec_map::empty<u64, VoteEscrow>());
        };
        0x2::vec_map::insert<u64, VoteEscrow>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, arg1), arg0.global_vote_escrow_id, v0);
        if (0x2::table::contains<address, u64>(&arg0.ve_scores_by_voter, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.ve_scores_by_voter, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.ve_scores_by_voter, arg1, get_ve_score(arg0, arg1) + arg2 * arg3);
    }

    fun remove_vesting(arg0: &mut System, arg1: address, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, arg1);
        let v1 = 0x2::vec_map::get<u64, VoteEscrow>(v0, &arg2);
        let v2 = v1.amount_deposited;
        let v3 = v1.start_timestampms;
        let v4 = v1.end_timestampms;
        let v5 = v4 - v3;
        let (_, _) = 0x2::vec_map::remove<u64, VoteEscrow>(v0, &arg2);
        0x2::table::remove<address, u64>(&mut arg0.ve_scores_by_voter, arg1);
        0x2::table::add<address, u64>(&mut arg0.ve_scores_by_voter, arg1, get_ve_score(arg0, arg1) - v2 * v5);
        let v8 = if (arg3 < v4 && arg3 > v3) {
            v2 - v2 * (arg3 - v3) / v5
        } else {
            0
        };
        (v2, v8)
    }

    fun update_reward(arg0: &mut System, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.total_active_ve_score > 0) {
            arg0.acc_reward_per_weight = arg0.acc_reward_per_weight + ((arg0.reward_per_ms * (v0 - arg0.last_updated_ms)) as u128) * (1000000000000000000 as u128) / (arg0.total_active_ve_score as u128);
            arg0.last_updated_ms = v0;
        };
        let v1 = 0x2::vec_map::get_mut<u64, VoteEscrow>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, VoteEscrow>>(&mut arg0.vote_escrow_by_voter, arg1), &arg2);
        v1.reward_pending = v1.reward_pending + (((arg0.acc_reward_per_weight - v1.reward_debt) * (get_ve_score(arg0, arg1) as u128) / (1000000000000000000 as u128)) as u64);
        v1.reward_debt = arg0.acc_reward_per_weight;
    }

    public fun vesting(arg0: &mut System, arg1: &0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::Config, arg2: 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 <= 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::get_max_time_vesting(arg1), 0);
        new_vesting(arg0, 0x2::tx_context::sender(arg5), 0x2::coin::value<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&arg2), arg3, v0);
        let v1 = NewVoteEscrowEvent{
            id                   : arg0.global_vote_escrow_id,
            owner                : 0x2::tx_context::sender(arg5),
            amount_deposited     : 0x2::coin::value<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&arg2),
            start_timestampms    : v0,
            end_timestampms      : v0 + arg3 * 60 * 1000,
            total_ve_score_after : get_ve_score(arg0, 0x2::tx_context::sender(arg5)),
        };
        0x2::event::emit<NewVoteEscrowEvent>(v1);
        0x2::coin::put<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.locked_fund, arg2);
    }

    // decompiled from Move bytecode v6
}

