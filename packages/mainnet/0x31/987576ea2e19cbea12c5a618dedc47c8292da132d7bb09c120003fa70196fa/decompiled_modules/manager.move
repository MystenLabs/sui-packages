module 0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::manager {
    struct Manager has store, key {
        id: 0x2::object::UID,
        managers: vector<address>,
    }

    struct AddManagerEvent has copy, drop {
        manager: address,
        by: address,
    }

    struct RemoveManagerEvent has copy, drop {
        manager: address,
        by: address,
    }

    public fun add_manager(arg0: &mut Manager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager(arg0, 0x2::tx_context::sender(arg2));
        0x1::vector::push_back<address>(&mut arg0.managers, arg1);
        let v0 = AddManagerEvent{
            manager : arg1,
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddManagerEvent>(v0);
    }

    public fun assert_is_manager(arg0: &Manager, arg1: address) {
        assert!(is_manager(arg0, arg1), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, 0x2::tx_context::sender(arg0));
        0x1::vector::push_back<address>(v1, @0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53);
        let v2 = Manager{
            id       : 0x2::object::new(arg0),
            managers : v0,
        };
        0x2::transfer::share_object<Manager>(v2);
    }

    public fun is_manager(arg0: &Manager, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.managers, &arg1)
    }

    public fun remove_manager(arg0: &mut Manager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.managers, &arg1);
        assert!(v0, 1);
        0x1::vector::remove<address>(&mut arg0.managers, v1);
        let v2 = RemoveManagerEvent{
            manager : arg1,
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RemoveManagerEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

