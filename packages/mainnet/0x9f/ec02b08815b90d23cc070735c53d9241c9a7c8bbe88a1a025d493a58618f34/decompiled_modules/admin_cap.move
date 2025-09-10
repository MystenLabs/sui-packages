module 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::admin_cap {
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

