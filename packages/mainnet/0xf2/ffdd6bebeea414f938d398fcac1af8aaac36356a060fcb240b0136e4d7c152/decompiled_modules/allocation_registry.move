module 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry {
    struct AllocationRegistry has store, key {
        id: 0x2::object::UID,
        coin_infos: 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinInfo>,
    }

    struct AllocationRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinInfo has copy, drop, store {
        apy_bps: u64,
        apy_ema_bps: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (AllocationRegistry, AllocationRegistryCap) {
        let v0 = AllocationRegistry{
            id         : 0x2::object::new(arg0),
            coin_infos : 0x2::vec_map::empty<0x1::type_name::TypeName, CoinInfo>(),
        };
        let v1 = AllocationRegistryCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun apy_bps(arg0: &CoinInfo) : u64 {
        arg0.apy_bps
    }

    public fun apy_ema_bps(arg0: &CoinInfo) : u64 {
        arg0.apy_ema_bps
    }

    public fun coin_info<T0>(arg0: &AllocationRegistry) : CoinInfo {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, &v0), 1);
        *0x2::vec_map::get<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, &v0)
    }

    fun coin_types_by_lowest_apy(arg0: &AllocationRegistry) : vector<0x1::type_name::TypeName> {
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, CoinInfo>(arg0.coin_infos);
        let v2 = v1;
        let v3 = v0;
        let v4 = 1;
        while (v4 < 0x1::vector::length<CoinInfo>(&v2)) {
            while (v4 > 0 && 0x1::vector::borrow<CoinInfo>(&v2, v4 - 1).apy_bps > 0x1::vector::borrow<CoinInfo>(&v2, v4).apy_bps) {
                0x1::vector::swap<CoinInfo>(&mut v2, v4 - 1, v4);
                0x1::vector::swap<0x1::type_name::TypeName>(&mut v3, v4 - 1, v4);
                v4 = v4 - 1;
            };
            v4 = v4 + 1;
        };
        v3
    }

    public(friend) fun new_deallocations(arg0: &AllocationRegistry, arg1: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::Reserve, arg2: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::PriceCalculator, arg3: 0x1::type_name::TypeName, arg4: u64) : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::Deallocations {
        let v0 = coin_types_by_lowest_apy(arg0);
        let v1 = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::new();
        let v2 = arg4;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v0) && v2 > 0) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v3);
            let v5 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::usd_to_coin_amount(arg2, *v4, v2);
            let v6 = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::amount(arg1, *v4);
            if (v6 > 0) {
                if (v6 >= v5) {
                    v2 = 0;
                    0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::deallocate(&mut v1, *v4, v5, arg3 == *v4);
                } else {
                    v2 = v2 - 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::coin_amount_to_usd(arg2, *v4, v6);
                    0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::deallocate(&mut v1, *v4, v6, arg3 == *v4);
                };
            };
            v3 = v3 + 1;
        };
        assert!(v2 == 0, 0);
        v1
    }

    public(friend) fun update_coin_info<T0>(arg0: &AllocationRegistryCap, arg1: &mut AllocationRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 2);
        assert!(arg3 <= 10000, 2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, CoinInfo>(&arg1.coin_infos, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coin_infos, &v0);
        };
        let v3 = CoinInfo{
            apy_bps     : arg2,
            apy_ema_bps : arg3,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coin_infos, v0, v3);
    }

    // decompiled from Move bytecode v6
}

