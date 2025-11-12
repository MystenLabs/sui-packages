module 0xa0d8f59a3bbca0934621f1d5923d8180fb9dec894648c6bc02b719c43c01079d::todolist {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        tasks: vector<0x1::string::String>,
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.tasks, arg1);
    }

    public fun delete(arg0: TodoList) {
        let TodoList {
            id    : v0,
            tasks : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id    : 0x2::object::new(arg0),
            tasks : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun add_item(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tasks, arg1);
    }

    // decompiled from Move bytecode v6
}

