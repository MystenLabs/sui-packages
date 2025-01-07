module 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
        let v0 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::swap_out_with_fee<T0, T1>(arg0, arg1, arg2, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_order<T0, T1>(), arg3);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::event::swapped_event(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::id<T0, T1>(arg0), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
        let v0 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_order<T0, T1>();
        if (!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::has_registered<T0, T1>(arg0)) {
            0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::register_pool<T0, T1>(arg0, v0);
        };
        let v1 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::add_liquidity<T0, T1>(v1, arg1, arg2, arg3, arg4, v0, arg5);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 3, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::event::added_event(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::global_id<T0, T1>(v1), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public entry fun lock_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: 0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::controller(arg1) == @0x41db77874ed08f9997ed00770a2cb0ca83aa3b81d3a50330cd809237bbd76553, 106);
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg1), 102);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::lock_liquidity<T0, T1>(arg0, arg1, arg2, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_order<T0, T1>(), arg3, arg4);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: 0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
        let v0 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_order<T0, T1>();
        let v1 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::event::removed_event(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::global_id<T0, T1>(v1), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>(&arg1));
    }

    public entry fun set_swap_fee<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::controller(arg1) == @0x41db77874ed08f9997ed00770a2cb0ca83aa3b81d3a50330cd809237bbd76553, 106);
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg1), 102);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::set_swap_fee<T0>(arg1, arg2, arg3);
    }

    public entry fun add_liquidity_with_point<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::add_points(arg1, arg0, 0x2::tx_context::sender(arg6), 5);
    }

    public fun get_pool_info<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: u64, arg2: bool, arg3: u256) : (0x2::object::ID, 0x1::string::String, vector<u256>) {
        let v0 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_mut_pool<T0, T1>(arg0, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_order<T0, T1>());
        let (v1, v2, v3) = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_reserves_size<T0, T1>(v0);
        let (v4, v5, v6) = if (arg2) {
            let v7 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_amount_out(arg1, v1, v2);
            (v7, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div_to_u256(v1, 1000000000000000000, v2), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div_to_u256(v1 + arg1, 1000000000000000000, v2 - v7))
        } else {
            let v8 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::get_amount_out(arg1, v2, v1);
            (v8, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div_to_u256(v2, 1000000000000000000, v1), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div_to_u256(v2 + arg1, 1000000000000000000, v1 - v8))
        };
        let v9 = (arg1 as u256) * (1000000000000000000 as u256) / v5;
        let v10 = if (arg3 >= (1000000000000000000 as u256)) {
            0
        } else {
            v9 - v9 * arg3 / (1000000000000000000 as u256)
        };
        let v11 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v11, (v1 as u256));
        0x1::vector::push_back<u256>(&mut v11, (v2 as u256));
        0x1::vector::push_back<u256>(&mut v11, (v3 as u256));
        0x1::vector::push_back<u256>(&mut v11, (v4 as u256));
        0x1::vector::push_back<u256>(&mut v11, v10);
        0x1::vector::push_back<u256>(&mut v11, (1000000000000000000 as u256));
        0x1::vector::push_back<u256>(&mut v11, v5);
        0x1::vector::push_back<u256>(&mut v11, v6);
        0x1::vector::push_back<u256>(&mut v11, (v6 - v5) * (1000000000000000000 as u256) / v5);
        (0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::global_id<T0, T1>(v0), 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::generate_lp_name<T0, T1>(), v11)
    }

    public entry fun multi_add_liquidity<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
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

    public entry fun multi_remove_liquidity<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: vector<0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>>(&arg1), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::LP<T0, T1>>(&mut v0, arg1);
        remove_liquidity<T0, T1>(arg0, v0, arg2);
    }

    public entry fun multi_swap<T0, T1>(arg0: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 105);
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

    public entry fun swap_with_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg1, arg2, arg3, arg4);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::add_points(arg1, arg0, 0x2::tx_context::sender(arg4), 5);
    }

    public entry fun swap_with_point<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg1, arg2, arg3, arg4);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::add_points(arg1, arg0, 0x2::tx_context::sender(arg4), 5);
    }

    // decompiled from Move bytecode v6
}

