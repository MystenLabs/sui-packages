module 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::interface {
    public fun swap<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg0), 102);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::version::check_version(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_version(arg0));
        let v0 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>(), arg3);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::event::swapped_event(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::id(arg0), 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg0), 102);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::version::check_version(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_version(arg0));
        let v0 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>();
        if (!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::has_registered<T0, T1>(arg0)) {
            0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::register_pool<T0, T1>(arg0, v0);
        };
        let v1 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::add_liquidity<T0, T1>(v1, arg1, arg2, arg3, arg4, v0, arg5);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 5, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::event::added_event(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::global_id<T0, T1>(v1), 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public fun get_switch_config<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global) : (bool, bool) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_switch_config<T0, T1>(arg0)
    }

    public fun get_tax_config<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global) : (u8, u8) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_tax_config<T0, T1>(arg0)
    }

    public fun get_white_list<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global) : vector<address> {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_white_list<T0, T1>(arg0)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: 0x2::coin::Coin<0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg0), 102);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::version::check_version(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_version(arg0));
        let v0 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>();
        let v1 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::event::removed_event(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::global_id<T0, T1>(v1), 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::LP<T0, T1>>(&arg1));
    }

    public fun swapCoin<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun get_amount_out<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: u64) : u64 {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_swap_out<T0, T1>(arg0, arg1, 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>())
    }

    public fun get_lpliquidity<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global) : (u64, u64, u64) {
        let v0 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>();
        if (v0) {
            0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_reserves_size<T0, T1>(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_mut_pool<T0, T1>(arg0, v0))
        } else {
            let (v4, v5, v6) = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_reserves_size<T1, T0>(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_mut_pool<T1, T0>(arg0, !v0));
            (v5, v4, v6)
        }
    }

    public fun swap_coin<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::SwapCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg0), 102);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::version::check_version(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::get_version(arg0));
        let v0 = 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::swapCoin<T0, T1>(arg0, arg1, arg2, 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_order<T0, T1>(), arg4);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::event::swapped_event(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::id(arg0), 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&arg1), 0, 0, 0x2::coin::value<T1>(&v0));
        v0
    }

    // decompiled from Move bytecode v7
}

