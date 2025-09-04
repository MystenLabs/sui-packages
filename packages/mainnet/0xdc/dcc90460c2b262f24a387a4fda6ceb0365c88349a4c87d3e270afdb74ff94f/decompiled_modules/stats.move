module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats {
    struct Stats has key {
        id: 0x2::object::UID,
        tvl: u64,
        users: 0x2::table::Table<address, UserStats>,
    }

    struct UserStats has store {
        tvl: u64,
        rewards: u64,
        proposals: 0x2::table::Table<address, UserProposalStats>,
    }

    struct UserProposalStats has copy, drop, store {
        power: u64,
        reward: u64,
    }

    struct STATS has drop {
        dummy_field: bool,
    }

    public(friend) fun add_tvl(arg0: &mut Stats, arg1: u64) {
        arg0.tvl = arg0.tvl + arg1;
    }

    public(friend) fun add_user_reward(arg0: &mut Stats, arg1: address, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1);
        v0.rewards = v0.rewards + arg3;
        let v1 = 0x2::table::borrow_mut<address, UserProposalStats>(&mut v0.proposals, arg2);
        v1.reward = v1.reward + arg3;
    }

    public(friend) fun add_user_tvl(arg0: &mut Stats, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            0x2::table::add<address, UserStats>(&mut arg0.users, arg1, new_user_stats(arg3));
        };
        let v0 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1);
        v0.tvl = v0.tvl + arg2;
    }

    public(friend) fun add_user_vote(arg0: &mut Stats, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            0x2::table::add<address, UserStats>(&mut arg0.users, arg1, new_user_stats(arg4));
        };
        let v0 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1);
        if (!0x2::table::contains<address, UserProposalStats>(&v0.proposals, arg2)) {
            let v1 = UserProposalStats{
                power  : 0,
                reward : 0,
            };
            0x2::table::add<address, UserProposalStats>(&mut v0.proposals, arg2, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, UserProposalStats>(&mut v0.proposals, arg2);
        v2.power = v2.power + arg3;
    }

    fun init(arg0: STATS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            id    : 0x2::object::new(arg1),
            tvl   : 0,
            users : 0x2::table::new<address, UserStats>(arg1),
        };
        0x2::transfer::share_object<Stats>(v0);
    }

    fun new_user_stats(arg0: &mut 0x2::tx_context::TxContext) : UserStats {
        UserStats{
            tvl       : 0,
            rewards   : 0,
            proposals : 0x2::table::new<address, UserProposalStats>(arg0),
        }
    }

    public(friend) fun sub_tvl(arg0: &mut Stats, arg1: u64) {
        arg0.tvl = arg0.tvl - arg1;
    }

    public(friend) fun sub_user_tvl(arg0: &mut Stats, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1);
        v0.tvl = v0.tvl - arg2;
    }

    public fun tvl(arg0: &Stats) : u64 {
        arg0.tvl
    }

    public fun user_proposal_stats(arg0: &Stats, arg1: address, arg2: address) : (u64, u64) {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, UserStats>(&arg0.users, arg1);
        if (!0x2::table::contains<address, UserProposalStats>(&v0.proposals, arg2)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<address, UserProposalStats>(&v0.proposals, arg2);
        (v1.power, v1.reward)
    }

    public fun user_rewards(arg0: &Stats, arg1: address) : u64 {
        if (0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            0x2::table::borrow<address, UserStats>(&arg0.users, arg1).rewards
        } else {
            0
        }
    }

    public fun user_tvl(arg0: &Stats, arg1: address) : u64 {
        if (0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            0x2::table::borrow<address, UserStats>(&arg0.users, arg1).tvl
        } else {
            0
        }
    }

    public fun users(arg0: &Stats) : &0x2::table::Table<address, UserStats> {
        &arg0.users
    }

    // decompiled from Move bytecode v6
}

