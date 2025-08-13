module 0x346acd3d4e93b389463c19cb17f698c0a5704abc3a26c9e888f796e240b47250::acl {
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

