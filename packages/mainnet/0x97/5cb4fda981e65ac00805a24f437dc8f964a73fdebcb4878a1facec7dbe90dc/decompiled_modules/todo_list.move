module 0x975cb4fda981e65ac00805a24f437dc8f964a73fdebcb4878a1facec7dbe90dc::todo_list {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        list: vector<Todo>,
    }

    struct Todo has store {
        text: 0x1::string::String,
        deadline: u64,
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) {
        let Todo {
            text     : _,
            deadline : _,
        } = 0x1::vector::remove<Todo>(&mut arg0.list, arg1);
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

    // decompiled from Move bytecode v6
}

