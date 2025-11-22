module 0x4d7ab888bdb2c7e5d0ecab64cc36371ad8444d5d66e6d271ca8624bfd8954d67::volo_adapter_event {
    struct NewVoloPassEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct StakeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
    }

    public fun new_volo_pass_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewVoloPassEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewVoloPassEvent>(v0);
    }

    public fun stake_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StakeEvent{
            vault_id      : arg0,
            input_amount  : arg1,
            output_amount : arg2,
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

