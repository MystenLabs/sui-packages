module 0xa1e2abb70221d3ab6952544b0d731c319e7853e6b7698aa1921ca901b833c39a::share {
    struct ShareInitializedEvent has copy, drop {
        share_type: 0x1::type_name::TypeName,
        decimals: u8,
        supply: u64,
    }

    public fun assert_valid_share_type<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v0);
        let v2 = b"::share::Share";
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0;
        while (v4 < v3) {
            assert!(*0x1::vector::borrow<u8>(&v1, 0x1::vector::length<u8>(&v1) - v3 + v4) == *0x1::vector::borrow<u8>(&v2, v4), 2);
            v4 = v4 + 1;
        };
    }

    public fun initialize<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::coin::TreasuryCap<T0>) : 0x2::balance::Balance<T0> {
        assert_valid_share_type<T0>();
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg0), 1);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 4);
        assert!(0x2::coin_registry::decimals<T0>(arg0) == 6, 3);
        assert!(0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(&mut arg1)) == 0, 0);
        0x2::coin_registry::make_supply_fixed<T0>(arg0, arg1);
        let v0 = ShareInitializedEvent{
            share_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals   : 6,
            supply     : 10000000000000,
        };
        0x2::event::emit<ShareInitializedEvent>(v0);
        0x2::coin::mint_balance<T0>(&mut arg1, 10000000000000)
    }

    // decompiled from Move bytecode v7
}

