module 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 1000);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

