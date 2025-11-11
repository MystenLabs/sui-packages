module 0xc07c231ae8f9cda294a1fc2146340ef2d622ee51ec6ba82a30ae0c217cacbfe7::to_do_list {
    struct ToDoList has store, key {
        id: 0x2::object::UID,
        items: vector<vector<u8>>,
    }

    public fun remove(arg0: &mut ToDoList, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<vector<u8>>(&arg0.items), 2);
        0x1::vector::remove<vector<u8>>(&mut arg0.items, arg1);
    }

    public fun add(arg0: &mut ToDoList, arg1: vector<u8>) {
        0x1::vector::push_back<vector<u8>>(&mut arg0.items, arg1);
    }

    public fun create_todolist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ToDoList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::transfer<ToDoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun edit(arg0: &mut ToDoList, arg1: u64, arg2: vector<u8>) {
        assert!(arg1 < 0x1::vector::length<vector<u8>>(&arg0.items), 1);
        *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.items, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

