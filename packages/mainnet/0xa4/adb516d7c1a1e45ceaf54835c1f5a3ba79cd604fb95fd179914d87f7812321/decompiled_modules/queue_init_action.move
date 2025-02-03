module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue_init_action {
    struct QueueCreated has copy, drop {
        queue_id: 0x2::object::ID,
        guardian_queue_id: 0x2::object::ID,
        queue_key: vector<u8>,
    }

    fun actuate(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = QueueCreated{
            queue_id          : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, arg8),
            guardian_queue_id : arg7,
            queue_key         : arg0,
        };
        0x2::event::emit<QueueCreated>(v0);
    }

    public entry fun run(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg8: &mut 0x2::tx_context::TxContext) {
        validate(arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::id(arg7), arg8);
    }

    public fun validate(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 9223372131344187395);
        assert!(arg1 > 0, 9223372135639023617);
    }

    // decompiled from Move bytecode v6
}

