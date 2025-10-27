module 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::cache {
    struct UpdateLiquidityCacheCap<phantom T0> {
        active_liquidity: vector<vector<u64>>,
        coin_types: vector<0x1::type_name::TypeName>,
        coin_type_index: u64,
        extensions: vector<0x1::type_name::TypeName>,
        extension_index: u64,
    }

    public fun account_for_extension_liquidity_of_type<T0, T1, T2: copy + drop + store>(arg0: &mut UpdateLiquidityCacheCap<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg2: &T2, arg3: u64) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        let v0 = &arg0.extensions;
        let v1 = arg0.extension_index;
        assert!(v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0) && *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1) == 0x1::type_name::with_defining_ids<T2>(), 0);
        let v2 = &arg0.coin_types;
        let v3 = arg0.coin_type_index;
        assert!(v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2) && *0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3) == 0x1::type_name::with_defining_ids<T1>(), 1);
        let v4 = &mut arg0.active_liquidity;
        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(v4, v3), v1) = arg3;
        let v5 = arg0.extension_index;
        let v6 = 0x1::vector::length<vector<u64>>(v4);
        let v7 = if (v6 > 0) {
            0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(v4, 0))
        } else {
            0
        };
        let v8;
        let v9;
        while (v5 < v7) {
            let v10 = if (v5 == v5) {
                arg0.coin_type_index + 1
            } else {
                0
            };
            let v11 = v10;
            while (v11 < v6) {
                if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(v4, v11), v5) > 0) {
                    v9 = v5;
                    v8 = v11;
                    /* label 26 */
                    arg0.coin_type_index = v8;
                    arg0.extension_index = v9;
                    return
                };
                v11 = v11 + 1;
            };
            v5 = v5 + 1;
        };
        v9 = v7;
        v8 = 0;
        /* goto 26 */
    }

    public fun begin_update_liquidity_cache_tx<T0>(arg0: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::Vault<T0>, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config) : UpdateLiquidityCacheCap<T0> {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg1);
        let (v0, v1, v2) = 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::begin_update_liquidity_cache_tx<T0>(0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::borrow<T0>(arg0));
        let v3 = v2;
        let v4 = &v3;
        let v5 = 0;
        let v6 = 0x1::vector::length<vector<u64>>(v4);
        let v7 = if (v6 > 0) {
            0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(v4, 0))
        } else {
            0
        };
        let v8;
        let v9;
        while (v5 < v7) {
            let v10 = if (v5 == v5) {
                0
            } else {
                0
            };
            let v11 = v10;
            while (v11 < v6) {
                if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v3, v11), v5) > 0) {
                    v9 = v5;
                    v8 = v11;
                    /* label 13 */
                    return UpdateLiquidityCacheCap<T0>{
                        active_liquidity : v3,
                        coin_types       : v0,
                        coin_type_index  : v8,
                        extensions       : v1,
                        extension_index  : v9,
                    }
                };
                v11 = v11 + 1;
            };
            v5 = v5 + 1;
        };
        v9 = v7;
        v8 = 0;
        /* goto 13 */
    }

    public(friend) fun destroy<T0>(arg0: UpdateLiquidityCacheCap<T0>) : vector<vector<u64>> {
        let UpdateLiquidityCacheCap {
            active_liquidity : v0,
            coin_types       : _,
            coin_type_index  : _,
            extensions       : v3,
            extension_index  : v4,
        } = arg0;
        let v5 = v3;
        assert!(v4 == 0x1::vector::length<0x1::type_name::TypeName>(&v5), 2);
        v0
    }

    public fun end_update_liquidity_cache_tx<T0>(arg0: &mut 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::Vault<T0>, arg1: UpdateLiquidityCacheCap<T0>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &0x2::clock::Clock) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::assert_package_version(arg2);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::state::end_update_liquidity_cache_tx<T0>(0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::borrow_mut<T0>(arg0), destroy<T0>(arg1), arg3);
    }

    // decompiled from Move bytecode v6
}

