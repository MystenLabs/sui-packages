module 0x9ca5d501e4a7861fc6816395bacd835f46cccd538257f27edc038285ffed88ad::todolist {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun add_item(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun delete_list(arg0: TodoList) {
        let TodoList {
            id    : v0,
            items : v1,
        } = arg0;
        0x1::vector::destroy_empty<0x1::string::String>(v1);
        0x2::object::delete(v0);
    }

    public fun remove_item(arg0: &mut TodoList, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 1);
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

