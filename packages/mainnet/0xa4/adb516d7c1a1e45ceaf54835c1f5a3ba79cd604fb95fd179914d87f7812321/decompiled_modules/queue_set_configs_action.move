module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue_set_configs_action {
    struct QueueConfigsUpdated has copy, drop {
        queue_id: 0x2::object::ID,
        name: 0x1::string::String,
        fee: u64,
        fee_recipient: address,
        min_attestations: u64,
        oracle_validity_length_ms: u64,
    }

    fun actuate(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::set_configs(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = QueueConfigsUpdated{
            queue_id                  : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::id(arg0),
            name                      : arg1,
            fee                       : arg2,
            fee_recipient             : arg3,
            min_attestations          : arg4,
            oracle_validity_length_ms : arg5,
        };
        0x2::event::emit<QueueConfigsUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg4, arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun validate(arg0: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::has_authority(arg0, arg3), 9223372161408827393);
        assert!(arg1 > 0, 9223372165704056837);
        assert!(arg2 > 0, 9223372169998893059);
    }

    // decompiled from Move bytecode v6
}

