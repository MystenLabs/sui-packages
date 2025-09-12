module 0x3d90e4257912d39604aca5ba0fc261ad62667338cc6936b375dac179ecf48bf::governance {
    struct Dao has key {
        id: 0x2::object::UID,
        next_id: u64,
        min_quorum: u64,
        proposal_threshold: u64,
    }

    struct Proposal<phantom T0> has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        start_ms: u64,
        end_ms: u64,
        for_votes: u64,
        against_votes: u64,
        has_voted: 0x2::table::Table<address, bool>,
        vaults: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
        min_quorum: u64,
    }

    public fun claim_refund<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_ms, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::coin::Coin<T0>>(&arg0.vaults, v0), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v0), v0);
    }

    public entry fun claim_refund_entry<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_refund<T0>(arg0, arg1, arg2);
    }

    public fun create_proposal<T0>(arg0: &mut Dao, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < arg4, 1);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= arg0.proposal_threshold, 2);
        let v1 = Proposal<T0>{
            id            : 0x2::object::new(arg8),
            proposal_id   : arg0.next_id,
            title         : arg1,
            description   : arg2,
            start_ms      : arg3,
            end_ms        : arg4,
            for_votes     : 0,
            against_votes : 0,
            has_voted     : 0x2::table::new<address, bool>(arg8),
            vaults        : 0x2::table::new<address, 0x2::coin::Coin<T0>>(arg8),
            min_quorum    : arg0.min_quorum,
        };
        let v2 = 0x2::tx_context::sender(arg8);
        if (arg6) {
            assert!(!0x2::table::contains<address, bool>(&v1.has_voted, v2), 5);
            v1.for_votes = v1.for_votes + v0;
            0x2::table::add<address, bool>(&mut v1.has_voted, v2, true);
        };
        0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut v1.vaults, v2, arg5);
        0x2::transfer::share_object<Proposal<T0>>(v1);
        arg0.next_id = arg0.next_id + 1;
    }

    public entry fun create_proposal_entry<T0>(arg0: &mut Dao, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_proposal<T0>(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun init_dao(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Dao{
            id                 : 0x2::object::new(arg2),
            next_id            : 0,
            min_quorum         : arg0,
            proposal_threshold : arg1,
        };
        0x2::transfer::share_object<Dao>(v0);
    }

    public fun passed<T0>(arg0: &Proposal<T0>) : bool {
        arg0.for_votes + arg0.against_votes >= arg0.min_quorum && arg0.for_votes > arg0.against_votes
    }

    public fun tallies<T0>(arg0: &Proposal<T0>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.proposal_id, arg0.for_votes, arg0.against_votes, arg0.start_ms, arg0.end_ms, arg0.min_quorum)
    }

    public fun vote_against<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_ms, 3);
        assert!(v0 <= arg0.end_ms, 4);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_voted, v1), 5);
        arg0.against_votes = arg0.against_votes + 0x2::coin::value<T0>(&arg2);
        0x2::table::add<address, bool>(&mut arg0.has_voted, v1, true);
        if (0x2::table::contains<address, 0x2::coin::Coin<T0>>(&arg0.vaults, v1)) {
            0x2::coin::join<T0>(&mut arg2, 0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v1));
        };
        0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v1, arg2);
    }

    public entry fun vote_against_entry<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        vote_against<T0>(arg0, arg1, arg2, arg3);
    }

    public fun vote_for<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_ms, 3);
        assert!(v0 <= arg0.end_ms, 4);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_voted, v1), 5);
        arg0.for_votes = arg0.for_votes + 0x2::coin::value<T0>(&arg2);
        0x2::table::add<address, bool>(&mut arg0.has_voted, v1, true);
        if (0x2::table::contains<address, 0x2::coin::Coin<T0>>(&arg0.vaults, v1)) {
            0x2::coin::join<T0>(&mut arg2, 0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v1));
        };
        0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v1, arg2);
    }

    public entry fun vote_for_entry<T0>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        vote_for<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

