module 0x4ef629a3070fb1fa0655a59c0864576aa13c48f730df58da3b7c963a12134d24::suifren_dao {
    struct SUIFREN_DAO has drop {
        dummy_field: bool,
    }

    struct Dao<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x2::url::Url,
        quorum: u64,
        voting_delay: u64,
        voting_period: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        proposals: 0x2::object_table::ObjectTable<0x2::object::ID, Proposal>,
        subdaos: 0x2::table_vec::TableVec<0x2::object::ID>,
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

    entry fun cancel_proposal<T0>(arg0: &mut Dao<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 6);
        assert!(v0.status == 0, 7);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.start_time, 2);
        v0.status = 1;
    }

    entry fun create_dao<T0>(arg0: &0x4ef629a3070fb1fa0655a59c0864576aa13c48f730df58da3b7c963a12134d24::staking::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Dao<T0>{
            id            : 0x2::object::new(arg7),
            name          : arg1,
            description   : arg2,
            image         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg3)),
            quorum        : arg4,
            voting_delay  : arg5,
            voting_period : arg6,
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
            proposals     : 0x2::object_table::new<0x2::object::ID, Proposal>(arg7),
            subdaos       : 0x2::table_vec::empty<0x2::object::ID>(arg7),
        };
        0x2::transfer::share_object<Dao<T0>>(v0);
    }

    public fun create_proposal<T0>(arg0: &mut Dao<T0>, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 0 || arg4 == 1, 8);
        if (arg4 == 1) {
            assert!(0x1::option::is_some<address>(&arg5), 8);
            assert!(0x1::option::is_some<u64>(&arg6), 8);
        } else if (arg4 == 0) {
            assert!(0x1::option::is_none<address>(&arg5), 8);
            assert!(0x1::option::is_none<u64>(&arg6), 8);
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
        0x2::object_table::add<0x2::object::ID, Proposal>(&mut arg0.proposals, 0x2::object::id<Proposal>(&v1), v1);
    }

    entry fun deposit_to_treasury<T0>(arg0: &mut Dao<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    entry fun execute_proposal<T0>(arg0: &mut Dao<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg1);
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

    public(friend) fun update_subdaos<T0>(arg0: &mut Dao<T0>, arg1: 0x2::object::ID) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.subdaos, arg1);
    }

    entry fun vote<T0>(arg0: &mut Dao<T0>, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg1);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg2);
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

