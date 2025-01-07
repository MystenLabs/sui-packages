module 0x2bb44affa683cd28740f457eb6e3c3c6d67f996bc4df5cdd8aebdb88b01de786::todo {
    struct TodoAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct TodoItem has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        status: u8,
    }

    public entry fun change_todo_status(arg0: &mut TodoItem, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        modify_status(arg0, arg1);
    }

    fun create_todo(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : TodoItem {
        assert!(0x1::vector::length<u8>(&arg0) != 0, 1);
        assert!(0x1::vector::length<u8>(&arg1) != 0, 1);
        TodoItem{
            id          : 0x2::object::new(arg2),
            title       : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            status      : 0,
        }
    }

    public entry fun create_todo_item(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_todo(arg0, arg1, arg2);
        0x2::transfer::transfer<TodoItem>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun delete_todo_item(arg0: TodoItem, arg1: &mut 0x2::tx_context::TxContext) {
        drop_todo(arg0);
    }

    fun drop_todo(arg0: TodoItem) {
        let TodoItem {
            id          : v0,
            title       : _,
            description : _,
            status      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TodoAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    fun modify_status(arg0: &mut TodoItem, arg1: u8) {
        assert!(arg1 == 0 || arg1 == 1, 2);
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

