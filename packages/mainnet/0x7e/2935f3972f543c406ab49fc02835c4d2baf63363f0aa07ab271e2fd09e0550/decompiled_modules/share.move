module 0x7e2935f3972f543c406ab49fc02835c4d2baf63363f0aa07ab271e2fd09e0550::share {
    struct ShareInitializedEvent<phantom T0> has copy, drop {
        currency_id: address,
        treasury_cap_id: address,
        decimals: u8,
        supply: u64,
        fixed_supply: bool,
        metadata_cap_deleted: bool,
        regulated: bool,
    }

    fun has_share_type_name<T0>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::as_string(&v0));
        let v2 = b"::share::Share";
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0x1::vector::length<u8>(&v2);
        if (v3 < v4) {
            return false
        };
        let v5 = 0;
        while (v5 < v4) {
            if (*0x1::vector::borrow<u8>(v1, v3 - v4 + v5) != *0x1::vector::borrow<u8>(&v2, v5)) {
                return false
            };
            v5 = v5 + 1;
        };
        true
    }

    public fun initialize<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::coin::TreasuryCap<T0>) : 0x2::balance::Balance<T0> {
        let v0 = share_config_error<T0>(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            abort 0x1::option::destroy_some<u64>(v0)
        };
        0x1::option::destroy_none<u64>(v0);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1)), 5);
        assert!(0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(&mut arg1)) == 0, 0);
        0x2::coin_registry::make_supply_fixed<T0>(arg0, arg1);
        let v1 = ShareInitializedEvent<T0>{
            currency_id          : 0x2::object::id_address<0x2::coin_registry::Currency<T0>>(arg0),
            treasury_cap_id      : 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(&arg1),
            decimals             : 6,
            supply               : 100000000000000,
            fixed_supply         : 0x2::coin_registry::is_supply_fixed<T0>(arg0),
            metadata_cap_deleted : 0x2::coin_registry::is_metadata_cap_deleted<T0>(arg0),
            regulated            : 0x2::coin_registry::is_regulated<T0>(arg0),
        };
        0x2::event::emit<ShareInitializedEvent<T0>>(v1);
        0x2::coin::mint_balance<T0>(&mut arg1, 100000000000000)
    }

    public fun is_share<T0>(arg0: &0x2::coin_registry::Currency<T0>) : bool {
        if (0x2::coin_registry::is_supply_fixed<T0>(arg0)) {
            if (0x2::coin_registry::total_supply<T0>(arg0) == 0x1::option::some<u64>(100000000000000)) {
                let v1 = share_config_error<T0>(arg0);
                0x1::option::is_none<u64>(&v1)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun share_config_error<T0>(arg0: &0x2::coin_registry::Currency<T0>) : 0x1::option::Option<u64> {
        if (!has_share_type_name<T0>()) {
            return 0x1::option::some<u64>(2)
        };
        if (!0x2::coin_registry::is_metadata_cap_deleted<T0>(arg0)) {
            return 0x1::option::some<u64>(1)
        };
        if (0x2::coin_registry::is_regulated<T0>(arg0)) {
            return 0x1::option::some<u64>(4)
        };
        if (0x2::coin_registry::decimals<T0>(arg0) != 6) {
            return 0x1::option::some<u64>(3)
        };
        0x1::option::none<u64>()
    }

    // decompiled from Move bytecode v7
}

