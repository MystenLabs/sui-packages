module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::admin_cap {
    struct AdminCap has key {
        id: 0x2::object::UID,
        next_serial: u64,
    }

    public(friend) fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id          : 0x2::object::new(arg0),
            next_serial : 1,
        }
    }

    public(friend) fun next_serial(arg0: &mut AdminCap) : u64 {
        let v0 = arg0.next_serial;
        arg0.next_serial = v0 + 1;
        v0
    }

    public(friend) fun transfer_to(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

