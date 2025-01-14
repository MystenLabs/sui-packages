module 0x7dfbb7509eb9db7c4a6fbe53bfceae39d1bc428cfbd353634dcbb87e18313ae1::router_v2 {
    public entry fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        ensure(arg0, arg7);
        if (!0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::pair_is_created<T0, T1>(arg1)) {
            0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::create_pair<T0, T1>(arg1, arg8);
        };
        if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(add_liquidity_internal<T0, T1>(v0, v1, arg2, arg3, arg4, arg5, arg8), arg6);
        } else {
            let (v2, v3) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T1, T0>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T1, T0>>>(add_liquidity_internal<T1, T0>(v2, v3, arg3, arg2, arg5, arg4, arg8), arg6);
        };
    }

    public fun add_liquidity_internal<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        let (v4, v5) = if (v2 == 0 && v3 == 0) {
            (v0, v1)
        } else {
            let v6 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::quote(v0, v2, v3);
            if (v6 <= v1) {
                assert!(v6 >= arg5, 1);
                (v0, v6)
            } else {
                let v7 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::quote(v1, v3, v2);
                assert!(v7 <= v0, 3);
                assert!(v7 >= arg4, 0);
                (v7, v1)
            }
        };
        let v8 = 0x2::tx_context::sender(arg6);
        if (v0 > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - v4, arg6), v8);
        };
        if (v1 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v1 - v5, arg6), v8);
        };
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::mint<T0, T1>(arg0, arg1, arg2, arg3, arg6)
    }

    public fun add_liquidity_returns<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg1);
        add_liquidity_internal<T0, T1>(v0, v1, arg2, arg3, arg4, arg5, arg8)
    }

    fun ensure(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg0), 4);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        ensure(arg0, arg6);
        let (v0, v1) = remove_liquidity_returns<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg5);
    }

    public fun remove_liquidity_returns<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
        let (v2, v3) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::burn<T0, T1>(v0, v1, arg1, arg4);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::coin::value<T0>(&v5) >= arg2, 0);
        assert!(0x2::coin::value<T1>(&v4) >= arg3, 1);
        (v5, v4)
    }

    public entry fun swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        ensure(arg0, arg5);
        let v0 = swap_exact_input_direct<T0, T1>(arg1, arg2, arg6);
        assert!(0x2::coin::value<T1>(&v0) >= arg3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg4);
    }

    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T0, T1>(arg0);
            swap_exact_x_to_y_direct<T0, T1>(v1, arg1, arg2)
        } else {
            let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T1, T0>(arg0);
            swap_exact_y_to_x_direct<T1, T0>(v2, arg1, arg2)
        }
    }

    public entry fun swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        ensure(arg0, arg6);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::left_amount<T0>(&arg2, arg3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0, arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(swap_exact_output_direct<T0, T1>(arg1, arg2, arg4, arg7), arg5);
    }

    public fun swap_exact_output_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T0, T1>(arg0);
            swap_x_to_exact_y_direct<T0, T1>(v1, arg1, arg2, arg3)
        } else {
            let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T1, T0>(arg0);
            swap_y_to_exact_x_direct<T1, T0>(v2, arg1, arg2, arg3)
        }
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        let (v2, v3) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::swap<T0, T1>(arg0, arg1, 0, 0x2::coin::zero<T1>(arg2), 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_out(0x2::coin::value<T0>(&arg1), v0, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0)), arg2);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::coin::value<T0>(&v5) == 0 && 0x2::coin::value<T1>(&v4) > 0, 5);
        0x2::coin::destroy_zero<T0>(v5);
        v4
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        let (v2, v3) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::swap<T0, T1>(arg0, 0x2::coin::zero<T0>(arg2), 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_out(0x2::coin::value<T1>(&arg1), v1, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0)), arg1, 0, arg2);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::coin::value<T1>(&v4) == 0 && 0x2::coin::value<T0>(&v5) > 0, 5);
        0x2::coin::destroy_zero<T1>(v4);
        v5
    }

    public fun swap_x_to_exact_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_in(arg2, v1, v2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0));
        assert!(v3 <= v0, 6);
        if (v0 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0 - v3, arg3), 0x2::tx_context::sender(arg3));
        };
        let (v4, v5) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::swap<T0, T1>(arg0, arg1, 0, 0x2::coin::zero<T1>(arg3), arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        assert!(0x2::coin::value<T0>(&v7) == 0 && 0x2::coin::value<T1>(&v6) > 0, 5);
        0x2::coin::destroy_zero<T0>(v7);
        v6
    }

    public fun swap_y_to_exact_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_in(arg2, v2, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0));
        assert!(v3 <= v0, 6);
        if (v0 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v0 - v3, arg3), 0x2::tx_context::sender(arg3));
        };
        let (v4, v5) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::swap<T0, T1>(arg0, 0x2::coin::zero<T0>(arg3), arg2, arg1, 0, arg3);
        let v6 = v5;
        let v7 = v4;
        assert!(0x2::coin::value<T1>(&v6) == 0 && 0x2::coin::value<T0>(&v7) > 0, 5);
        0x2::coin::destroy_zero<T1>(v6);
        v7
    }

    // decompiled from Move bytecode v6
}

