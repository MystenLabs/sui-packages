module 0xf4dadc25a518974ba0e5daa1d98aab0e39e0f484d1a953702459236b18dc4ab8::admin {
    struct AdminVec has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TeamFunds has key {
        id: 0x2::object::UID,
        balance_bag: 0x2::bag::Bag,
        key_vector: vector<0x1::string::String>,
    }

    public entry fun add_admin(arg0: &AdminCap, arg1: &mut AdminVec, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&mut arg1.admins, &arg2), 0);
        0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public(friend) fun deposit<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut TeamFunds, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x1::vector::contains<0x1::string::String>(&arg1.key_vector, &v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.balance_bag, v0), arg0);
        } else {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.key_vector, v0);
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.balance_bag, v0, arg0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeamFunds{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x2::bag::new(arg0),
            key_vector  : 0x1::vector::empty<0x1::string::String>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = AdminVec{
            id     : 0x2::object::new(arg0),
            admins : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v2.admins, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TeamFunds>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AdminVec>(v2);
    }

    public entry fun remove_admin(arg0: &AdminCap, arg1: &mut AdminVec, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&mut arg1.admins, &arg2);
        assert!(v0, 1);
        0x1::vector::swap_remove<address>(&mut arg1.admins, v1);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut AdminVec, arg2: &mut TeamFunds, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&mut arg1.admins, &v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.balance_bag, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(0x2::balance::value<T0>(v1) >= arg4, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg4), arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

