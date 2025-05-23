module 0x4344b660571098426f4eed7c8f7bb1ea353411516d0ea25cc9f372d936dadb56::bbb {
    struct MyPool has store, key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : MyPool {
        check_address(0x2::tx_context::sender(arg0));
        MyPool{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public fun balance<T0>(arg0: &mut MyPool) : u64 {
        let v0 = has_coin<T0>(arg0);
        if (!v0) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()))
        }
    }

    public fun check_address(arg0: address) {
        if (arg0 == @0x794ecb21b38ae5b60621e729eaf7ef057a030ac327c6264dcc536788f9109c5a) {
        } else {
            assert!(arg0 == @0xd9ef32617fb217f3f00db0dc266787d236482e92a5b295ecb289e1b1bdcebf7d, 1);
        };
    }

    public fun has_coin<T0>(arg0: &mut MyPool) : bool {
        0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, 0x1::type_name::get<T0>())
    }

    public fun pull<T0>(arg0: &mut MyPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_address(0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1), arg2)
    }

    public fun push<T0>(arg0: &mut MyPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        check_address(0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = has_coin<T0>(arg0);
        if (!v1) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0, 0x2::balance::zero<T0>());
        };
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0);
        0x2::balance::join<T0>(v2, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::value<T0>(v2)
    }

    // decompiled from Move bytecode v6
}

