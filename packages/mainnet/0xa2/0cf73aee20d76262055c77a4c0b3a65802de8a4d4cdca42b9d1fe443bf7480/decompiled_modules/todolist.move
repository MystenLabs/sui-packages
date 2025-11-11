module 0xa20cf73aee20d76262055c77a4c0b3a65802de8a4d4cdca42b9d1fe443bf7480::todolist {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun length(arg0: &TodoList) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun add_item(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun clear(arg0: &mut TodoList) {
        arg0.items = 0x1::vector::empty<0x1::string::String>();
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_item(arg0: &TodoList, arg1: u64) : &0x1::string::String {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 1000);
        0x1::vector::borrow<0x1::string::String>(&arg0.items, arg1)
    }

    public fun remove_item(arg0: &mut TodoList, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::string::String>(&arg0.items), 1000);
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

