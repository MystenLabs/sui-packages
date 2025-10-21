module 0x974b01bc633787310c9d73df43bc8dca4f95c1a66f0a7d319d013616f10dd597::todo {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
        completed: vector<bool>,
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id        : 0x2::object::new(arg0),
            items     : 0x1::vector::empty<0x1::string::String>(),
            completed : 0x1::vector::empty<bool>(),
        };
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

