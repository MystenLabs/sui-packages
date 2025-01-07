module 0x5636f547da5dfafee476c654d557b6b5460a6b98337ec061abc20ef5107fb7f6::poetry_contest {
    struct Contest<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        submissiom_cost: u64,
        submission_start_time: u64,
        submissiom_end_time: u64,
        voting_start_time: u64,
        voting_end_time: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        manager: address,
    }

    struct Vote has store {
        poemId: address,
        owner_address: address,
        votes: u64,
    }

    public entry fun create_contest<T0: store + key>(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, Vote>>(&mut v0, 0x1::string::utf8(b"votes"), 0x2::table::new<address, Vote>(arg6));
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, address>>(&mut v0, 0x1::string::utf8(b"voted"), 0x2::table::new<address, address>(arg6));
        let v1 = Contest<T0>{
            id                    : v0,
            name                  : 0x1::string::utf8(arg0),
            submissiom_cost       : arg1,
            submission_start_time : arg2,
            submissiom_end_time   : arg3,
            voting_start_time     : arg4,
            voting_end_time       : arg5,
            funds                 : 0x2::balance::zero<0x2::sui::SUI>(),
            manager               : 0x2::tx_context::sender(arg6),
        };
        0x2::transfer::share_object<Contest<T0>>(v1);
    }

    public entry fun mutate_manager<T0: store + key>(arg0: address, arg1: &mut Contest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.manager == 0x2::tx_context::sender(arg2), 5);
        arg1.manager = arg0;
    }

    public entry fun submit_poem<T0: store + key>(arg0: &T0, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Contest<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.submissiom_cost == 0x2::coin::value<0x2::sui::SUI>(&arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg2.submission_start_time && v0 < arg2.submissiom_end_time, 1);
        let v1 = 0x2::object::id_address<T0>(arg0);
        let v2 = Vote{
            poemId        : v1,
            owner_address : 0x2::tx_context::sender(arg4),
            votes         : 0,
        };
        0x2::table::add<address, Vote>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, Vote>>(&mut arg2.id, 0x1::string::utf8(b"votes")), v1, v2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.funds, arg1);
    }

    public entry fun vote<T0: store + key, T1: store + key>(arg0: address, arg1: &T1, arg2: &mut Contest<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg2.voting_start_time && v0 < arg2.voting_end_time, 2);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::string::from_ascii(0x1::type_name::get_address(&v1)) == 0x1::string::utf8(b"0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1"), 3);
        let v2 = 0x2::table::borrow_mut<address, Vote>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, Vote>>(&mut arg2.id, 0x1::string::utf8(b"votes")), arg0);
        v2.votes = v2.votes + 1;
        0x2::table::add<address, address>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, address>>(&mut arg2.id, 0x1::string::utf8(b"voted")), 0x2::object::id_address<T1>(arg1), arg0);
    }

    public entry fun withdraw_proceeds<T0: store + key>(arg0: &mut Contest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.manager == 0x2::tx_context::sender(arg1), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg1), arg0.manager);
    }

    // decompiled from Move bytecode v6
}

