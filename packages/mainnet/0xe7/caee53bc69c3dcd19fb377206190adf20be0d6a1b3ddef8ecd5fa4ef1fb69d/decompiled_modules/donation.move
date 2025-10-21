module 0xe7caee53bc69c3dcd19fb377206190adf20be0d6a1b3ddef8ecd5fa4ef1fb69d::donation {
    struct Donation has key {
        id: 0x2::object::UID,
        donations: 0x2::table::Table<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>,
        accumulated_donations: 0x2::table::Table<address, u64>,
        balances: 0x2::bag::Bag,
    }

    public(friend) fun donate<T0>(arg0: &mut Donation, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            let v0 = 0x2::tx_context::sender(arg3);
            let v1 = 0x1::type_name::with_defining_ids<T0>();
            let v2 = 0x2::coin::value<T0>(&arg2);
            if (!0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.donations, arg1)) {
                0x2::table::add<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.donations, arg1, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>());
            };
            let v3 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.donations, arg1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v3, &v1)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v3, v1, v2);
            } else {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(v3, &v1) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v3, &v1) + v2;
            };
            if (!0x2::table::contains<address, u64>(&arg0.accumulated_donations, v0)) {
                0x2::table::add<address, u64>(&mut arg0.accumulated_donations, v0, v2);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.accumulated_donations, v0) = *0x2::table::borrow<address, u64>(&arg0.accumulated_donations, v0) + v2;
            };
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::coin::into_balance<T0>(arg2));
            } else {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), 0x2::coin::into_balance<T0>(arg2));
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Donation{
            id                    : 0x2::object::new(arg0),
            donations             : 0x2::table::new<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(arg0),
            accumulated_donations : 0x2::table::new<address, u64>(arg0),
            balances              : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Donation>(v0);
    }

    public(friend) fun take_all_by_identifier<T0>(arg0: &mut Donation, arg1: 0x1::ascii::String) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.donations, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.donations, arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v0, &v1), 102);
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(v0, &v1);
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        assert!(0x2::balance::value<T0>(v4) < v3, 103);
        0x2::balance::split<T0>(v4, v3)
    }

    // decompiled from Move bytecode v6
}

