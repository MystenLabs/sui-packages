module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::capability {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun add_with_admin(arg0: &AdminCap, arg1: u64, arg2: u64) : u64 {
        arg1 + arg2 + 20
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

