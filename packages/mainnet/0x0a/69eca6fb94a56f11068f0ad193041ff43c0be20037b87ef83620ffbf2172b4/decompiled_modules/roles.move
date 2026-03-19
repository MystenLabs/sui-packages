module 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::roles {
    struct SuperAdminRole has key {
        id: 0x2::object::UID,
    }

    struct SuperAminRoleChanged has copy, drop {
        from: address,
        to: address,
    }

    struct ROLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ROLES>(arg0, arg1);
        let v0 = SuperAdminRole{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuperAdminRole>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_super_admin_role(arg0: SuperAdminRole, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SuperAdminRole>(arg0, arg1);
        let v0 = SuperAminRoleChanged{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<SuperAminRoleChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

