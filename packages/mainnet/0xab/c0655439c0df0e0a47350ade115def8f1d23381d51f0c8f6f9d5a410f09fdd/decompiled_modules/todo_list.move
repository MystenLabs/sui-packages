module 0xabc0655439c0df0e0a47350ade115def8f1d23381d51f0c8f6f9d5a410f09fdd::todo_list {
    struct UpgradeCap has store, key {
        id: 0x2::object::UID,
        version: u64,
        disabled_versions: vector<u64>,
    }

    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
        version: u64,
    }

    public fun length(arg0: &TodoList) : u64 {
        assert!(arg0.version == 1, 0);
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun remove(arg0: &mut TodoList, arg1: u64) : 0x1::string::String {
        assert!(arg0.version == 1, 0);
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1)
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
            items   : 0x1::vector::empty<0x1::string::String>(),
            version : 1,
        }
    }

    public fun add(arg0: &mut TodoList, arg1: 0x1::string::String) {
        assert!(arg0.version == 1, 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
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
            version           : 1,
            disabled_versions : vector[],
        };
        0x2::transfer::transfer<UpgradeCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_version_disabled(arg0: &UpgradeCap, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.disabled_versions, &arg1)
    }

    public fun upgrade_package(arg0: &mut UpgradeCap, arg1: u64) {
        assert!(arg1 > arg0.version, 0);
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

