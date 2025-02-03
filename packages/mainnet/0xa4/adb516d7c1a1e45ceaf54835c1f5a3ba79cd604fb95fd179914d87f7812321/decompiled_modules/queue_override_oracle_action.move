module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue_override_oracle_action {
    struct QueueOracleOverride has copy, drop {
        queue_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        secp256k1_key: vector<u8>,
        mr_enclave: vector<u8>,
        expiration_time_ms: u64,
    }

    fun actuate(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg1: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::enable_oracle(arg0, arg2, arg3, arg4);
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::set_last_queue_override_ms(arg1, 0x2::clock::timestamp_ms(arg5));
        let v0 = QueueOracleOverride{
            queue_id           : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::id(arg1),
            oracle_id          : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg0),
            secp256k1_key      : arg2,
            mr_enclave         : arg3,
            expiration_time_ms : arg4,
        };
        0x2::event::emit<QueueOracleOverride>(v0);
    }

    public entry fun run(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1, arg4, arg6);
        actuate(arg1, arg0, arg2, arg3, arg4, arg5);
    }

    public fun validate(arg0: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::queue_key(arg0) == 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue_key(arg1), 9223372169999155207);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::id(arg0) == 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue(arg1), 9223372174293991429);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::has_authority(arg0, arg3), 9223372178588696577);
        assert!(arg2 > 0, 9223372182883794947);
    }

    // decompiled from Move bytecode v6
}

