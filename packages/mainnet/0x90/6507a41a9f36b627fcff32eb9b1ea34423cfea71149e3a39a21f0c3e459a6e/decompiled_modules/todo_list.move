module 0x906507a41a9f36b627fcff32eb9b1ea34423cfea71149e3a39a21f0c3e459a6e::todo_list {
    struct TodoList has key {
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

