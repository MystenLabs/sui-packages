module 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &Acl) : &Access {
        &arg0.access
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = Acl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<Acl>(v1);
    }

    // decompiled from Move bytecode v6
}

