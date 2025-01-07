module 0x6e5cc196e349910dcb2b353bf6e5603164a9551161b5b6c4eb917ed44105e3a9::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        user_bags: 0x2::object_table::ObjectTable<0x2::object::ID, 0x2::object_bag::ObjectBag>,
    }

    struct NewUserEvent has copy, drop {
        user_id: 0x2::object::ID,
        creator: address,
    }

    public fun add_item<T0: store + key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: T0) {
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x2::object_bag::ObjectBag>(&arg0.user_bags, arg1) == false, 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x2::object_bag::ObjectBag>(&mut arg0.user_bags, arg1);
        0x2::object_bag::add<u64, T0>(v0, 0x2::object_bag::length(v0) + 1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg0),
            user_bags : 0x2::object_table::new<0x2::object::ID, 0x2::object_bag::ObjectBag>(arg0),
        };
        0x2::transfer::transfer<Registry>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_user(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x2::object_bag::ObjectBag>(&arg0.user_bags, arg1) == false, 0);
        0x2::object_table::add<0x2::object::ID, 0x2::object_bag::ObjectBag>(&mut arg0.user_bags, arg1, 0x2::object_bag::new(arg2));
        let v0 = NewUserEvent{
            user_id : arg1,
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NewUserEvent>(v0);
    }

    public fun remove_all_items<T0: store + key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: address) {
        abort 0
    }

    public fun remove_all_items_v2<T0: store + key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: address) {
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x2::object_bag::ObjectBag>(&arg0.user_bags, arg1) == false, 1);
        let v0 = remove_user(arg0, arg1);
        let v1 = 1;
        while (v1 < 0x2::object_bag::length(&v0) + 1) {
            0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(&mut v0, v1), arg2);
            v1 = v1 + 1;
        };
        0x2::object_bag::destroy_empty(v0);
    }

    public fun remove_item<T0: store + key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: u64, arg3: address) {
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x2::object_bag::ObjectBag>(&arg0.user_bags, arg1) == false, 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x2::object_bag::ObjectBag>(&mut arg0.user_bags, arg1);
        assert!(!0x2::object_bag::contains<u64>(v0, arg2) == false, 2);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(v0, arg2), arg3);
    }

    public(friend) fun remove_user(arg0: &mut Registry, arg1: 0x2::object::ID) : 0x2::object_bag::ObjectBag {
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x2::object_bag::ObjectBag>(&arg0.user_bags, arg1) == false, 1);
        0x2::object_table::remove<0x2::object::ID, 0x2::object_bag::ObjectBag>(&mut arg0.user_bags, arg1)
    }

    // decompiled from Move bytecode v6
}

