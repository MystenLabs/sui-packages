module 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_emergency(arg0), 102);
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>(), arg3);
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::event::swapped_event(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::id<T0, T1>(arg0), 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_emergency(arg0), 102);
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>();
        if (!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::has_registered<T0, T1>(arg0)) {
            let v1 = 0x2::tx_context::sender(arg5);
            assert!(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_create_pool(arg0, &v1), 107);
            0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::register_pool<T0, T1>(arg0, v0);
        };
        let v2 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v3, v4) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::add_liquidity<T0, T1>(v2, arg1, arg2, arg3, arg4, v0, arg5);
        let v5 = v4;
        assert!(0x1::vector::length<u64>(&v5) == 5, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::LP<T0, T1>>>(v3, 0x2::tx_context::sender(arg5));
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::event::added_event(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::global_id<T0, T1>(v2), 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5));
    }

    public fun get_swap_out<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: u64) : u64 {
        assert!(!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_emergency(arg0), 102);
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_swap_out<T0, T1>(arg0, arg1, 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>())
    }

    public fun removeYY<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_mut_pool<T0, T1>(arg0, 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>());
        let v1 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::removeYY<T0, T1>(v0, 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::burn_amount(arg0), arg1, arg2);
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::event::burn_event(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::global_id<T0, T1>(v0), 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v1), 0x1::vector::pop_back<u64>(&mut v1), 0x1::vector::pop_back<u64>(&mut v1));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_emergency(arg0), 102);
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>();
        let v1 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::event::removed_event(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::global_id<T0, T1>(v1), 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::LP<T0, T1>>(&arg1));
    }

    public fun swapCoin<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun getLpliquidity<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global) : (u64, u64, u64) {
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>();
        if (v0) {
            0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_reserves_size<T0, T1>(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_mut_pool<T0, T1>(arg0, v0))
        } else {
            let (v4, v5, v6) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_reserves_size<T1, T0>(0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::get_mut_pool<T1, T0>(arg0, !v0));
            (v5, v4, v6)
        }
    }

    public fun swapCoinBlack<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_emergency(arg0), 102);
        let v0 = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::swapCoin<T0, T1>(arg0, arg1, arg2, 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::is_order<T0, T1>(), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, @0x0);
        0x2::coin::value<T1>(&v0)
    }

    // decompiled from Move bytecode v6
}

