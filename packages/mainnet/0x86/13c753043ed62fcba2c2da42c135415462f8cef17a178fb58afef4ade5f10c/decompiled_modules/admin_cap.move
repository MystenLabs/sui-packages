module 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        next_serial: u64,
    }

    public fun current_serial(arg0: &AdminCap) : u64 {
        arg0.next_serial
    }

    public fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id          : 0x2::object::new(arg0),
            next_serial : 1,
        }
    }

    public fun init_and_transfer_admin_cap(arg0: &mut 0x2::tx_context::TxContext, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(init_admin_cap(arg0), arg1);
    }

    public fun next_serial(arg0: &mut AdminCap) : u64 {
        let v0 = arg0.next_serial;
        arg0.next_serial = v0 + 1;
        v0
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

