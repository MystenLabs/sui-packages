module 0xd9ac94c7df1489e17af18e7f8cb26d24bfdf6bb01752c8a6b6550763ea3e459c::ownership {
    struct Parent has key {
        id: 0x2::object::UID,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public entry fun create_child(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Child{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::transfer<Child>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_parent(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Parent>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun delete_child(arg0: &mut Parent) {
        let Child {
            id    : v0,
            count : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, Child>(&mut arg0.id, b"child");
        0x2::object::delete(v0);
    }

    public entry fun mutate_child(arg0: &mut Child) {
        arg0.count = arg0.count + 1;
    }

    public entry fun mutate_child_via_parent(arg0: &mut Parent) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Child>(&mut arg0.id, b"child");
        mutate_child(v0);
    }

    public entry fun reclaim_child(arg0: &mut Parent, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Child>(0x2::dynamic_object_field::remove<vector<u8>, Child>(&mut arg0.id, b"child"), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_child_by_dynamic_object_field(arg0: &mut Parent, arg1: Child) {
        0x2::dynamic_object_field::add<vector<u8>, Child>(&mut arg0.id, b"child", arg1);
    }

    public entry fun transfer_child_by_parent_object_address(arg0: address, arg1: Child) {
        0x2::transfer::transfer<Child>(arg1, arg0);
    }

    // decompiled from Move bytecode v6
}

