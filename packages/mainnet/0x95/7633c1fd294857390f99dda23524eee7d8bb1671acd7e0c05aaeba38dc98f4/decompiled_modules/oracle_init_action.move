module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::oracle_init_action {
    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        queue_id: 0x2::object::ID,
        oracle_key: vector<u8>,
    }

    fun actuate(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::oracle::new(arg1, 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::id(arg0), 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::queue_key(arg0), arg2);
        0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::add_existing_oracle(arg0, arg1, v0);
        let v1 = OracleCreated{
            oracle_id  : v0,
            queue_id   : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::id(arg0),
            oracle_key : arg1,
        };
        0x2::event::emit<OracleCreated>(v1);
    }

    public entry fun run(arg0: vector<u8>, arg1: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg2: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg1, arg0, arg2);
    }

    public fun validate(arg0: &vector<u8>, arg1: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue) {
        assert!(!0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::existing_oracles_contains(arg1, arg0), 9223372122754121729);
    }

    // decompiled from Move bytecode v6
}

