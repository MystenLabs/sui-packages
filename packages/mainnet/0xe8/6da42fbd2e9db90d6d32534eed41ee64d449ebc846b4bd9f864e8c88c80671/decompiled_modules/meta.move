module 0xe86da42fbd2e9db90d6d32534eed41ee64d449ebc846b4bd9f864e8c88c80671::meta {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Meta has store, key {
        id: 0x2::object::UID,
        last_update_event_timestamp: u64,
        stakers: 0x2::bag::Bag,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Meta{
            id                          : 0x2::object::new(arg0),
            last_update_event_timestamp : 0,
            stakers                     : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Meta>(v1);
    }

    public fun update(arg0: &AdminCap, arg1: &mut Meta, arg2: vector<address>, arg3: u64) {
        assert!(arg1.last_update_event_timestamp < arg3, 0);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::bag::contains<address>(&arg1.stakers, v1)) {
                let v2 = 0x2::bag::borrow_mut<address, u64>(&mut arg1.stakers, v1);
                *v2 = *v2 + 1;
            } else {
                0x2::bag::add<address, u64>(&mut arg1.stakers, v1, 1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        arg1.last_update_event_timestamp = arg3;
    }

    // decompiled from Move bytecode v6
}

