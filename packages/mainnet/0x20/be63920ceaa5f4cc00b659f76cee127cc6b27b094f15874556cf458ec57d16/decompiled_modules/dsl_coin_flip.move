module 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::dsl_coin_flip {
    fun burn_gas(arg0: &0x2::tx_context::TxContext) {
        0x2::hash::blake2b256(0x2::tx_context::digest(arg0));
    }

    fun compute_fee(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::constants::fee_precision()) as u64)
    }

    fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    fun div_up(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    entry fun flip<T0>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0);
        flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun flip_impl<T0>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_flip<T0>(arg0, &arg2);
        let v0 = 0x2::random::new_generator(arg1, arg6);
        let v1 = 0x2::random::generate_bool(&mut v0) == arg3;
        let v2 = 0x2::coin::value<T0>(&arg2);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_mut<T0>(arg0), v2), arg6));
        if (v1) {
            burn_gas(arg6);
            let v3 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events::emit_flip<T0>(0x2::tx_context::sender(arg6), v1, v3, v2, arg3, arg5);
        } else {
            0x2::balance::join<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
            0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events::emit_flip<T0>(0x2::tx_context::sender(arg6), v1, 0, v2, arg3, arg5);
        };
    }

    entry fun flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::requires_kiosk<T1>(arg1), 9223372311733075975);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372316028174345);
        let v0 = min(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0), 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::fee_rate<T1>(arg1));
        flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun flip_with_partnership<T0>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::Partnership<T0>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::requires_kiosk<T0>(arg1), 9223372243013468165);
        let v0 = min(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0), 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::fee_rate<T0>(arg1));
        flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()), arg5);
    }

    fun is_even(arg0: u64) : bool {
        arg0 % 2 == 0
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    entry fun multi_flip<T0>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0);
        multi_flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun multi_flip_impl<T0>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<bool>, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_multi_flip<T0>(arg0, &arg2, arg3);
        let v0 = 0x2::random::new_generator(arg1, arg6);
        let v1 = 0x1::vector::length<bool>(&arg3);
        let v2 = div_up(v1, 2);
        let v3 = vector[];
        let v4 = 0x2::coin::value<T0>(&arg2);
        let v5 = 0;
        0x1::vector::reverse<bool>(&mut arg3);
        while (!0x1::vector::is_empty<bool>(&arg3)) {
            let v6 = 0x2::random::generate_bool(&mut v0);
            0x1::vector::push_back<bool>(&mut v3, v6);
            let v7 = if (v6 == 0x1::vector::pop_back<bool>(&mut arg3)) {
                v5 + 1
            } else {
                v5
            };
            v5 = v7;
        };
        0x1::vector::destroy_empty<bool>(arg3);
        if (v2 == v5 && is_even(v1)) {
            let v8 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v8, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events::emit_multi_flip<T0>(0x2::tx_context::sender(arg6), false, true, v8, v4, arg3, v3, arg5);
            return
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_mut<T0>(arg0), v4), arg6));
        if (v5 >= v2) {
            burn_gas(arg6);
            let v9 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v9, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events::emit_multi_flip<T0>(0x2::tx_context::sender(arg6), true, false, v9, v4, arg3, v3, arg5);
        } else {
            0x2::balance::join<T0>(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
            0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events::emit_multi_flip<T0>(0x2::tx_context::sender(arg6), false, false, 0, v4, arg3, v3, arg5);
        };
    }

    entry fun multi_flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: vector<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::requires_kiosk<T1>(arg1), 9223372492121702407);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372496416800777);
        let v0 = min(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0), 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::fee_rate<T1>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun multi_flip_with_partnership<T0, T1>(arg0: &mut 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: vector<bool>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::requires_kiosk<T1>(arg1), 9223372423402094597);
        let v0 = min(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::fee_rate<T0>(arg0), 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::partnership::fee_rate<T1>(arg1));
        multi_flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg5);
    }

    fun validate_flip<T0>(arg0: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::coin::Coin<T0>) {
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::max_amount<T0>(arg0) >= 0x2::coin::value<T0>(arg1) && 0x2::coin::value<T0>(arg1) >= 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::min_amount<T0>(arg0), 9223373046172090369);
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_value<T0>(arg0) >= 0x2::coin::value<T0>(arg1), 9223373050467188739);
    }

    fun validate_multi_flip<T0>(arg0: &0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::House<T0>, arg1: &0x2::coin::Coin<T0>, arg2: vector<bool>) {
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::constants::max_bets() >= 0x1::vector::length<bool>(&arg2), 9223373067647582219);
        let v0 = div_down(0x2::coin::value<T0>(arg1), 0x1::vector::length<bool>(&arg2));
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::max_amount<T0>(arg0) >= v0 && v0 >= 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::min_amount<T0>(arg0), 9223373084826796033);
        assert!(0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::house::pool_value<T0>(arg0) >= 0x2::coin::value<T0>(arg1), 9223373089121894403);
    }

    // decompiled from Move bytecode v6
}

