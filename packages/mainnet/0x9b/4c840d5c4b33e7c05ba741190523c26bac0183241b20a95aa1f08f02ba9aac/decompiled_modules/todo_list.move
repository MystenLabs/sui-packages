module 0x9b4c840d5c4b33e7c05ba741190523c26bac0183241b20a95aa1f08f02ba9aac::todo_list {
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
        0x1::vector::length<0x1::string::String>(get_todos(arg0))
    }

    public fun get_todos(arg0: &TodoList) : &vector<0x1::string::String> {
        &arg0.todos
    }

    // decompiled from Move bytecode v6
}

