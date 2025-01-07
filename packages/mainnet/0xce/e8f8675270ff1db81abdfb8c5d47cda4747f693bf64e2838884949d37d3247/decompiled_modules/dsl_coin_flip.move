module 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::dsl_coin_flip {
    entry fun auto_flip<T0>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0);
        auto_flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun auto_flip_impl<T0>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: u16, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_auto_flip<T0>(arg0, &arg2, arg3);
        let v0 = 0x2::random::new_generator(arg1, arg6);
        let v1 = count_ones_in_vector(0x2::random::generate_bytes(&mut v0, arg3), arg3);
        let v2 = v1 > (arg3 as u64) - v1;
        let v3 = 0x2::coin::value<T0>(&arg2);
        if (v1 == (arg3 as u64) - v1) {
            let v4 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v4, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events::emit_auto_flip<T0>(0x2::tx_context::sender(arg6), false, true, v4, v3, arg3, (v1 as u16), arg5);
            return
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_mut<T0>(arg0), v3), arg6));
        if (v2) {
            burn_gas(arg6);
            let v5 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v5, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events::emit_auto_flip<T0>(0x2::tx_context::sender(arg6), v2, false, v5, v3, arg3, (v1 as u16), arg5);
        } else {
            0x2::balance::join<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
            0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events::emit_auto_flip<T0>(0x2::tx_context::sender(arg6), v2, false, 0, v3, arg3, (v1 as u16), arg5);
        };
    }

    entry fun auto_flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: u16, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::requires_kiosk<T1>(arg1), 9223372492121702407);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372496416800777);
        let v0 = min(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0), 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::fee_rate<T1>(arg1));
        auto_flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun auto_flip_with_partnership<T0, T1>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::requires_kiosk<T1>(arg1), 9223372423402094597);
        let v0 = min(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0), 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::fee_rate<T1>(arg1));
        auto_flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg5);
    }

    fun burn_gas(arg0: &0x2::tx_context::TxContext) {
        0x2::hash::blake2b256(0x2::tx_context::digest(arg0));
    }

    fun compute_fee(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::constants::fee_precision()) as u64)
    }

    fun count_ones_in_byte(arg0: u8, arg1: &mut u16) : u64 {
        let v0 = 0;
        loop {
            let v1 = if (arg0 != 0) {
                let v2 = 0;
                arg1 != &v2
            } else {
                false
            };
            if (v1) {
                v0 = v0 + (arg0 & 1);
                arg0 = arg0 >> 1;
                *arg1 = *arg1 - 1;
            } else {
                break
            };
        };
        (v0 as u64)
    }

    fun count_ones_in_vector(arg0: vector<u8>, arg1: u16) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u8>(&arg0) > v1 && arg1 != 0) {
            let v2 = &mut arg1;
            v0 = v0 + count_ones_in_byte(*0x1::vector::borrow<u8>(&arg0, v1), v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    entry fun flip<T0>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0);
        flip_impl<T0>(arg0, arg1, arg2, arg3, v0, 0x1::option::none<0x1::type_name::TypeName>(), arg4);
    }

    fun flip_impl<T0>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_flip<T0>(arg0, &arg2);
        let v0 = 0x2::random::new_generator(arg1, arg6);
        let v1 = 0x2::random::generate_bool(&mut v0) == arg3;
        let v2 = 0x2::coin::value<T0>(&arg2);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_mut<T0>(arg0), v2), arg6));
        if (v1) {
            burn_gas(arg6);
            let v3 = compute_fee(0x2::coin::value<T0>(&arg2), arg4);
            0x2::balance::join<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::treasury_mut<T0>(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events::emit_flip<T0>(0x2::tx_context::sender(arg6), v1, v3, v2, arg3, arg5);
        } else {
            0x2::balance::join<T0>(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
            0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events::emit_flip<T0>(0x2::tx_context::sender(arg6), v1, 0, v2, arg3, arg5);
        };
    }

    entry fun flip_with_kiosk<T0, T1: store + key>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::requires_kiosk<T1>(arg1), 9223372311733075975);
        assert!(0x2::kiosk::has_item_with_type<T1>(arg4, arg5), 9223372316028174345);
        let v0 = min(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0), 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::fee_rate<T1>(arg1));
        flip_impl<T0>(arg0, arg2, arg3, arg6, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
    }

    entry fun flip_with_partnership<T0, T1>(arg0: &mut 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::Partnership<T1>, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::requires_kiosk<T1>(arg1), 9223372243013468165);
        let v0 = min(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::fee_rate<T0>(arg0), 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::partnership::fee_rate<T1>(arg1));
        flip_impl<T0>(arg0, arg2, arg3, arg4, v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg5);
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun validate_auto_flip<T0>(arg0: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::coin::Coin<T0>, arg2: u16) {
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::constants::max_bets() >= arg2, 9223373054762680331);
        let v0 = div_down(0x2::coin::value<T0>(arg1), (arg2 as u64));
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::max_amount<T0>(arg0) >= v0 && v0 >= 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::min_amount<T0>(arg0), 9223373071941894145);
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_value<T0>(arg0) >= 0x2::coin::value<T0>(arg1), 9223373076236992515);
    }

    fun validate_flip<T0>(arg0: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::House<T0>, arg1: &0x2::coin::Coin<T0>) {
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::max_amount<T0>(arg0) >= 0x2::coin::value<T0>(arg1) && 0x2::coin::value<T0>(arg1) >= 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::min_amount<T0>(arg0), 9223373033287188481);
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::house::pool_value<T0>(arg0) >= 0x2::coin::value<T0>(arg1), 9223373037582286851);
    }

    // decompiled from Move bytecode v6
}

