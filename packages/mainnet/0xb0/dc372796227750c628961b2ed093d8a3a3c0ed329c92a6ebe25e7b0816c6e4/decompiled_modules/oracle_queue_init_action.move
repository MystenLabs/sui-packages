module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::oracle_queue_init_action {
    struct OracleQueueCreated has copy, drop {
        queue_id: 0x2::object::ID,
        guardian_queue_id: 0x2::object::ID,
        queue_key: vector<u8>,
    }

    fun actuate(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleQueueCreated{
            queue_id          : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, arg8),
            guardian_queue_id : arg7,
            queue_key         : arg0,
        };
        0x2::event::emit<OracleQueueCreated>(v0);
    }

    public entry fun run(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::Queue, arg8: &mut 0x2::tx_context::TxContext) {
        validate(arg7, arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::id(arg7), arg8);
    }

    public fun validate(arg0: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::Queue, arg1: u64, arg2: u64) {
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::version(arg0) == 1, 9223372152819220486);
        assert!(arg1 > 0, 9223372157114056708);
        assert!(arg2 > 0, 9223372161408892930);
    }

    // decompiled from Move bytecode v6
}

