module 0x72fa0f451ef0e674206d74b720ac2ce9d2d5e1b8f1239d7ac7f619a12f47ca51::todo_list {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        todos: vector<0x1::string::String>,
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.todos, arg1);
    }

    public fun delete(arg0: TodoList) {
        let TodoList {
            id    : v0,
            todos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{
            id    : 0x2::object::new(arg0),
            todos : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.todos, arg1);
    }

    public fun get_length(arg0: &TodoList) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.todos)
    }

    public fun get_todos(arg0: &TodoList) : &vector<0x1::string::String> {
        &arg0.todos
    }

    // decompiled from Move bytecode v6
}

