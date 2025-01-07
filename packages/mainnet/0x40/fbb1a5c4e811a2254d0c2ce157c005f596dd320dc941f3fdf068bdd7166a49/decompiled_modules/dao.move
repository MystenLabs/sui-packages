module 0x40fbb1a5c4e811a2254d0c2ce157c005f596dd320dc941f3fdf068bdd7166a49::dao {
    struct DAORegistry has store, key {
        id: 0x2::object::UID,
        dao_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        sub_dao_ids: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct DAO has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        social_links: vector<vector<u8>>,
        quorum: u64,
        status: u8,
        open: bool,
        created_date: u64,
        dao_type: u8,
        members: vector<address>,
        proposals: vector<0x2::object::ID>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        contributor_funds: 0x2::vec_map::VecMap<address, u64>,
        parent_dao: 0x1::option::Option<0x2::object::ID>,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        proposal_type: u8,
        status: u8,
        recipients: vector<address>,
        amounts: vector<u64>,
        start_date: u64,
        end_date: u64,
        created_date: u64,
        disbursement_dates: vector<u64>,
        disbursement_amounts: vector<u64>,
        disbursed_number: u64,
        allow_early_execute: bool,
        votes: 0x2::vec_map::VecMap<address, bool>,
        executed: bool,
    }

    public entry fun add_member(arg0: &mut DAO, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&arg0.owner == &v0, 5);
        let (v1, _) = 0x1::vector::index_of<address>(&arg0.members, &arg1);
        assert!(!v1, 3);
        0x1::vector::push_back<address>(&mut arg0.members, arg1);
    }

    public fun count_dao_members(arg0: &DAO) : u64 {
        0x1::vector::length<address>(&arg0.members)
    }

    public entry fun create_dao(arg0: &mut DAORegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: u64, arg5: bool, arg6: u64, arg7: u8, arg8: vector<address>, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = DAO{
            id                : 0x2::object::new(arg10),
            owner             : 0x2::tx_context::sender(arg10),
            title             : 0x1::string::utf8(arg1),
            description       : 0x1::string::utf8(arg2),
            social_links      : arg3,
            quorum            : arg4,
            status            : 1,
            open              : arg5,
            created_date      : arg6,
            dao_type          : arg7,
            members           : arg8,
            proposals         : 0x1::vector::empty<0x2::object::ID>(),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            contributor_funds : 0x2::vec_map::empty<address, u64>(),
            parent_dao        : arg9,
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg9)) {
            if (!0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.sub_dao_ids, 0x1::option::borrow<0x2::object::ID>(&arg9))) {
                0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.sub_dao_ids, *0x1::option::borrow<0x2::object::ID>(&arg9), 0x2::vec_set::empty<0x2::object::ID>());
            };
            0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.sub_dao_ids, 0x1::option::borrow<0x2::object::ID>(&arg9)), 0x2::object::id<DAO>(&v0));
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.dao_ids, 0x2::object::id<DAO>(&v0));
        0x2::transfer::share_object<DAO>(v0);
    }

    public entry fun create_proposal(arg0: &mut DAO, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: vector<address>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = Proposal{
            id                   : 0x2::object::new(arg12),
            owner                : 0x2::tx_context::sender(arg12),
            title                : 0x1::string::utf8(arg1),
            description          : 0x1::string::utf8(arg2),
            proposal_type        : arg3,
            status               : 1,
            recipients           : arg4,
            amounts              : arg5,
            start_date           : arg6,
            end_date             : arg7,
            created_date         : arg8,
            disbursement_dates   : arg9,
            disbursement_amounts : arg10,
            disbursed_number     : 0,
            allow_early_execute  : arg11,
            votes                : 0x2::vec_map::empty<address, bool>(),
            executed             : false,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.proposals, 0x2::object::id<Proposal>(&v0));
        0x2::transfer::share_object<Proposal>(v0);
    }

    public entry fun execute_proposal(arg0: &mut DAO, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 13);
        assert!(arg1.status == 1, 12);
        assert!(arg1.executed == false, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, _) = 0x1::vector::index_of<address>(&arg0.members, &v0);
        assert!(v1, 0);
        let v3 = arg1.proposal_type;
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.proposals, 0x2::object::borrow_id<Proposal>(arg1)), 6);
        let (v4, v5) = 0x2::vec_map::into_keys_values<address, bool>(arg1.votes);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        let v9 = 0;
        let v10 = false;
        while (v9 < 0x1::vector::length<address>(&v7)) {
            if (*0x1::vector::borrow<bool>(&v6, v9)) {
                v8 = v8 + 1;
            };
            v9 = v9 + 1;
        };
        if (0x2::math::divide_and_round_up(v8 * 10000, count_dao_members(arg0)) >= arg0.quorum * 100) {
            v10 = true;
        };
        assert!(v10, 7);
        let v11 = 0x2::clock::timestamp_ms(arg2);
        if (!arg1.allow_early_execute) {
            assert!(arg1.end_date <= v11, 8);
        };
        assert!(0x1::vector::length<address>(&arg1.recipients) > 0, 14);
        if (v3 == 1) {
            let v12 = 0;
            while (v12 < 0x1::vector::length<address>(&arg1.recipients)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, *0x1::vector::borrow<u64>(&arg1.amounts, v12), arg3), *0x1::vector::borrow<address>(&arg1.recipients, v12));
                v12 = v12 + 1;
            };
            arg1.executed = true;
        } else if (v3 == 2) {
            let v13 = arg1.disbursed_number;
            let v14 = 0x1::vector::length<u64>(&arg1.disbursement_amounts);
            assert!(v13 < v14, 15);
            assert!(v11 >= *0x1::vector::borrow<u64>(&arg1.disbursement_dates, v13), 16);
            let v15 = v13 + 1;
            arg1.disbursed_number = v15;
            if (v15 == v14) {
                arg1.executed = true;
                arg1.status = 3;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, *0x1::vector::borrow<u64>(&arg1.disbursement_amounts, v13), arg3), *0x1::vector::borrow<address>(&arg1.recipients, 0));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DAORegistry{
            id          : 0x2::object::new(arg0),
            dao_ids     : 0x2::vec_set::empty<0x2::object::ID>(),
            sub_dao_ids : 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<DAORegistry>(v0);
    }

    public entry fun join(arg0: &mut DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.open, 2);
        assert!(!0x1::vector::contains<address>(&arg0.members, &v0), 3);
        0x1::vector::push_back<address>(&mut arg0.members, v0);
    }

    public entry fun leave(arg0: &mut DAO, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.members, &v0);
        assert!(v1, 4);
        0x1::vector::remove<address>(&mut arg0.members, v2);
    }

    public entry fun remove_member(arg0: &mut DAO, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&arg0.owner == &v0, 5);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.members, &arg1);
        assert!(v1, 4);
        0x1::vector::remove<address>(&mut arg0.members, v2);
    }

    public entry fun send_fund(arg0: &mut DAO, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::vec_map::contains<address, u64>(&arg0.contributor_funds, &v0)) {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.contributor_funds, &v0);
            *v1 = *v1 + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.contributor_funds, v0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun vote(arg0: &DAO, arg1: &mut Proposal, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 13);
        assert!(arg1.status == 1, 12);
        assert!(arg1.executed == false, 11);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.start_date, 9);
        assert!(v0 <= arg1.end_date, 10);
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, _) = 0x1::vector::index_of<address>(&arg0.members, &v1);
        assert!(v2, 0);
        let v4 = 0x2::object::id<Proposal>(arg1);
        let (v5, _) = 0x1::vector::index_of<0x2::object::ID>(&arg0.proposals, &v4);
        assert!(v5, 1);
        if (0x2::vec_map::contains<address, bool>(&arg1.votes, &v1)) {
            *0x2::vec_map::get_mut<address, bool>(&mut arg1.votes, &v1) = arg2;
        } else {
            0x2::vec_map::insert<address, bool>(&mut arg1.votes, v1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

