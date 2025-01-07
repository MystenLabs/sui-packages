module 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let v0 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_order<T0, T1>(), arg3);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::event::swapped_event(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::id<T0, T1>(arg0), 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let v0 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_order<T0, T1>();
        if (!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::has_registered<T0, T1>(arg0)) {
            if (v0) {
                0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::register_pool<T0, T1>(arg0, v0);
            } else {
                0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::register_pool<T1, T0>(arg0, true);
            };
        };
        if (v0) {
            let v1 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::get_mut_pool<T0, T1>(arg0, v0);
            let (v2, v3) = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::add_liquidity<T0, T1>(v1, arg1, arg2, arg3, arg4, true, arg5);
            let v4 = v3;
            assert!(0x1::vector::length<u64>(&v4) == 3, 104);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
            0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::event::added_event(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::global_id<T0, T1>(v1), 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
        } else {
            let v5 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::get_mut_pool<T1, T0>(arg0, true);
            let (v6, v7) = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::add_liquidity<T1, T0>(v5, arg3, arg4, arg1, arg2, true, arg5);
            let v8 = v7;
            assert!(0x1::vector::length<u64>(&v8) == 3, 104);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T1, T0>>>(v6, 0x2::tx_context::sender(arg5));
            0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::event::added_event(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::global_id<T1, T0>(v5), 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::generate_lp_name<T1, T0>(), 0x1::vector::pop_back<u64>(&mut v8), 0x1::vector::pop_back<u64>(&mut v8), 0x1::vector::pop_back<u64>(&mut v8));
        };
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: 0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let v0 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_order<T0, T1>();
        let v1 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::event::removed_event(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::global_id<T0, T1>(v1), 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>(&arg1));
    }

    public entry fun add_liquidity_multi<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg7);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        0x2::pay::join_vec<T1>(&mut v2, arg4);
        let v3 = 0x2::coin::split<T1>(&mut v2, arg5, arg7);
        add_liquidity<T0, T1>(arg0, v1, arg3, v3, arg6, arg7);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun add_liquidity_sui<T0>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let v0 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::deposit_(arg1, arg2, arg6);
        add_liquidity<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI, T0>(arg0, v0, arg3, arg4, arg5, arg6);
    }

    public entry fun add_liquidity_sui_multi<T0>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: u64, arg5: vector<0x2::coin::Coin<T0>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg2) && !0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg5), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg5);
        0x2::pay::join_vec<T0>(&mut v0, arg5);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg6, arg8);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v2, arg2);
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut v2, arg3, arg8);
        add_liquidity_sui<T0>(arg0, arg1, v3, arg4, v1, arg7, arg8);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public fun bridge<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let (v0, v1) = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::swap_bridge<T0, T1>(arg0, arg1, 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_order<T0, T1>(), arg2);
        let v2 = v1;
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::event::swapped_event(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::id<T0, T1>(arg0), 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
        v0
    }

    public entry fun remove_liquidity_multi<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: vector<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>>(&arg1), 105);
        assert!(arg2 > 0, 106);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>(&mut v0, arg1);
        let v1 = 0x2::coin::split<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>(&mut v0, arg2, arg3);
        remove_liquidity<T0, T1>(arg0, v1, arg3);
        if (0x2::coin::value<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::LP<T0, T1>>(v0);
        };
    }

    public entry fun swap_multi<T0, T1>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 105);
        assert!(arg2 > 0, 106);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg4);
        swap<T0, T1>(arg0, v1, arg3, arg4);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public entry fun swap_path<T0, T1, T2, T3>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 105);
        let v0 = swap_path_return_Coin<T0, T1, T2, T3>(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<T3>(&v0) >= arg3, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun swap_path_return_Coin<T0, T1, T2, T3>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg3);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::compare<0x1::type_name::TypeName>(&v2, &v3);
        let v5 = 0x1::type_name::get<T2>();
        let v6 = 0x1::type_name::get<T3>();
        let v7 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::compare<0x1::type_name::TypeName>(&v5, &v6);
        let v8 = if (0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::is_equal(&v4)) {
            if (0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::is_equal(&v7)) {
                bridge<T0, T3>(arg0, v1, arg3)
            } else {
                try_bridge<T0, T2, T3>(arg0, v1, arg3)
            }
        } else if (0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::is_equal(&v7)) {
            try_bridge<T0, T1, T3>(arg0, v1, arg3)
        } else {
            let v9 = try_bridge<T0, T1, T2>(arg0, v1, arg3);
            bridge<T2, T3>(arg0, v9, arg3)
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        v8
    }

    public entry fun swap_sui_for_token<T0, T1, T2>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg2), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI>>(&mut v1, 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::deposit_(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg3, arg5), arg5));
        swap_path<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI, T0, T1, T2>(arg0, v1, arg3, arg4, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public entry fun swap_token_for_sui<T0, T1, T2>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2), 105);
        let v0 = swap_path_return_Coin<T0, T1, T2, 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI>(arg0, arg2, arg3, arg5);
        assert!(0x2::coin::value<0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::WSUI>(&v0) >= arg4, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::withdraw_(arg1, v0, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun try_bridge<T0, T1, T2>(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 102);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x1::type_name::get<T2>();
        let v5 = 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::compare<0x1::type_name::TypeName>(&v3, &v4);
        if (0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::is_equal(&v2) || 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::comparator::is_equal(&v5)) {
            bridge<T0, T2>(arg0, arg1, arg2)
        } else {
            let v7 = bridge<T0, T1>(arg0, arg1, arg2);
            bridge<T1, T2>(arg0, v7, arg2)
        }
    }

    // decompiled from Move bytecode v6
}

