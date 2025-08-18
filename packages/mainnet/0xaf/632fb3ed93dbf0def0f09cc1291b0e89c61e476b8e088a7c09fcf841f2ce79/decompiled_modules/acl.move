module 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::acl {
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

