module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::todo_shared {
    struct TodoList has key {
        id: 0x2::object::UID,
        owner: address,
        items: vector<0x1::string::String>,
    }

    public fun add_item(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun create_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id    : 0x2::object::new(arg1),
            owner : arg0,
            items : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<TodoList>(v0);
    }

    public fun len(arg0: &TodoList) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun owner(arg0: &TodoList) : address {
        arg0.owner
    }

    public fun remove_item(arg0: &mut TodoList, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 1);
        0x1::vector::swap_remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

