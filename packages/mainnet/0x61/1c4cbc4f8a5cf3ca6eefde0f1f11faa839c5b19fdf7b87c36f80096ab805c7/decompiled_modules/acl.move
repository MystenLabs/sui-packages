module 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::acl {
    struct AclRegistry has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun get_admin(arg0: &AclRegistry) : address {
        arg0.admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AclRegistry{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AclRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

