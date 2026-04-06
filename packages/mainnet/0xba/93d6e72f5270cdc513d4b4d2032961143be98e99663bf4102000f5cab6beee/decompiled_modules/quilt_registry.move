module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::quilt_registry {
    struct DomainPointer has copy, drop, store {
        domain: 0x1::string::String,
        blob_id: 0x1::string::String,
        updated_at: u64,
    }

    struct QuiltRegistry has store, key {
        id: 0x2::object::UID,
        writers: vector<address>,
        domains: vector<DomainPointer>,
    }

    public entry fun add_writer(arg0: &mut QuiltRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_writer(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (!0x1::vector::contains<address>(&arg0.writers, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.writers, arg1);
        };
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = QuiltRegistry{
            id      : 0x2::object::new(arg0),
            writers : v0,
            domains : 0x1::vector::empty<DomainPointer>(),
        };
        0x2::transfer::transfer<QuiltRegistry>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_writer(arg0: &QuiltRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.writers, &arg1)
    }

    public entry fun remove_writer(arg0: &mut QuiltRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_writer(arg0, 0x2::tx_context::sender(arg2)), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.writers, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.writers, v1);
        };
    }

    public entry fun set_blob_id(arg0: &mut QuiltRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(is_writer(arg0, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPointer>(&arg0.domains)) {
            if (0x1::vector::borrow<DomainPointer>(&arg0.domains, v0).domain == arg1) {
                let v1 = 0x1::vector::borrow_mut<DomainPointer>(&mut arg0.domains, v0);
                v1.blob_id = arg2;
                v1.updated_at = arg3;
                return
            };
            v0 = v0 + 1;
        };
        let v2 = DomainPointer{
            domain     : arg1,
            blob_id    : arg2,
            updated_at : arg3,
        };
        0x1::vector::push_back<DomainPointer>(&mut arg0.domains, v2);
    }

    // decompiled from Move bytecode v7
}

