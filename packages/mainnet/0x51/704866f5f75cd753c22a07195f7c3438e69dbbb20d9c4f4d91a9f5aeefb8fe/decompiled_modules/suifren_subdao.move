module 0x51704866f5f75cd753c22a07195f7c3438e69dbbb20d9c4f4d91a9f5aeefb8fe::suifren_subdao {
    struct SUIFREN_SUBDAO has drop {
        dummy_field: bool,
    }

    struct SubDao<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        origin_dao: 0x2::object::ID,
        birth_location: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x2::url::Url,
        quorum: u64,
        voting_delay: u64,
        voting_period: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        proposals: 0x2::table::Table<0x2::object::ID, Proposal>,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        recipient: 0x1::option::Option<address>,
        amount: 0x1::option::Option<u64>,
        status: u64,
        creator: address,
        start_time: u64,
        end_time: u64,
        results: 0x2::vec_map::VecMap<u64, u64>,
        nft_votes: 0x2::table::Table<0x2::object::ID, bool>,
        address_votes: 0x2::table::Table<address, u64>,
        address_vote_types: 0x2::table::Table<address, u64>,
    }

    struct ProposalCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct ProposalCanceled has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct Voted has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        voter: address,
        vote: u64,
    }

    struct ProposalEnded has copy, drop {
        id: 0x2::object::ID,
        status: u64,
        name: 0x1::string::String,
    }

    entry fun cancel_proposal<T0: store + key>(arg0: &mut SubDao<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 6);
        assert!(v0.status == 0, 7);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.start_time, 2);
        v0.status = 1;
    }

    public fun create_proposal<T0: store + key>(arg0: &mut SubDao<T0>, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.birth_location == 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::birth_location<T0>(arg1), 8);
        assert!(arg4 == 0 || arg4 == 1, 9);
        if (arg4 == 1) {
            assert!(0x1::option::is_some<address>(&arg5), 9);
            assert!(0x1::option::is_some<u64>(&arg6), 9);
        } else if (arg4 == 0) {
            assert!(0x1::option::is_none<address>(&arg5), 9);
            assert!(0x1::option::is_none<u64>(&arg6), 9);
        };
        let v0 = 0x2::vec_map::empty<u64, u64>();
        0x2::vec_map::insert<u64, u64>(&mut v0, 1, 0);
        0x2::vec_map::insert<u64, u64>(&mut v0, 2, 0);
        0x2::vec_map::insert<u64, u64>(&mut v0, 0, 0);
        let v1 = Proposal{
            id                 : 0x2::object::new(arg8),
            name               : arg2,
            description        : arg3,
            type               : arg4,
            recipient          : arg5,
            amount             : arg6,
            status             : 0,
            creator            : 0x2::tx_context::sender(arg8),
            start_time         : 0x2::clock::timestamp_ms(arg7) + arg0.voting_delay,
            end_time           : 0x2::clock::timestamp_ms(arg7) + arg0.voting_delay + arg0.voting_period,
            results            : v0,
            nft_votes          : 0x2::table::new<0x2::object::ID, bool>(arg8),
            address_votes      : 0x2::table::new<address, u64>(arg8),
            address_vote_types : 0x2::table::new<address, u64>(arg8),
        };
        let v2 = ProposalCreated{
            id      : 0x2::object::id<Proposal>(&v1),
            name    : v1.name,
            creator : v1.creator,
        };
        0x2::event::emit<ProposalCreated>(v2);
        0x2::table::add<0x2::object::ID, Proposal>(&mut arg0.proposals, 0x2::object::id<Proposal>(&v1), v1);
    }

    entry fun create_subdao<T0: store + key>(arg0: &mut 0x51704866f5f75cd753c22a07195f7c3438e69dbbb20d9c4f4d91a9f5aeefb8fe::suifren_dao::Dao<T0>, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::birth_location<T0>(arg1), 8);
        let v0 = SubDao<T0>{
            id             : 0x2::object::new(arg9),
            origin_dao     : 0x2::object::id<0x51704866f5f75cd753c22a07195f7c3438e69dbbb20d9c4f4d91a9f5aeefb8fe::suifren_dao::Dao<T0>>(arg0),
            birth_location : arg2,
            name           : arg3,
            description    : arg4,
            image          : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            quorum         : arg6,
            voting_delay   : arg7,
            voting_period  : arg8,
            treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            proposals      : 0x2::table::new<0x2::object::ID, Proposal>(arg9),
        };
        0x51704866f5f75cd753c22a07195f7c3438e69dbbb20d9c4f4d91a9f5aeefb8fe::suifren_dao::update_subdaos<T0>(arg0, 0x2::object::id<SubDao<T0>>(&v0));
        0x2::transfer::share_object<SubDao<T0>>(v0);
    }

    entry fun execute_proposal<T0: store + key>(arg0: &mut SubDao<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg1);
        assert!(v0.status == 0, 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.end_time, 3);
        let v1 = v0.results;
        let v2 = 1;
        let v3 = *0x2::vec_map::get<u64, u64>(&v1, &v2);
        let v4 = 2;
        let v5 = *0x2::vec_map::get<u64, u64>(&v1, &v4);
        let v6 = 0;
        let v7 = if (v3 + v5 + *0x2::vec_map::get<u64, u64>(&v1, &v6) < arg0.quorum) {
            2
        } else if (v3 > v5) {
            3
        } else {
            2
        };
        v0.status = v7;
        let v8 = ProposalEnded{
            id     : arg1,
            status : v0.status,
            name   : v0.name,
        };
        0x2::event::emit<ProposalEnded>(v8);
        if (v0.status == 3 && v0.type == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, *0x1::option::borrow<u64>(&v0.amount), arg3), *0x1::option::borrow<address>(&v0.recipient));
        };
    }

    entry fun vote<T0: store + key>(arg0: &mut SubDao<T0>, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.birth_location == 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::birth_location<T0>(arg1), 8);
        let v0 = 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg2);
        assert!(v1.status == 0, 7);
        assert!(0x2::clock::timestamp_ms(arg4) >= v1.start_time, 0);
        assert!(0x2::clock::timestamp_ms(arg4) <= v1.end_time, 1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&v1.nft_votes, v0), 4);
        assert!(arg3 == 1 || arg3 == 2 || arg3 == 0, 5);
        if (0x2::table::contains<address, u64>(&v1.address_vote_types, 0x2::tx_context::sender(arg5))) {
            assert!(*0x2::table::borrow<address, u64>(&v1.address_vote_types, 0x2::tx_context::sender(arg5)) == arg3, 5);
        };
        let v2 = Voted{
            dao_id      : 0x2::object::uid_to_inner(&arg0.id),
            proposal_id : arg2,
            voter       : 0x2::tx_context::sender(arg5),
            vote        : arg3,
        };
        0x2::event::emit<Voted>(v2);
        let v3 = 0x2::vec_map::get_mut<u64, u64>(&mut v1.results, &arg3);
        *v3 = *v3 + 1;
        0x2::table::add<0x2::object::ID, bool>(&mut v1.nft_votes, v0, true);
        if (0x2::table::contains<address, u64>(&v1.address_votes, 0x2::tx_context::sender(arg5))) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut v1.address_votes, 0x2::tx_context::sender(arg5));
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u64>(&mut v1.address_votes, 0x2::tx_context::sender(arg5), 1);
        };
        if (!0x2::table::contains<address, u64>(&v1.address_vote_types, 0x2::tx_context::sender(arg5))) {
            0x2::table::add<address, u64>(&mut v1.address_vote_types, 0x2::tx_context::sender(arg5), arg3);
        };
    }

    // decompiled from Move bytecode v6
}

