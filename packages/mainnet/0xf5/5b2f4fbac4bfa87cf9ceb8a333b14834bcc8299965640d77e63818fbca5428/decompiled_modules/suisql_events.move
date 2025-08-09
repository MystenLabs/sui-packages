module 0x650ff3788c4dbc7dcb3f909fd01642fd8a772dc7e003e575c9d502d51b07cabe::suisql_events {
    struct NewBankEvent has copy, drop {
        id: address,
    }

    struct NewDBEvent has copy, drop {
        id: address,
        name: 0x1::ascii::String,
        write_cap_id: address,
    }

    struct RemindDBEvent has copy, drop {
        id: address,
        name: 0x1::ascii::String,
    }

    public(friend) fun emit_new_bank_event(arg0: &0x2::object::ID) {
        let v0 = NewBankEvent{id: 0x2::object::id_to_address(arg0)};
        0x2::event::emit<NewBankEvent>(v0);
    }

    public(friend) fun emit_new_db_event(arg0: &0x2::object::ID, arg1: 0x1::ascii::String, arg2: &0x2::object::ID) {
        let v0 = NewDBEvent{
            id           : 0x2::object::id_to_address(arg0),
            name         : arg1,
            write_cap_id : 0x2::object::id_to_address(arg2),
        };
        0x2::event::emit<NewDBEvent>(v0);
    }

    public(friend) fun emit_remind_db_event(arg0: address, arg1: 0x1::ascii::String) {
        let v0 = RemindDBEvent{
            id   : arg0,
            name : arg1,
        };
        0x2::event::emit<RemindDBEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

