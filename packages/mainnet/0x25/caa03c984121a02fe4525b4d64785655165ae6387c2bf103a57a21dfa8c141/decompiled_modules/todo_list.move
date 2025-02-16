module 0x25caa03c984121a02fe4525b4d64785655165ae6387c2bf103a57a21dfa8c141::todo_list {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        list: vector<Todo>,
    }

    struct Todo has store {
        text: 0x1::string::String,
        deadline: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::empty<Todo>(),
        }
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String, arg2: u64) {
        let v0 = Todo{
            text     : arg1,
            deadline : arg2,
        };
        0x1::vector::push_back<Todo>(&mut arg0.list, v0);
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) {
    }

    // decompiled from Move bytecode v6
}

