module 0xf92a31414014609ce73b1750b71c6b460f913345c30a25f7a2112843105efa76::todolist {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        tasks: vector<0x1::string::String>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id    : 0x2::object::new(arg0),
            tasks : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun addItem(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tasks, arg1);
    }

    public fun deleteList(arg0: TodoList) {
        let TodoList {
            id    : v0,
            tasks : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun removeItem(arg0: &mut TodoList, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.tasks, arg1);
    }

    // decompiled from Move bytecode v6
}

