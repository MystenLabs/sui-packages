module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::oracle_init_action {
    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        queue_id: 0x2::object::ID,
        oracle_key: vector<u8>,
    }

    fun actuate(arg0: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::Queue, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::oracle::new(arg1, 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::id(arg0), 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::queue_key(arg0), arg2);
        0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::add_existing_oracle(arg0, arg1, v0);
        let v1 = OracleCreated{
            oracle_id  : v0,
            queue_id   : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::id(arg0),
            oracle_key : arg1,
        };
        0x2::event::emit<OracleCreated>(v1);
    }

    public entry fun run(arg0: vector<u8>, arg1: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::Queue, arg2: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg1, arg0, arg2);
    }

    public fun validate(arg0: &vector<u8>, arg1: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::Queue) {
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::version(arg1) == 1, 9223372139934187524);
        assert!(!0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::existing_oracles_contains(arg1, *arg0), 9223372144229023746);
    }

    // decompiled from Move bytecode v6
}

