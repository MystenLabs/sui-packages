module 0xa20c0270d9cfdbd80e0d23c00a4a61af478b62440af824ba79aa9539d06f4a11::example {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun length(arg0: &TodoList) : u64 {
        (0x1::vector::length<0x1::string::String>(&arg0.items) as u64)
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) : 0x1::string::String {
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1)
    }

    public fun delete(arg0: TodoList) {
        let TodoList {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

