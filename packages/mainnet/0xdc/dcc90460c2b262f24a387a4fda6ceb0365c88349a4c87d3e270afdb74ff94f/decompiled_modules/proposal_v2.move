module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2 {
    struct ProposalV2 has key {
        id: 0x2::object::UID,
        serial_no: u64,
        threshold: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        winning_option: 0x1::option::Option<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>,
        vote_leaderboards: 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::Leaderboard>,
        start_time_ms: u64,
        end_time_ms: u64,
        votes: 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>,
        voters: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>>,
        voter_powers: 0x2::linked_table::LinkedTable<address, u64>,
        total_power: u64,
        reward: 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>,
        total_reward: u64,
        creator: address,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::vec_set::VecSet<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>, arg4: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ProposalV2 {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg5) + 86400000, 1002);
        assert!(arg2 <= 0x2::clock::timestamp_ms(arg5) + 1209600000, 1003);
        let v0 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::abstain_option();
        if (!0x2::vec_set::contains<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&arg3, &v0)) {
            0x2::vec_set::insert<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut arg3, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::abstain_option());
        };
        assert!(0x2::vec_set::size<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&arg3) > 2, 1006);
        let v1 = 0x2::vec_map::empty<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>();
        let v2 = 0x2::vec_map::empty<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::Leaderboard>();
        let v3 = 0x2::vec_set::into_keys<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(arg3);
        0x1::vector::reverse<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&v3)) {
            let v5 = 0x1::vector::pop_back<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut v3);
            0x2::vec_map::insert<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&mut v1, v5, 0);
            0x2::vec_map::insert<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::Leaderboard>(&mut v2, v5, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::new(10));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(v3);
        ProposalV2{
            id                : 0x2::object::new(arg6),
            serial_no         : 0,
            threshold         : 0,
            title             : arg0,
            description       : arg1,
            winning_option    : 0x1::option::none<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(),
            vote_leaderboards : v2,
            start_time_ms     : 0x2::clock::timestamp_ms(arg5),
            end_time_ms       : arg2,
            votes             : v1,
            voters            : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>>(arg6),
            voter_powers      : 0x2::linked_table::new<address, u64>(arg6),
            total_power       : 0,
            reward            : 0x2::coin::into_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg4),
            total_reward      : 0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg4),
            creator           : 0x2::tx_context::sender(arg6),
        }
    }

    fun calculate_reward(arg0: &ProposalV2, arg1: u64) : u64 {
        if (arg0.total_power == 0) {
            return 0
        };
        (((arg1 as u128) * (arg0.total_reward as u128) / (arg0.total_power as u128)) as u64)
    }

    public fun claim_reward(arg0: &mut ProposalV2, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS> {
        finalize_internal(arg0, arg2, arg3);
        get_user_reward(arg0, arg1, 0x2::tx_context::sender(arg3))
    }

    public fun creator(arg0: &ProposalV2) : address {
        arg0.creator
    }

    public fun description(arg0: &ProposalV2) : &0x1::string::String {
        &arg0.description
    }

    public fun distribute_rewards(arg0: &mut ProposalV2, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        finalize_internal(arg0, arg2, arg3);
        let v0 = 0;
        while (v0 < 125 && !0x2::linked_table::is_empty<address, u64>(&arg0.voter_powers)) {
            let v1 = *0x1::option::borrow<address>(0x2::linked_table::front<address, u64>(&arg0.voter_powers));
            let v2 = get_user_reward(arg0, arg1, v1);
            let v3 = 0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v2, arg3);
            if (0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&v3) == 0) {
                0x2::coin::destroy_zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(v3, v1);
            };
            v0 = v0 + 1;
        };
        if (0x2::linked_table::is_empty<address, u64>(&arg0.voter_powers) && 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.reward) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::balance::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.reward, 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.reward)), arg3), arg0.creator);
        };
    }

    public fun end_time_ms(arg0: &ProposalV2) : u64 {
        arg0.end_time_ms
    }

    public fun finalize(arg0: &mut ProposalV2, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&arg0.winning_option), 1005);
        finalize_internal(arg0, arg1, arg2);
    }

    fun finalize_internal(arg0: &mut ProposalV2, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_end_time_reached(arg0, arg1), 1004);
        if (0x1::option::is_some<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&arg0.winning_option)) {
            return
        };
        if (!is_threshold_reached(arg0)) {
            0x1::option::fill<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut arg0.winning_option, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::threshold_not_reached());
            arg0.total_reward = 0;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::balance::withdraw_all<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.reward), arg2), arg0.creator);
            return
        };
        let v0 = arg0.votes;
        let (v1, v2) = 0x2::vec_map::pop<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&mut v0);
        let v3 = v2;
        let v4 = v1;
        if (v1 == 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::abstain_option()) {
            v3 = 0;
        };
        let v5 = false;
        while (!0x2::vec_map::is_empty<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&v0)) {
            let (v6, v7) = 0x2::vec_map::pop<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&mut v0);
            if (v6 == 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::abstain_option()) {
                continue
            };
            if (v7 > v3) {
                v3 = v7;
                v4 = v6;
                v5 = false;
                continue
            };
            if (v7 == v3) {
                v5 = true;
            };
        };
        if (v5) {
            0x1::option::fill<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut arg0.winning_option, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::tie_rejected());
        } else {
            0x1::option::fill<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption>(&mut arg0.winning_option, v4);
        };
    }

    fun get_user_reward(arg0: &mut ProposalV2, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: address) : 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS> {
        assert!(0x2::linked_table::contains<address, u64>(&arg0.voter_powers, arg2), 1009);
        let v0 = calculate_reward(arg0, 0x2::linked_table::remove<address, u64>(&mut arg0.voter_powers, arg2));
        if (v0 > 0) {
            0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::add_user_reward(arg1, arg2, 0x2::object::uid_to_address(&arg0.id), v0);
            0x2::balance::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.reward, v0)
        } else {
            0x2::balance::zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>()
        }
    }

    public fun id(arg0: &ProposalV2) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_end_time_reached(arg0: &ProposalV2, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms
    }

    public(friend) fun is_threshold_reached(arg0: &ProposalV2) : bool {
        arg0.total_power >= arg0.threshold
    }

    public fun reward(arg0: &ProposalV2) : &0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS> {
        &arg0.reward
    }

    public fun serial_no(arg0: &ProposalV2) : u64 {
        arg0.serial_no
    }

    public(friend) fun set_serial_no(arg0: &mut ProposalV2, arg1: u64) {
        arg0.serial_no = arg1;
    }

    public(friend) fun set_threshold(arg0: &mut ProposalV2, arg1: u64) {
        arg0.threshold = arg1;
    }

    public(friend) fun share(arg0: ProposalV2) {
        0x2::transfer::share_object<ProposalV2>(arg0);
    }

    public fun start_time_ms(arg0: &ProposalV2) : u64 {
        arg0.start_time_ms
    }

    public fun threshold(arg0: &ProposalV2) : u64 {
        arg0.threshold
    }

    public fun title(arg0: &ProposalV2) : &0x1::string::String {
        &arg0.title
    }

    public fun total_power(arg0: &ProposalV2) : u64 {
        arg0.total_power
    }

    public fun total_reward(arg0: &ProposalV2) : u64 {
        arg0.total_reward
    }

    public fun vote(arg0: &mut ProposalV2, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg2: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg3: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::StakingBatch, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::new(arg4);
        assert!(0x2::vec_map::contains<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&arg0.votes, &v1), 1000);
        assert!(!is_end_time_reached(arg0, arg5), 1001);
        assert!(!0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::is_cooldown_requested(arg3), 1008);
        assert!(!0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::is_voting(arg3, arg5), 1007);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::set_voting_until_ms(arg3, arg0.end_time_ms, arg5);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::set_last_vote(arg3, arg4);
        let v2 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::power(arg3, arg1, arg5);
        arg0.total_power = arg0.total_power + v2;
        let v3 = 0x2::vec_map::get_mut<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(&mut arg0.votes, &v1);
        *v3 = *v3 + v2;
        if (!0x2::linked_table::contains<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>>(&arg0.voters, v0)) {
            0x2::linked_table::push_back<address, u64>(&mut arg0.voter_powers, v0, 0);
            0x2::linked_table::push_back<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>>(&mut arg0.voters, v0, 0x2::vec_map::empty<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>());
        };
        let v4 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.voter_powers, v0);
        *v4 = *v4 + v2;
        let v5 = 0x2::linked_table::borrow_mut<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>>(&mut arg0.voters, v0);
        if (!0x2::vec_map::contains<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(v5, &v1)) {
            0x2::vec_map::insert<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(v5, v1, v2);
        } else {
            let v6 = 0x2::vec_map::get_mut<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(v5, &v1);
            *v6 = *v6 + v2;
        };
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::add_if_eligible(0x2::vec_map::get_mut<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::Leaderboard>(&mut arg0.vote_leaderboards, &v1), v0, *0x2::vec_map::get<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>(v5, &v1));
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::add_user_vote(arg2, v0, 0x2::object::uid_to_address(&arg0.id), v2, arg6);
    }

    public fun vote_leaderboards(arg0: &ProposalV2) : &0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::leaderboard::Leaderboard> {
        &arg0.vote_leaderboards
    }

    public fun voter_powers(arg0: &ProposalV2) : &0x2::linked_table::LinkedTable<address, u64> {
        &arg0.voter_powers
    }

    public fun voters(arg0: &ProposalV2) : &0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64>> {
        &arg0.voters
    }

    public fun votes(arg0: &ProposalV2) : &0x2::vec_map::VecMap<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption, u64> {
        &arg0.votes
    }

    public fun winning_option(arg0: &ProposalV2) : &0x1::option::Option<0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::voting_option::VotingOption> {
        &arg0.winning_option
    }

    // decompiled from Move bytecode v6
}

