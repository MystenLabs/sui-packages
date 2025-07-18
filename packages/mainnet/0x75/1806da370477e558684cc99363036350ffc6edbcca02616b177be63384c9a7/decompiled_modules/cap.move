module 0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TransferCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_transfer_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<TransferCap>(v0, arg1);
    }

    public fun new_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

