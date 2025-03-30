module 0x4a58713ecf8ca4652267adf82311c4f15cc1fa51f38cfaf88fa76c075dff9817::test {
    struct Parent has store, key {
        id: 0x2::object::UID,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun add_child(arg0: &mut Parent, arg1: Child) {
        0x2::dynamic_object_field::add<vector<u8>, Child>(&mut arg0.id, b"child", arg1);
    }

    public fun create_child(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Child{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::public_transfer<Child>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_parent(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Parent>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun delete_child(arg0: &mut Parent) {
        let Child {
            id    : v0,
            count : _,
        } = reclaim_child(arg0);
        0x2::object::delete(v0);
    }

    public fun mutate_child(arg0: &mut Child) {
        arg0.count = arg0.count + 1;
    }

    public fun mutate_child_via_parent(arg0: &mut Parent) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Child>(&mut arg0.id, b"child");
        mutate_child(v0);
    }

    public fun reclaim_child(arg0: &mut Parent) : Child {
        0x2::dynamic_object_field::remove<vector<u8>, Child>(&mut arg0.id, b"child")
    }

    // decompiled from Move bytecode v6
}

