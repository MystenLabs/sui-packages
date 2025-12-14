module 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

