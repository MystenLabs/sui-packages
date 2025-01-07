module 0xaa300740dd76aded7518fdf94ad9f390f60072f1aeb04ab94820792adc6ee60e::betting {
    struct InitializationCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameData has store, key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        all_queries: 0x2::object_table::ObjectTable<0x2::object::ID, Query>,
        query_count: u64,
        num_to_query: 0x2::table::Table<u64, 0x2::object::ID>,
        available_nums: 0x2::table_vec::TableVec<u64>,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        creator_address: address,
        consenting_address: address,
        question: 0x1::string::String,
        for_amount: u64,
        bet_id: 0x2::object::ID,
        against_amount: u64,
        agreed_by_both: bool,
        game_start_time: u64,
        game_end_time: u64,
        status: u8,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        create_time: u64,
        sent_to_oracle: bool,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        proposer: address,
        oracle_id: 0x2::object::ID,
        question: 0x1::string::String,
        response: bool,
        query_id: 0x2::object::ID,
    }

    struct Query has store, key {
        id: 0x2::object::UID,
        bet_id: 0x2::object::ID,
        question: 0x1::string::String,
        creator_address: address,
        consenting_address: address,
        validators: 0x2::vec_map::VecMap<address, Proposal>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        index: u64,
    }

    struct BetCreated has copy, drop {
        bet_id: 0x2::object::ID,
        creator: address,
        question: 0x1::string::String,
        for_amount: u64,
        against_amount: u64,
        agreed_by_both: bool,
        game_start_time: u64,
        game_end_time: u64,
        status: u8,
    }

    struct BetDeleted has copy, drop {
        bet_id: 0x2::object::ID,
        deleter: address,
    }

    struct BetAccepted has copy, drop {
        bet_id: 0x2::object::ID,
        acceptor: address,
    }

    struct BetPaidOut has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        winner: address,
    }

    struct BetSentToOracle has copy, drop {
        bet_id: 0x2::object::ID,
    }

    struct BetExpired has copy, drop {
        bet_id: 0x2::object::ID,
    }

    public fun active(arg0: &Bet) : bool {
        arg0.status == 1
    }

    public fun against_amount(arg0: &Bet) : u64 {
        arg0.against_amount
    }

    public fun agree_to_bet(arg0: &mut Bet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator_address != 0x2::tx_context::sender(arg3), 16);
        assert!(!arg0.agreed_by_both, 17);
        assert!(arg0.status == 1, 18);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.game_end_time, 18);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.against_amount, 21);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.agreed_by_both = true;
        arg0.consenting_address = 0x2::tx_context::sender(arg3);
        let v0 = BetAccepted{
            bet_id   : arg0.bet_id,
            acceptor : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BetAccepted>(v0);
    }

    public fun agreed(arg0: &Bet) : bool {
        arg0.agreed_by_both
    }

    public fun consentor(arg0: &Bet) : address {
        arg0.consenting_address
    }

    public fun create_bet(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg1, 21);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 > v1, 23);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Bet{
            id                 : v2,
            creator_address    : v0,
            consenting_address : @0x0,
            question           : arg0,
            for_amount         : arg1,
            bet_id             : v3,
            against_amount     : arg2,
            agreed_by_both     : false,
            game_start_time    : v1,
            game_end_time      : arg3,
            status             : 1,
            stake              : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            create_time        : v1,
            sent_to_oracle     : false,
        };
        0x2::transfer::share_object<Bet>(v4);
        let v5 = BetCreated{
            bet_id          : v3,
            creator         : v0,
            question        : arg0,
            for_amount      : arg1,
            against_amount  : arg2,
            agreed_by_both  : false,
            game_start_time : v1,
            game_end_time   : arg3,
            status          : 1,
        };
        0x2::event::emit<BetCreated>(v5);
        v3
    }

    public fun creator(arg0: &Bet) : address {
        arg0.creator_address
    }

    public fun delete_bet(arg0: Bet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator_address == 0x2::tx_context::sender(arg1), 16);
        assert!(!arg0.agreed_by_both, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, arg0.for_amount, arg1), arg0.creator_address);
        arg0.status = 2;
        let Bet {
            id                 : v0,
            creator_address    : _,
            consenting_address : _,
            question           : _,
            for_amount         : _,
            bet_id             : _,
            against_amount     : _,
            agreed_by_both     : _,
            game_start_time    : _,
            game_end_time      : _,
            status             : _,
            stake              : v11,
            create_time        : _,
            sent_to_oracle     : _,
        } = arg0;
        let v14 = v0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        let v15 = BetDeleted{
            bet_id  : 0x2::object::uid_to_inner(&v14),
            deleter : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BetDeleted>(v15);
        0x2::object::delete(v14);
    }

    public fun for_amount(arg0: &Bet) : u64 {
        arg0.for_amount
    }

    public fun handle_expired_bet(arg0: Bet, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 18);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.game_end_time && !arg0.agreed_by_both, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, arg0.for_amount, arg2), arg0.creator_address);
        arg0.status = 4;
        let Bet {
            id                 : v0,
            creator_address    : _,
            consenting_address : _,
            question           : _,
            for_amount         : _,
            bet_id             : _,
            against_amount     : _,
            agreed_by_both     : _,
            game_start_time    : _,
            game_end_time      : _,
            status             : _,
            stake              : v11,
            create_time        : _,
            sent_to_oracle     : _,
        } = arg0;
        let v14 = v0;
        let v15 = BetExpired{bet_id: 0x2::object::uid_to_inner(&v14)};
        0x2::event::emit<BetExpired>(v15);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        0x2::object::delete(v14);
    }

    public fun id(arg0: &Proposal) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitializationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitializationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_contract(arg0: InitializationCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            funds          : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            all_queries    : 0x2::object_table::new<0x2::object::ID, Query>(arg2),
            query_count    : 0,
            num_to_query   : 0x2::table::new<u64, 0x2::object::ID>(arg2),
            available_nums : 0x2::table_vec::empty<u64>(arg2),
        };
        let InitializationCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<GameData>(v0);
    }

    public fun oracle_id(arg0: &Proposal) : 0x2::object::ID {
        arg0.oracle_id
    }

    public fun p_question(arg0: &Proposal) : 0x1::string::String {
        arg0.question
    }

    fun process_oracle_answer(arg0: &mut Bet, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1) {
            arg0.creator_address
        } else {
            arg0.consenting_address
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, arg0.for_amount + arg0.against_amount, arg2), v0);
        arg0.status = 3;
        let v1 = BetPaidOut{
            bet_id : arg0.bet_id,
            amount : arg0.for_amount + arg0.against_amount,
            winner : v0,
        };
        0x2::event::emit<BetPaidOut>(v1);
    }

    public fun proposer(arg0: &Proposal) : address {
        arg0.proposer
    }

    public fun query_id(arg0: &Proposal) : 0x2::object::ID {
        arg0.query_id
    }

    public fun question(arg0: &Bet) : 0x1::string::String {
        arg0.question
    }

    fun receive_query(arg0: &mut GameData, arg1: &Bet, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Query{
            id                 : 0x2::object::new(arg2),
            bet_id             : arg1.bet_id,
            question           : arg1.question,
            creator_address    : arg1.creator_address,
            consenting_address : arg1.consenting_address,
            validators         : 0x2::vec_map::empty<address, Proposal>(),
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            index              : 0,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = if (0x2::table_vec::length<u64>(&arg0.available_nums) == 0) {
            arg0.query_count = arg0.query_count + 1;
            0x2::table::add<u64, 0x2::object::ID>(&mut arg0.num_to_query, arg0.query_count, v1);
            arg0.query_count
        } else {
            let v3 = 0x2::table_vec::pop_back<u64>(&mut arg0.available_nums);
            0x2::table::add<u64, 0x2::object::ID>(&mut arg0.num_to_query, v3, v1);
            v3
        };
        v0.index = v2;
        0x2::object_table::add<0x2::object::ID, Query>(&mut arg0.all_queries, v1, v0);
    }

    public fun receive_validate(arg0: &mut GameData, arg1: &mut Bet, arg2: Proposal, arg3: bool, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.status == 1, 18);
        assert!(arg1.agreed_by_both, 19);
        assert!(0x2::object_table::contains<0x2::object::ID, Query>(&arg0.all_queries, arg2.query_id), 20);
        assert!(arg2.oracle_id == arg1.bet_id, 22);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Query>(&mut arg0.all_queries, arg2.query_id);
        assert!(!0x2::vec_map::contains<address, Proposal>(&v1.validators, &v0), 14);
        arg2.response = arg3;
        0x2::vec_map::insert<address, Proposal>(&mut v1.validators, v0, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 1000000, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        if (0x2::vec_map::size<address, Proposal>(&v1.validators) == 3) {
            let v2 = 0;
            let Query {
                id                 : v3,
                bet_id             : _,
                question           : _,
                creator_address    : _,
                consenting_address : _,
                validators         : v8,
                balance            : v9,
                index              : v10,
            } = 0x2::object_table::remove<0x2::object::ID, Query>(&mut arg0.all_queries, arg2.query_id);
            let v11 = v9;
            let (_, v13) = 0x2::vec_map::into_keys_values<address, Proposal>(v8);
            let v14 = v13;
            let v15 = 0;
            while (v15 < 3) {
                if (0x1::vector::borrow<Proposal>(&v14, v15).response) {
                    v2 = v2 + 1;
                };
                v15 = v15 + 1;
            };
            let v16 = 3 / 2;
            let v17 = if (v2 > v16) {
                3 - v2
            } else {
                v2
            };
            v15 = 0;
            while (v15 < 3) {
                let v18 = 0x1::vector::remove<Proposal>(&mut v14, 0);
                if (v18.response && v2 > v16 || !v18.response && v2 <= v16) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v11, 1000000 + v17 * 1000000 / (3 - v17), arg5), v18.proposer);
                };
                v15 = v15 + 1;
                let Proposal {
                    id        : v19,
                    proposer  : _,
                    oracle_id : _,
                    question  : _,
                    response  : _,
                    query_id  : _,
                } = v18;
                0x2::object::delete(v19);
            };
            if (v2 > v16) {
                process_oracle_answer(arg1, true, arg5);
            } else {
                process_oracle_answer(arg1, false, arg5);
            };
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
            0x2::table::remove<u64, 0x2::object::ID>(&mut arg0.num_to_query, v10);
            0x2::table_vec::push_back<u64>(&mut arg0.available_nums, v10);
            0x2::object::delete(v3);
            0x1::vector::destroy_empty<Proposal>(v14);
        };
    }

    entry fun request_validate(arg0: &GameData, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let v0 = 1;
        let v1 = 0;
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(arg0.query_count != 0, 11);
        let v3 = 0x2::random::new_generator(arg1, arg2);
        while (v1 < 5) {
            let v4 = 0x2::random::generate_u64_in_range(&mut v3, 1, arg0.query_count);
            v0 = v4;
            if (!0x2::table::contains<u64, 0x2::object::ID>(&arg0.num_to_query, v4)) {
                v1 = v1 + 1;
                continue
            };
            let v5 = 0x2::object_table::borrow<0x2::object::ID, Query>(&arg0.all_queries, *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.num_to_query, v4));
            if (0x2::vec_map::contains<address, Proposal>(&v5.validators, &v2) || v5.consenting_address == v2 || v5.creator_address == v2) {
                v1 = v1 + 1;
            } else {
                break
            };
        };
        assert!(v1 < 5, 11);
        assert!(v0 <= arg0.query_count, 11);
        let v6 = 0x2::table::borrow<u64, 0x2::object::ID>(&arg0.num_to_query, v0);
        let v7 = 0x2::object_table::borrow<0x2::object::ID, Query>(&arg0.all_queries, *v6);
        let v8 = Proposal{
            id        : 0x2::object::new(arg2),
            proposer  : v2,
            oracle_id : v7.bet_id,
            question  : v7.question,
            response  : false,
            query_id  : *v6,
        };
        0x2::transfer::public_transfer<Proposal>(v8, v2);
        (0x2::object::uid_to_inner(&v8.id), v8.oracle_id)
    }

    public fun response(arg0: &Proposal) : bool {
        arg0.response
    }

    public fun send_bet_to_oracle(arg0: &mut GameData, arg1: &mut Bet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 18);
        assert!(arg1.agreed_by_both, 19);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.game_end_time, 19);
        arg1.sent_to_oracle = true;
        receive_query(arg0, arg1, arg3);
        let v0 = BetSentToOracle{bet_id: arg1.bet_id};
        0x2::event::emit<BetSentToOracle>(v0);
    }

    public fun withdraw(arg0: &mut GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

