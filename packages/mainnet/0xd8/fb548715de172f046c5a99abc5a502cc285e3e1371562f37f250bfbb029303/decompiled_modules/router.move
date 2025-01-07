module 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    public entry fun swap<T0, T1>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 102);
        let v0 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_order<T0, T1>();
        let (v1, v2, v3, v4) = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::swap_out<T0, T1>(arg0, arg1, arg2, v0, arg3);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
        if (v0) {
            0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::swapped_event<T0, T1>(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::id<T0, T1>(arg0), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_lp_name<T0, T1>(), v3, v4, 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5));
        } else {
            0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::swapped_event<T1, T0>(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::id<T0, T1>(arg0), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_lp_name<T0, T1>(), v3, v4, 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5));
        };
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x83f3c233c7e1ab6a908a4c7fe360f5d1963f86f96613859ba15622165c815e7c::locker::Locks, arg1: &0x2::clock::Clock, arg2: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg2), 102);
        let v0 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_order<T0, T1>();
        if (!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::has_registered<T0, T1>(arg2)) {
            0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::register_pool<T0, T1>(arg2, arg3, arg4, v0);
        };
        let v1 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::get_mut_pool<T0, T1>(arg2, v0);
        let (v2, v3) = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::add_liquidity<T0, T1>(v1, arg5, arg6, arg7, arg8, v0, arg14);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1::vector::length<u64>(&v4) == 3, 104);
        if (arg13 > 0) {
            let v6 = 0x1::vector::empty<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>();
            0x1::vector::push_back<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>(&mut v6, v5);
            0x83f3c233c7e1ab6a908a4c7fe360f5d1963f86f96613859ba15622165c815e7c::locker::add_locked_coins<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(arg0, arg1, arg9, arg10, arg11, arg12, arg13, v6, 0x2::coin::value<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(&v5), arg14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>(v5, 0x2::tx_context::sender(arg14));
        };
        0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::added_event(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::global_id<T0, T1>(v1), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public entry fun one_hop_swap<T0, T1, T2>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 102);
        let (v0, v1, v2, v3, v4) = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::one_hop_swap<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg3));
        if (0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_order<T0, T2>()) {
            0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::swapped_event<T0, T2>(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::id<T0, T2>(arg0), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_hop_name<T0, T1, T2>(), v3, v4, v1, 0, 0, v2);
        } else {
            0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::swapped_event<T2, T0>(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::id<T0, T2>(arg0), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_hop_name<T0, T1, T2>(), v3, v4, v1, 0, 0, v2);
        };
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: 0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 102);
        let v0 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_order<T0, T1>();
        let v1 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::removed_event(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::global_id<T0, T1>(v1), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(&arg1));
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ROUTER>(arg0, arg1);
    }

    public entry fun multi_add_liquidity<T0, T1>(arg0: &mut 0x83f3c233c7e1ab6a908a4c7fe360f5d1963f86f96613859ba15622165c815e7c::locker::Locks, arg1: &0x2::clock::Clock, arg2: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg3: u64, arg4: u64, arg5: vector<0x2::coin::Coin<T0>>, arg6: u64, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg2), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg5) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg8), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg5);
        0x2::pay::join_vec<T0>(&mut v0, arg5);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg6, arg16);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg8);
        0x2::pay::join_vec<T1>(&mut v2, arg8);
        let v3 = 0x2::coin::split<T1>(&mut v2, arg9, arg16);
        add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, arg7, v3, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg16));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg16));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun multi_remove_liquidity<T0, T1>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: vector<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>(&arg1), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(&mut v0, arg1);
        let v1 = 0x2::coin::split<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(&mut v0, arg2, arg3);
        remove_liquidity<T0, T1>(arg0, v1, arg3);
        if (0x2::coin::value<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::LP<T0, T1>>(v0);
        };
    }

    public entry fun multi_swap<T0, T1>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 102);
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

    // decompiled from Move bytecode v6
}

