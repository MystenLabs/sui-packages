module 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::acl {
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

