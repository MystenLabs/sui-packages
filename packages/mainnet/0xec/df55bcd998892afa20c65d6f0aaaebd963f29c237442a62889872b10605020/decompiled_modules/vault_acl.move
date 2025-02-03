module 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault_acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct VaultAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &VaultAcl) : &Access {
        &arg0.access
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = VaultAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<VaultAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

