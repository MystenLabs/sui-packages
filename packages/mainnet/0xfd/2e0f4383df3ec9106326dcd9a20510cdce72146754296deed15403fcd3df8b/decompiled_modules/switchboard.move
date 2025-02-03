module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

