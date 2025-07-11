module 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag {
    struct B has store {
        b: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        bag: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : B {
        B{
            b   : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            bag : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun join<T0>(arg0: &mut B, arg1: 0x2::balance::Balance<T0>) {
        let v0 = &mut arg0.bag;
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.b, &v1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.b, &v1) = add_to_bag<T0>(v0, arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.b, v1, add_to_bag<T0>(v0, arg1));
        };
    }

    public(friend) fun split<T0>(arg0: &mut B, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = &mut arg0.bag;
        let (v1, v2) = remove_from_bag<T0>(v0, arg1, false);
        let v3 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.b, &v3)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.b, &v3) = v2;
        };
        v1
    }

    public fun value<T0>(arg0: &B) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.b, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.b, &v0)
        } else {
            0
        }
    }

    public fun add_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    public fun balances(arg0: &B) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.b
    }

    public fun max_u64() : u128 {
        18446744073709551616
    }

    public fun price_to_sqrt_price(arg0: u64, arg1: u8) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x1::u128::sqrt((arg0 as u128) * 0x1::u128::pow(10, 10)), 18446744073709551616, 0x1::u128::pow(10, (10 + arg1) / 2))
    }

    public fun remove_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64, arg2: bool) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return (0x2::balance::zero<T0>(), 0)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
        } else {
            arg1
        };
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), v1), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0)))
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun sqrt_price_to_price(arg0: u128, arg1: u8, arg2: u8, arg3: u8) : u128 {
        let v0 = if (arg1 > arg2) {
            ((0x1::u256::pow((arg0 as u256) * 0x1::u256::pow(10, arg3) / (18446744073709551616 as u256), 2) / 0x1::u256::pow(10, arg3)) as u128) * 0x1::u128::pow(10, arg1 - arg2)
        } else {
            ((0x1::u256::pow((arg0 as u256) * 0x1::u256::pow(10, arg3) / (18446744073709551616 as u256), 2) / 0x1::u256::pow(10, arg3)) as u128) / 0x1::u128::pow(10, arg2 - arg1)
        };
        (v0 as u128)
    }

    public(friend) fun take_all<T0>(arg0: &mut B) : 0x2::balance::Balance<T0> {
        let v0 = &mut arg0.bag;
        let (v1, _) = remove_from_bag<T0>(v0, 0, true);
        let v3 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.b, &v3)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.b, &v3) = 0;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

