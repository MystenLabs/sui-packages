module 0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper {
    fun cmp_type_names(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : u8 {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg1));
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0;
        while (v4 < 0x11f6d9808d4cbf6fa8b06b9bc1dc470c6924abdb0b43d5aff8fc7139bcdbae91::math::min_u64(v2, v3)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v4);
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            if (v5 < v6) {
                return 0
            };
            if (v5 > v6) {
                return 2
            };
            v4 = v4 + 1;
        };
        if (v2 == v3) {
            return 1
        };
        if (v2 < v3) {
            0
        } else {
            2
        }
    }

    public fun create_vector(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        if (0x1::option::is_some<u64>(&arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::option::extract<u64>(&mut arg0));
        };
        if (0x1::option::is_some<u64>(&arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::option::extract<u64>(&mut arg1));
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::option::extract<u64>(&mut arg2));
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::option::extract<u64>(&mut arg3));
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::option::extract<u64>(&mut arg4));
        };
        v0
    }

    public fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_asset_index_and_amount(arg0: vector<u64>) : (u64, u64, bool) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0, v2);
            if (v3 > 0) {
                v0 = v3;
                let v4 = v1 + 1;
                v1 = v4;
                if (v4 > 1) {
                    return (0, 0, true)
                };
            };
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            return (v0, 0, false)
        };
        (0, 0, true)
    }

    public fun get_index_asset_precision2Pool(arg0: u8, arg1: u8, arg2: u64) : (u8, bool) {
        if (arg2 == 0) {
            return (arg0, false)
        };
        if (arg2 == 1) {
            return (arg1, false)
        };
        (0, true)
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = cmp_type_names(&v0, &v1);
        assert!(v2 != 1, 3000);
        v2 == 0
    }

    public fun is_sorted_2<T0, T1>() : bool {
        is_sorted<T0, T1>()
    }

    public fun is_sorted_3<T0, T1, T2>() : bool {
        is_sorted<T0, T1>() && is_sorted<T1, T2>()
    }

    public fun is_sorted_4<T0, T1, T2, T3>() : bool {
        if (is_sorted<T0, T1>()) {
            if (is_sorted<T1, T2>()) {
                is_sorted<T2, T3>()
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_sorted_5<T0, T1, T2, T3, T4>() : bool {
        if (is_sorted<T0, T1>()) {
            if (is_sorted<T1, T2>()) {
                if (is_sorted<T2, T3>()) {
                    is_sorted<T3, T4>()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun valid_curved_coins_2_pool<T0, T1>() : bool {
        is_sorted<T0, T1>()
    }

    // decompiled from Move bytecode v6
}

