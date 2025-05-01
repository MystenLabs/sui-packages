module 0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::poll {
    struct PollRegistry has key {
        id: 0x2::object::UID,
        polls: 0x2::table::Table<address, bool>,
        owner: address,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        poll_creation_fee: u64,
        poll_vote_fee: u64,
    }

    struct Poll has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        options: vector<0x1::string::String>,
        votes: 0x2::vec_map::VecMap<u64, u64>,
        creator: address,
        creation_timestamp: u64,
        end_timestamp: u64,
        voters: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, u64>>,
        allow_multiple_votes: bool,
        allow_multiple_choices: bool,
    }

    public(friend) entry fun claim_fees(arg0: &mut PollRegistry, arg1: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::earners::EarnerRegistry, arg2: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        if (v0 > 0) {
            let v1 = 0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::earners::claim_fees(arg1, arg2, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, v0, arg3), arg3);
            if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
            };
        };
    }

    public(friend) entry fun create_poll(arg0: &mut PollRegistry, arg1: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::assert_not_paused(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(0x1::string::utf8(arg2) != 0x1::string::utf8(b""), 10);
        assert!(v1 > 0, 3);
        assert!(v1 <= 10, 2);
        assert!(arg5 > v0, 1);
        assert!(arg0.poll_creation_fee > 0, 13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == arg0.poll_creation_fee, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
        let v2 = 0x2::vec_map::empty<u64, u64>();
        let v3 = 0;
        while (v3 < v1) {
            0x2::vec_map::insert<u64, u64>(&mut v2, v3, 0);
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v3)));
            v3 = v3 + 1;
        };
        let v5 = Poll{
            id                     : 0x2::object::new(arg10),
            title                  : 0x1::string::utf8(arg2),
            description            : 0x1::string::utf8(arg3),
            options                : v4,
            votes                  : v2,
            creator                : 0x2::tx_context::sender(arg10),
            creation_timestamp     : v0,
            end_timestamp          : arg5,
            voters                 : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg10),
            allow_multiple_votes   : arg6,
            allow_multiple_choices : arg7,
        };
        0x2::table::add<address, bool>(&mut arg0.polls, 0x2::object::uid_to_address(&v5.id), true);
        0x2::transfer::share_object<Poll>(v5);
    }

    public(friend) entry fun delete_poll(arg0: Poll, arg1: &mut PollRegistry, arg2: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg3: &0x2::tx_context::TxContext) {
        0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::assert_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator || v0 == arg1.owner, 0);
        0x2::table::remove<address, bool>(&mut arg1.polls, 0x2::object::uid_to_address(&arg0.id));
        let Poll {
            id                     : v1,
            title                  : _,
            description            : _,
            options                : _,
            votes                  : _,
            creator                : _,
            creation_timestamp     : _,
            end_timestamp          : _,
            voters                 : v9,
            allow_multiple_votes   : _,
            allow_multiple_choices : _,
        } = arg0;
        0x2::table::drop<address, 0x2::vec_map::VecMap<u64, u64>>(v9);
        0x2::object::delete(v1);
    }

    public(friend) entry fun end_poll(arg0: &mut Poll, arg1: &0x2::clock::Clock, arg2: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg3: &0x2::tx_context::TxContext) {
        0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::assert_not_paused(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0);
        assert!(v0 < arg0.end_timestamp, 4);
        arg0.end_timestamp = v0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PollRegistry{
            id                : 0x2::object::new(arg0),
            polls             : 0x2::table::new<address, bool>(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            fees              : 0x2::balance::zero<0x2::sui::SUI>(),
            poll_creation_fee : 490000000,
            poll_vote_fee     : 10000000,
        };
        0x2::transfer::share_object<PollRegistry>(v0);
    }

    public(friend) entry fun set_poll_creation_fee(arg0: &mut PollRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 > 0, 13);
        arg0.poll_creation_fee = arg1;
    }

    public(friend) entry fun set_poll_vote_fee(arg0: &mut PollRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 > 0, 13);
        arg0.poll_vote_fee = arg1;
    }

    public(friend) entry fun vote(arg0: &mut Poll, arg1: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut PollRegistry, arg6: &0x2::tx_context::TxContext) {
        0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 > 0, 3);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_timestamp, 4);
        if (v1 > 1) {
            assert!(arg0.allow_multiple_choices, 12);
        };
        assert!(arg5.poll_vote_fee > 0, 13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg5.poll_vote_fee * (v1 as u64), 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg5.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        if (0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.voters, v0)) {
            assert!(arg0.allow_multiple_votes, 11);
            let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.voters, v0);
            let v3 = 0;
            while (v3 < v1) {
                let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
                assert!(v4 < 0x1::vector::length<0x1::string::String>(&arg0.options), 8);
                if (0x2::vec_map::contains<u64, u64>(v2, &v4)) {
                    let v5 = 0x2::vec_map::get_mut<u64, u64>(v2, &v4);
                    *v5 = *v5 + 1;
                } else {
                    0x2::vec_map::insert<u64, u64>(v2, v4, 1);
                };
                let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.votes, &v4);
                0x2::vec_map::insert<u64, u64>(&mut arg0.votes, v4, *0x2::vec_map::get<u64, u64>(&arg0.votes, &v4) + 1);
                v3 = v3 + 1;
            };
        } else {
            let v8 = 0x2::vec_map::empty<u64, u64>();
            let v9 = 0;
            while (v9 < v1) {
                let v10 = *0x1::vector::borrow<u64>(&arg2, v9);
                assert!(v10 < 0x1::vector::length<0x1::string::String>(&arg0.options), 8);
                0x2::vec_map::insert<u64, u64>(&mut v8, v10, 1);
                let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.votes, &v10);
                0x2::vec_map::insert<u64, u64>(&mut arg0.votes, v10, *0x2::vec_map::get<u64, u64>(&arg0.votes, &v10) + 1);
                v9 = v9 + 1;
            };
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.voters, v0, v8);
        };
    }

    // decompiled from Move bytecode v6
}

