module 0x8dc40879fcbce224534d56b6adbd8c7a17849afa1d5121b16939a4853dad312e::zapper {
    struct ZapIn has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_coin_in: u64,
        amount_lp_received: u64,
    }

    struct ZapOut has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_lp_in: u64,
        amount_coin_received: u64,
    }

    public fun calculate_amount_to_swap(arg0: u128, arg1: u128) : u64 {
        (((0x2::math::sqrt_u128(1997 * arg1 * 1997 * arg1 / 1000000 + 3988 * arg0 * arg1 / 1000) - 1997 * arg1 / 1000) * 1000 / 1994) as u64)
    }

    public entry fun zap_in<T0, T1>(arg0: &mut 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1000, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = if (0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::swap_utils::is_ordered<T0, T1>()) {
            let (v3, v4) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
            let v5 = zap_x_in_direct<T0, T1>(v3, v4, arg1, arg2, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>>(v5, v1);
            0x2::coin::value<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>(&v5)
        } else {
            let (v6, v7) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::borrow_mut_pair_and_treasury<T1, T0>(arg0);
            let v8 = zap_y_in_direct<T1, T0>(v6, v7, arg1, arg2, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T1, T0>>>(v8, v1);
            0x2::coin::value<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T1, T0>>(&v8)
        };
        let v9 = ZapIn{
            user               : v1,
            coin_x             : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T0>(),
            coin_y             : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T1>(),
            amount_coin_in     : v0,
            amount_lp_received : v2,
        };
        0x2::event::emit<ZapIn>(v9);
    }

    public entry fun zap_out_to_x<T0, T1>(arg0: &mut 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::Container, arg1: 0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
        let (v3, v4) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::burn<T0, T1>(v1, v2, arg1, arg3);
        let v5 = v3;
        0x2::coin::join<T0>(&mut v5, 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::swap_exact_y_to_x_direct<T0, T1>(v1, v4, arg3));
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        let v7 = ZapOut{
            user                 : v0,
            coin_x               : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T0>(),
            coin_y               : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T1>(),
            amount_lp_in         : 0x2::coin::value<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>(&arg1),
            amount_coin_received : v6,
        };
        0x2::event::emit<ZapOut>(v7);
    }

    public entry fun zap_out_to_y<T0, T1>(arg0: &mut 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::Container, arg1: 0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
        let (v3, v4) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::burn<T0, T1>(v1, v2, arg1, arg3);
        let v5 = v4;
        0x2::coin::join<T1>(&mut v5, 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::swap_exact_x_to_y_direct<T0, T1>(v1, v3, arg3));
        let v6 = 0x2::coin::value<T1>(&v5);
        assert!(v6 >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v0);
        let v7 = ZapOut{
            user                 : v0,
            coin_x               : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T0>(),
            coin_y               : 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper::get_type_name<T1>(),
            amount_lp_in         : 0x2::coin::value<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>>(&arg1),
            amount_coin_received : v6,
        };
        0x2::event::emit<ZapOut>(v7);
    }

    public fun zap_x_in_direct<T0, T1>(arg0: &mut 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::PairMetadata<T0, T1>, arg1: &0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>> {
        let (v0, v1) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::get_reserves<T0, T1>(arg0);
        assert!(v0 >= 1000 && v1 >= 1000, 1);
        let v2 = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::swap_exact_x_to_y_direct<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg2, calculate_amount_to_swap((0x2::coin::value<T0>(&arg2) as u128), (v0 as u128)), arg4), arg4);
        assert!(0x2::coin::value<T1>(&v2) >= arg3, 2);
        0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::add_liquidity_direct<T0, T1>(arg0, arg1, arg2, v2, 1, 1, arg4)
    }

    public fun zap_y_in_direct<T0, T1>(arg0: &mut 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::PairMetadata<T0, T1>, arg1: &0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::treasury::Treasury, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::LP<T0, T1>> {
        let (v0, v1) = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::pair::get_reserves<T0, T1>(arg0);
        assert!(v0 >= 1000 && v1 >= 1000, 1);
        let v2 = 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::swap_exact_y_to_x_direct<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, calculate_amount_to_swap((0x2::coin::value<T1>(&arg2) as u128), (v1 as u128)), arg4), arg4);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 2);
        0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::router::add_liquidity_direct<T0, T1>(arg0, arg1, v2, arg2, 1, 1, arg4)
    }

    // decompiled from Move bytecode v6
}

