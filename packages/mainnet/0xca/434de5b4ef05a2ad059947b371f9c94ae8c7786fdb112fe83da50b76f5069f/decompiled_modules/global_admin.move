module 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::global_admin {
    struct GlobalAdmin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

