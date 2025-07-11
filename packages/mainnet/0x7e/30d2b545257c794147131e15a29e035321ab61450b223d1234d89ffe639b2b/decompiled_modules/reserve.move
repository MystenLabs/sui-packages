module 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve {
    struct Reserve has store, key {
        id: 0x2::object::UID,
        coin_amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        coins: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Reserve {
        Reserve{
            id           : 0x2::object::new(arg0),
            coin_amounts : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            coins        : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun join<T0>(arg0: &mut Reserve, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!exists(arg0, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0, arg1);
        } else {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0), arg1);
        };
        update_coin_reserved_amount<T0>(arg0);
    }

    public(friend) fun amount(arg0: &Reserve, arg1: 0x1::type_name::TypeName) : u64 {
        if (!exists(arg0, arg1)) {
            0
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.coin_amounts, &arg1)
        }
    }

    public(friend) fun deduct<T0>(arg0: &mut Reserve, arg1: &mut 0x2::tx_context::TxContext, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64) {
        let v0 = 0x2::coin::value<T0>(arg2);
        let v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64::mul_div(v0, arg3, 10000);
        assert!(v0 >= v1, 2);
        join<T0>(arg0, 0x2::coin::split<T0>(arg2, v1, arg1));
    }

    public(friend) fun exists(arg0: &Reserve, arg1: 0x1::type_name::TypeName) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, arg1)
    }

    public(friend) fun take<T0>(arg0: &mut Reserve, arg1: &mut 0x2::tx_context::TxContext, arg2: u64) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(exists(arg0, v0), 0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg2, 1);
        update_coin_reserved_amount<T0>(arg0);
        0x2::coin::split<T0>(v1, arg2, arg1)
    }

    fun update_coin_reserved_amount<T0>(arg0: &mut Reserve) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.coin_amounts, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.coin_amounts, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.coin_amounts, v0, 0x2::coin::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.coins, 0x1::type_name::get<T0>())));
    }

    // decompiled from Move bytecode v6
}

