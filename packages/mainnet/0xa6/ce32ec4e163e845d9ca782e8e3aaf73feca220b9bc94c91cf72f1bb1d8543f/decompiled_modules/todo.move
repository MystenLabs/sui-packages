module 0xa6ce32ec4e163e845d9ca782e8e3aaf73feca220b9bc94c91cf72f1bb1d8543f::todo {
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

    // decompiled from Move bytecode v6
}

