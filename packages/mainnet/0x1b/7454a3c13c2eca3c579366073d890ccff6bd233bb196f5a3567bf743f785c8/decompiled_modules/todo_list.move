module 0x1b7454a3c13c2eca3c579366073d890ccff6bd233bb196f5a3567bf743f785c8::todo_list {
    struct TodoList has store, key {
        id: 0x2::object::UID,
    }

    struct Todo has key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        deadline: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{id: 0x2::object::new(arg0)}
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Todo{
            id       : 0x2::object::new(arg3),
            text     : arg1,
            deadline : arg2,
        };
        0x2::transfer::transfer<Todo>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun remove(arg0: Todo) {
        let Todo {
            id       : v0,
            text     : _,
            deadline : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

