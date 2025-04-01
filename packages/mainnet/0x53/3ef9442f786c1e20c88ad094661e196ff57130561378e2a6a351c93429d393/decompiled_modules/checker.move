module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker {
    struct Checker has store, key {
        id: 0x2::object::UID,
        owner: address,
        content: 0x1::string::String,
        device_id: 0x1::string::String,
        user_id: u64,
        status: u64,
        created_at: u64,
    }

    public fun delete(arg0: Checker) {
        let Checker {
            id         : v0,
            owner      : _,
            content    : _,
            device_id  : _,
            user_id    : _,
            status     : _,
            created_at : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Checker {
        let v0 = 0x1::string::length(&arg1);
        assert!(v0 > 1 && v0 <= 1000, 1);
        Checker{
            id         : 0x2::object::new(arg4),
            owner      : arg0,
            content    : arg1,
            device_id  : arg2,
            user_id    : arg3,
            status     : 0,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg4),
        }
    }

    public fun get_content(arg0: &Checker) : 0x1::string::String {
        arg0.content
    }

    public fun get_created_at(arg0: &Checker) : u64 {
        arg0.created_at
    }

    public fun get_device_id(arg0: &Checker) : 0x1::string::String {
        arg0.device_id
    }

    public fun get_id(arg0: &Checker) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_status(arg0: &Checker) : u64 {
        arg0.status
    }

    public fun get_user_id(arg0: &Checker) : u64 {
        arg0.user_id
    }

    public fun update(arg0: &mut Checker, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) {
        arg0.user_id = arg1;
        arg0.content = arg2;
        arg0.device_id = arg3;
        arg0.status = arg4;
    }

    public fun update_status(arg0: &mut Checker, arg1: u64) {
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

