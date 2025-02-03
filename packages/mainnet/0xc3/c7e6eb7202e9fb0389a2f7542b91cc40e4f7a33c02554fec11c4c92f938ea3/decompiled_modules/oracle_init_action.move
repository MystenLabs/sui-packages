module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle_init_action {
    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        queue_id: 0x2::object::ID,
        oracle_key: vector<u8>,
    }

    fun actuate(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::new(arg1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg0), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::queue_key(arg0), arg2);
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::add_existing_oracle(arg0, arg1, v0);
        let v1 = OracleCreated{
            oracle_id  : v0,
            queue_id   : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg0),
            oracle_key : arg1,
        };
        0x2::event::emit<OracleCreated>(v1);
    }

    public entry fun run(arg0: vector<u8>, arg1: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg2: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg1, arg0, arg2);
    }

    public fun validate(arg0: &vector<u8>, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::version(arg1) == 1, 9223372139934187524);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::existing_oracles_contains(arg1, *arg0), 9223372144229023746);
    }

    // decompiled from Move bytecode v6
}

