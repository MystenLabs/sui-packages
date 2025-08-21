module 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::acl {
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

