module 0xa99b3b5d45ac671784d5090dd9ecc1d766904b34f4474972e752c6f9262aba17::dynamic_field {
    struct Parent has key {
        id: 0x2::object::UID,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public entry fun add_child(arg0: &mut Parent, arg1: Child) {
        0x2::dynamic_field::add<u64, Child>(&mut arg0.id, 123, arg1);
    }

    public entry fun create_child(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Child{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::public_transfer<Child>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_parent(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Parent>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mutate_child(arg0: &mut Parent) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Child>(&mut arg0.id, 123);
        v0.count = v0.count + 1;
    }

    public entry fun remove_child(arg0: &mut Parent, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Child>(0x2::dynamic_field::remove<u64, Child>(&mut arg0.id, 123), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

