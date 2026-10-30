module 0xe78e0aca82c949b270bce3c581484dc2528968bb53c0cc53fcab6b125b99ab39::share {
    fun is_type<T0: key>(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x1::vector::append<u8>(&mut v1, b"::");
        0x1::vector::append<u8>(&mut v1, arg0);
        0x1::vector::append<u8>(&mut v1, b"::");
        0x1::vector::append<u8>(&mut v1, arg1);
        let v2 = 0x1::ascii::string(v1);
        0x1::type_name::as_string(&v0) == &v2
    }

    public fun mint<T0: key>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64) : 0x2::balance::Balance<T0> {
        assert!(arg9 > 0, 10);
        assert!(is_type<T0>(arg2, arg3), 0);
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg0), 1);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 2);
        assert!(0x2::coin_registry::decimals<T0>(arg0) == arg4, 3);
        assert!(0x2::coin_registry::name<T0>(arg0) == arg6, 4);
        assert!(0x2::coin_registry::symbol<T0>(arg0) == arg5, 5);
        assert!(0x2::coin_registry::description<T0>(arg0) == arg7, 6);
        assert!(0x2::coin_registry::icon_url<T0>(arg0) == arg8, 7);
        let v0 = 0x2::coin_registry::total_supply<T0>(arg0);
        assert!(0x1::option::is_none<u64>(&v0), 11);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1)), 8);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 9);
        0x2::coin_registry::make_supply_fixed<T0>(arg0, arg1);
        0x2::coin::mint_balance<T0>(&mut arg1, arg9)
    }

    // decompiled from Move bytecode v7
}

