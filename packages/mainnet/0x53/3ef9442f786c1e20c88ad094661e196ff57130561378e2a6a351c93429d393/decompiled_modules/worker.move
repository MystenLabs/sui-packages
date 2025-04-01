module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker {
    struct Worker has store, key {
        id: 0x2::object::UID,
        owner: address,
        content: 0x1::string::String,
        user_id: 0x1::string::String,
        mac_address: 0x1::string::String,
        status: u64,
        created_at: u64,
    }

    public fun delete(arg0: Worker) {
        let Worker {
            id          : v0,
            owner       : _,
            content     : _,
            user_id     : _,
            mac_address : _,
            status      : _,
            created_at  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Worker {
        let v0 = 0x1::string::length(&arg1);
        assert!(v0 > 1 && v0 <= 1000, 1);
        Worker{
            id          : 0x2::object::new(arg4),
            owner       : arg0,
            content     : arg1,
            user_id     : arg2,
            mac_address : arg3,
            status      : 0,
            created_at  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        }
    }

    public fun get_content(arg0: &Worker) : 0x1::string::String {
        arg0.content
    }

    public fun get_created_at(arg0: &Worker) : u64 {
        arg0.created_at
    }

    public fun get_id(arg0: &Worker) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_mac_address(arg0: &Worker) : 0x1::string::String {
        arg0.mac_address
    }

    public fun get_status(arg0: &Worker) : u64 {
        arg0.status
    }

    public fun get_user_id(arg0: &Worker) : 0x1::string::String {
        arg0.user_id
    }

    public fun update(arg0: &mut Worker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) {
        arg0.user_id = arg1;
        arg0.content = arg2;
        arg0.mac_address = arg3;
        arg0.status = arg4;
    }

    public fun update_status(arg0: &mut Worker, arg1: u64) {
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

