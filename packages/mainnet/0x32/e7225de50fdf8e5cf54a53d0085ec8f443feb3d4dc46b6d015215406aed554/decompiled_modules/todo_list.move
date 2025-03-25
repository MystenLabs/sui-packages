module 0x32e7225de50fdf8e5cf54a53d0085ec8f443feb3d4dc46b6d015215406aed554::todo_list {
    struct TODO_LIST has drop {
        dummy_field: bool,
    }

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

    fun init(arg0: TODO_LIST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TODO_LIST>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

