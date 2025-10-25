module 0x545b534f1926dc4cae37bcf6c1b994d018e67236aba6eccbc5528e772103494c::todo_list {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        items: vector<0x1::string::String>,
        is_completed: bool,
        date_created: u64,
    }

    public fun create_todo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id           : 0x2::object::new(arg3),
            name         : arg0,
            description  : arg1,
            items        : 0x1::vector::empty<0x1::string::String>(),
            is_completed : false,
            date_created : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::public_transfer<TodoList>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

