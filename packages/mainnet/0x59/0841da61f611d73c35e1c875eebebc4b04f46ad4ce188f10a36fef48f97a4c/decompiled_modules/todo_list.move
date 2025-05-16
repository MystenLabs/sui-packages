module 0x590841da61f611d73c35e1c875eebebc4b04f46ad4ce188f10a36fef48f97a4c::todo_list {
    struct UpgradeCap has store, key {
        id: 0x2::object::UID,
        version: u64,
        disabled_versions: vector<u64>,
    }

    struct TodoItem has drop, store {
        content: 0x1::string::String,
        completed: bool,
    }

    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<TodoItem>,
        version: u64,
    }

    public fun length(arg0: &TodoList) : u64 {
        assert!(arg0.version == 2, 0);
        0x1::vector::length<TodoItem>(&arg0.items)
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) : 0x1::string::String {
        assert!(arg0.version == 2, 0);
        assert!(arg1 < 0x1::vector::length<TodoItem>(&arg0.items), 2);
        let TodoItem {
            content   : v0,
            completed : _,
        } = 0x1::vector::remove<TodoItem>(&mut arg0.items, arg1);
        v0
    }

    public fun delete(arg0: TodoList) {
        let TodoList {
            id      : v0,
            items   : _,
            version : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TodoList {
        TodoList{
            id      : 0x2::object::new(arg0),
            items   : 0x1::vector::empty<TodoItem>(),
            version : 2,
        }
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String) {
        assert!(arg0.version == 2, 0);
        let v0 = TodoItem{
            content   : arg1,
            completed : false,
        };
        0x1::vector::push_back<TodoItem>(&mut arg0.items, v0);
    }

    public fun disable_version(arg0: &mut UpgradeCap, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.disabled_versions, arg1);
    }

    public fun get_version(arg0: &UpgradeCap) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeCap{
            id                : 0x2::object::new(arg0),
            version           : 2,
            disabled_versions : vector[],
        };
        0x2::transfer::transfer<UpgradeCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_completed(arg0: &TodoList, arg1: u64) : bool {
        assert!(arg0.version == 2, 0);
        assert!(arg1 < 0x1::vector::length<TodoItem>(&arg0.items), 2);
        0x1::vector::borrow<TodoItem>(&arg0.items, arg1).completed
    }

    public fun is_version_disabled(arg0: &UpgradeCap, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.disabled_versions, &arg1)
    }

    public fun toggle_complete(arg0: &mut TodoList, arg1: u64) {
        assert!(arg0.version == 2, 0);
        assert!(arg1 < 0x1::vector::length<TodoItem>(&arg0.items), 2);
        let v0 = 0x1::vector::borrow_mut<TodoItem>(&mut arg0.items, arg1);
        v0.completed = !v0.completed;
    }

    public fun upgrade_package(arg0: &mut UpgradeCap, arg1: u64) {
        assert!(arg1 > arg0.version, 0);
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

