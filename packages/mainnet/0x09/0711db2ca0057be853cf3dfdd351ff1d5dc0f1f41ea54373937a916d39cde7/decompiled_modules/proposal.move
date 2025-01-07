module 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::proposal {
    struct Proposal has key {
        id: 0x2::object::UID,
        serial_no: u64,
        threshold: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        votes: 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>,
        winning_option: 0x1::option::Option<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>,
        vote_leaderboards: 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::Leaderboard>,
        voters: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct ReturnTokenEvent has copy, drop {
        voter: address,
        amount: u64,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::vec_set::VecSet<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Proposal {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg4) + 1, 9223372496416538629);
        assert!(arg2 <= 0x2::clock::timestamp_ms(arg4) + 1209600000, 9223372522186473479);
        let v0 = 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::abstain_option();
        if (!0x2::vec_set::contains<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&arg3, &v0)) {
            0x2::vec_set::insert<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut arg3, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::abstain_option());
        };
        assert!(0x2::vec_set::size<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&arg3) > 2, 9223372556546736143);
        let v1 = 0x2::vec_map::empty<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>();
        let v2 = 0x2::vec_map::empty<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::Leaderboard>();
        let v3 = 0x2::vec_set::into_keys<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(arg3);
        0x1::vector::reverse<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut v3);
        while (0x1::vector::length<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&v3) != 0) {
            let v4 = 0x1::vector::pop_back<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut v3);
            0x2::vec_map::insert<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&mut v1, v4, 0);
            0x2::vec_map::insert<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::Leaderboard>(&mut v2, v4, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::new(10));
        };
        0x1::vector::destroy_empty<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(v3);
        Proposal{
            id                : 0x2::object::new(arg5),
            serial_no         : 0,
            threshold         : 0,
            title             : arg0,
            description       : arg1,
            votes             : v1,
            winning_option    : 0x1::option::none<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(),
            vote_leaderboards : v2,
            voters            : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(arg5),
            start_time_ms     : 0x2::clock::timestamp_ms(arg4),
            end_time_ms       : arg2,
        }
    }

    public fun end_time_ms(arg0: &Proposal) : u64 {
        arg0.end_time_ms
    }

    public fun finalize(arg0: &mut Proposal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&arg0.winning_option), 9223372887258955787);
        finalize_internal(arg0, arg1);
    }

    fun finalize_internal(arg0: &mut Proposal, arg1: &0x2::clock::Clock) {
        assert!(is_end_time_reached(arg0, arg1), 9223373278100848649);
        if (0x1::option::is_some<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&arg0.winning_option)) {
            return
        };
        if (!is_threshold_reached(arg0)) {
            0x1::option::fill<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut arg0.winning_option, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::threshold_not_reached());
            return
        };
        let v0 = arg0.votes;
        let (v1, v2) = 0x2::vec_map::pop<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&mut v0);
        let v3 = v2;
        let v4 = v1;
        if (v1 == 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::abstain_option()) {
            v3 = 0;
        };
        let v5 = false;
        while (!0x2::vec_map::is_empty<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&v0)) {
            let (v6, v7) = 0x2::vec_map::pop<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&mut v0);
            if (v6 == 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::abstain_option()) {
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
            0x1::option::fill<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut arg0.winning_option, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::tie_rejected());
        } else {
            0x1::option::fill<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption>(&mut arg0.winning_option, v4);
        };
    }

    public fun id(arg0: &Proposal) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_end_time_reached(arg0: &Proposal, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms
    }

    public(friend) fun is_threshold_reached(arg0: &Proposal) : bool {
        let (_, v1) = 0x2::vec_map::into_keys_values<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(arg0.votes);
        let v2 = 0;
        let v3 = v1;
        0x1::vector::reverse<u64>(&mut v3);
        while (0x1::vector::length<u64>(&v3) != 0) {
            v2 = v2 + 0x1::vector::pop_back<u64>(&mut v3);
        };
        0x1::vector::destroy_empty<u64>(v3);
        v2 >= arg0.threshold
    }

    public fun return_tokens(arg0: &mut Proposal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN> {
        finalize_internal(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        return_voter_coins(arg0, v0, arg2)
    }

    public fun return_tokens_bulk(arg0: &mut Proposal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        finalize_internal(arg0, arg1);
        let v0 = 0;
        while (!0x2::linked_table::is_empty<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&arg0.voters) && v0 < 125) {
            let v1 = *0x1::option::borrow<address>(0x2::linked_table::back<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&arg0.voters));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(return_voter_coins(arg0, v1, arg2), v1);
            v0 = v0 + 1;
        };
    }

    fun return_voter_coins(arg0: &mut Proposal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN> {
        assert!(0x2::linked_table::contains<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&arg0.voters, arg1), 9223373467079671821);
        let (_, v1) = 0x2::vec_map::into_keys_values<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(0x2::linked_table::remove<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&mut arg0.voters, arg1));
        let v2 = v1;
        let v3 = 0x1::vector::pop_back<0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(&mut v2);
        0x1::vector::reverse<0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(&mut v2);
        while (0x1::vector::length<0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(&v2) != 0) {
            0x2::balance::join<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&mut v3, 0x1::vector::pop_back<0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(&mut v2));
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(v2);
        let v4 = 0x2::coin::from_balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(v3, arg2);
        let v5 = ReturnTokenEvent{
            voter  : arg1,
            amount : 0x2::coin::value<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&v4),
        };
        0x2::event::emit<ReturnTokenEvent>(v5);
        v4
    }

    public fun serial_no(arg0: &Proposal) : u64 {
        arg0.serial_no
    }

    public(friend) fun set_serial_no(arg0: &mut Proposal, arg1: u64) {
        arg0.serial_no = arg1;
    }

    public(friend) fun set_threshold(arg0: &mut Proposal, arg1: u64) {
        arg0.threshold = arg1;
    }

    public(friend) fun share(arg0: Proposal) {
        0x2::transfer::share_object<Proposal>(arg0);
    }

    public fun start_time_ms(arg0: &Proposal) : u64 {
        arg0.start_time_ms
    }

    public fun vote(arg0: &mut Proposal, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::new(arg1);
        assert!(0x2::vec_map::contains<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&arg0.votes, &v0), 9223372719754575873);
        assert!(!is_end_time_reached(arg0, arg3), 9223372732639608835);
        let v1 = 0x2::vec_map::get_mut<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, u64>(&mut arg0.votes, &v0);
        *v1 = *v1 + 0x2::coin::value<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&arg2);
        if (!0x2::linked_table::contains<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&arg0.voters, 0x2::tx_context::sender(arg4))) {
            0x2::linked_table::push_back<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&mut arg0.voters, 0x2::tx_context::sender(arg4), 0x2::vec_map::empty<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>());
        };
        let v2 = 0x2::linked_table::borrow_mut<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&mut arg0.voters, 0x2::tx_context::sender(arg4));
        if (0x2::vec_map::contains<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(v2, &v0)) {
            let (_, v4) = 0x2::vec_map::remove<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(v2, &v0);
            let v5 = v4;
            0x2::balance::join<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&mut v5, 0x2::coin::into_balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(arg2));
            0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::add_if_eligible(0x2::vec_map::get_mut<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::Leaderboard>(&mut arg0.vote_leaderboards, &v0), 0x2::tx_context::sender(arg4), 0x2::balance::value<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&v5));
            0x2::vec_map::insert<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(v2, v0, v5);
            return
        };
        0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::add_if_eligible(0x2::vec_map::get_mut<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::leaderboard::Leaderboard>(&mut arg0.vote_leaderboards, &v0), 0x2::tx_context::sender(arg4), 0x2::coin::value<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(&arg2));
        0x2::vec_map::insert<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>(v2, v0, 0x2::coin::into_balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>(arg2));
    }

    public fun voters_count(arg0: &Proposal) : u64 {
        0x2::linked_table::length<address, 0x2::vec_map::VecMap<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption, 0x2::balance::Balance<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token::TOKEN>>>(&arg0.voters)
    }

    public fun winning_option(arg0: &Proposal) : 0x1::option::Option<0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::voting_option::VotingOption> {
        arg0.winning_option
    }

    // decompiled from Move bytecode v6
}

