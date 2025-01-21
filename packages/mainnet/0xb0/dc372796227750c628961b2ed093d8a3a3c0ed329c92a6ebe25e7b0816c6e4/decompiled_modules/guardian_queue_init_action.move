module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::guardian_queue_init_action {
    struct GuardianQueueCreated has copy, drop {
        queue_id: 0x2::object::ID,
        queue_key: vector<u8>,
    }

    fun actuate(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = GuardianQueueCreated{
            queue_id  : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::queue::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::object::id_from_address(@0x0), true, arg7),
            queue_key : arg0,
        };
        0x2::event::emit<GuardianQueueCreated>(v0);
    }

    public entry fun run(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        validate(arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun validate(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 9223372127049220099);
        assert!(arg1 > 0, 9223372131344056321);
    }

    // decompiled from Move bytecode v6
}

