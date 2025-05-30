module 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::splubb_coin_flip {
    fun burn_gas(arg0: &0x2::tx_context::TxContext) {
        0x2::hash::blake2b256(0x2::tx_context::digest(arg0));
    }

    fun compute_fee(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::constants::fee_precision()) as u64)
    }

    fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    entry fun flip<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0);
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg1, arg2, arg3, v0, arg4);
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::events::emit_flip<T0>(0x2::tx_context::sender(arg4), v1, 0x2::coin::value<T0>(&arg2), v2, v3, arg3, 0x1::option::none<0x1::type_name::TypeName>());
    }

    fun flip_impl<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (bool, u64, u64) {
        validate_flip<T0>(arg0, &arg2);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x2::random::generate_bool(&mut v0) == arg3;
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::pool_mut<T0>(arg0), 0x2::coin::value<T0>(&arg2)), arg5));
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let (v3, v4) = if (v1) {
            burn_gas(arg5);
            let v5 = compute_fee(0x2::balance::value<T0>(&v2), arg4);
            0x2::balance::join<T0>(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::treasury_mut<T0>(arg0), 0x2::balance::split<T0>(&mut v2, v5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
            (v5, 0x2::balance::value<T0>(&v2))
        } else {
            0x2::balance::join<T0>(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::pool_mut<T0>(arg0), v2);
            (0, 0)
        };
        (v1, v3, v4)
    }

    entry fun flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::requires_kiosk<T1>(arg1), 2);
        assert!(0x2::kiosk::owner(arg4) == 0x2::tx_context::sender(arg7), 4);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 5);
        let v0 = min(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0), 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::fee_rate<T1>(arg1));
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg2, arg3, arg6, v0, arg7);
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::events::emit_flip<T0>(0x2::tx_context::sender(arg7), v1, 0x2::coin::value<T0>(&arg3), v2, v3, arg6, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()));
    }

    entry fun flip_with_partnership<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::Partnership<T0>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::requires_kiosk<T0>(arg1), 3);
        let v0 = min(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0), 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::fee_rate<T0>(arg1));
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg2, arg3, arg4, v0, arg5);
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::events::emit_flip<T0>(0x2::tx_context::sender(arg5), v1, 0x2::coin::value<T0>(&arg3), v2, v3, arg4, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()));
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    entry fun multi_flip<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0);
        multi_flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun multi_flip_impl<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<bool>(&arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = vector[];
        while (v0 > v2) {
            let v6 = 0x2::coin::split<T0>(&mut arg2, div_down(v1, v0), arg6);
            let v7 = *0x1::vector::borrow<bool>(&arg3, v2);
            let (v8, v9, v10) = flip_impl<T0>(arg0, arg1, v6, v7, arg4, arg6);
            let v11 = v8 && v7 || !v7;
            0x1::vector::push_back<bool>(&mut v5, v11);
            v3 = v3 + v9;
            v4 = v4 + v10;
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::events::emit_multi_flip<T0>(0x2::tx_context::sender(arg6), v1, v3, v4, arg3, v5, arg5);
    }

    entry fun multi_flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: vector<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::requires_kiosk<T1>(arg1), 2);
        assert!(0x2::kiosk::owner(arg4) == 0x2::tx_context::sender(arg7), 4);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 5);
        let v0 = min(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0), 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::fee_rate<T1>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun multi_flip_with_partnership<T0>(arg0: &mut 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::Partnership<T0>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: vector<bool>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::requires_kiosk<T0>(arg1), 3);
        let v0 = min(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::fee_rate<T0>(arg0), 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::partnership::fee_rate<T0>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()), arg5);
    }

    fun validate_flip<T0>(arg0: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::House<T0>, arg1: &0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::max_amount<T0>(arg0) >= v0 && v0 >= 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::min_amount<T0>(arg0), 0);
        assert!(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::house::pool_value<T0>(arg0) >= v0, 1);
    }

    // decompiled from Move bytecode v6
}

