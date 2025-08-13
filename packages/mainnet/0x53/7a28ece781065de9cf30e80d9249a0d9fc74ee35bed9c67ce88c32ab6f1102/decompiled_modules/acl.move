module 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::acl {
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

