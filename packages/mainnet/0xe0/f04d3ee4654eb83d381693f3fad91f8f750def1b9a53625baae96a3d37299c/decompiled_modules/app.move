module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        indexes: vector<address>,
    }

    struct APP has drop {
        dummy_field: bool,
    }

    public(friend) fun add_index(arg0: &mut Registry, arg1: address) {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.indexes, &arg1);
        assert!(!v0, 100);
        0x1::vector::push_back<address>(&mut arg0.indexes, arg1);
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = init_interal(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_interal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Registry{
            id      : 0x2::object::new(arg1),
            indexes : 0x1::vector::empty<address>(),
        };
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x2::transfer::public_share_object<Registry>(v1);
        v0
    }

    public(friend) fun remove_index(arg0: &mut Registry, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.indexes, &arg1);
        assert!(v0, 101);
        0x1::vector::remove<address>(&mut arg0.indexes, v1);
    }

    // decompiled from Move bytecode v6
}

