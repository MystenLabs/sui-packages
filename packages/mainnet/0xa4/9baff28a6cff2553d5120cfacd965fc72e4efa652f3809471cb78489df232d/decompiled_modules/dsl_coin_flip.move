module 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::dsl_coin_flip {
    fun burn_gas(arg0: &0x2::tx_context::TxContext) {
        0x2::hash::blake2b256(0x2::tx_context::digest(arg0));
    }

    fun compute_fee(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::constants::fee_precision()) as u64)
    }

    fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    entry fun flip<T0>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0);
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg1, arg2, arg3, v0, arg4);
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::events::emit_flip<T0>(0x2::tx_context::sender(arg4), v1, v2, v3, arg3, 0x1::option::none<0x1::type_name::TypeName>());
    }

    fun flip_impl<T0>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (bool, u64, u64) {
        validate_flip<T0>(arg0, &arg2);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x2::random::generate_bool(&mut v0) == arg3;
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::pool_mut<T0>(arg0), 0x2::coin::value<T0>(&arg2)), arg5));
        let (v2, v3) = if (v1) {
            burn_gas(arg5);
            let v4 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v4, arg5)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
            (v4, 0x2::coin::value<T0>(&arg2))
        } else {
            0x2::balance::join<T0>(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::pool_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
            (0, 0)
        };
        (v1, v2, v3)
    }

    entry fun flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::requires_kiosk<T1>(arg1), 9223372346092814343);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372350387912713);
        let v0 = min(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0), 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::fee_rate<T1>(arg1));
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg2, arg3, arg6, v0, arg7);
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::events::emit_flip<T0>(0x2::tx_context::sender(arg7), v1, v2, v3, arg6, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()));
    }

    entry fun flip_with_partnership<T0>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::Partnership<T0>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::requires_kiosk<T0>(arg1), 9223372243013468165);
        let v0 = min(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0), 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::fee_rate<T0>(arg1));
        let (v1, v2, v3) = flip_impl<T0>(arg0, arg2, arg3, arg4, v0, arg5);
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::events::emit_flip<T0>(0x2::tx_context::sender(arg5), v1, v2, v3, arg4, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()));
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    entry fun multi_flip<T0>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0);
        multi_flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun multi_flip_impl<T0>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<bool>(&arg3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[];
        while (v0 > v1) {
            let v5 = 0x2::coin::split<T0>(&mut arg2, div_down(0x2::coin::value<T0>(&arg2), v0), arg6);
            let (v6, v7, v8) = flip_impl<T0>(arg0, arg1, v5, *0x1::vector::borrow<bool>(&arg3, v1), arg4, arg6);
            0x1::vector::push_back<bool>(&mut v4, v6);
            v2 = v2 + v7;
            v3 = v3 + v8;
            v1 = v1 + 1;
        };
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
        };
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::events::emit_multi_flip<T0>(0x2::tx_context::sender(arg6), v2, v3, arg3, v4, arg5);
    }

    entry fun multi_flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: vector<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::requires_kiosk<T1>(arg1), 9223372560841179143);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372565136277513);
        let v0 = min(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0), 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::fee_rate<T1>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun multi_flip_with_partnership<T0, T1>(arg0: &mut 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: vector<bool>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::requires_kiosk<T1>(arg1), 9223372492121571333);
        let v0 = min(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::fee_rate<T0>(arg0), 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::partnership::fee_rate<T1>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg5);
    }

    fun validate_flip<T0>(arg0: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::House<T0>, arg1: &0x2::coin::Coin<T0>) {
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::max_amount<T0>(arg0) >= 0x2::coin::value<T0>(arg1) && 0x2::coin::value<T0>(arg1) >= 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::min_amount<T0>(arg0), 9223372994632482817);
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house::pool_value<T0>(arg0) >= 0x2::coin::value<T0>(arg1), 9223372998927581187);
    }

    // decompiled from Move bytecode v6
}

