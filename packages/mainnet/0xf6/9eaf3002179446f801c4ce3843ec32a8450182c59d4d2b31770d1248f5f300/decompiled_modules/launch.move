module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::launch {
    struct LaunchParams has copy, drop {
        bonding_curve_tax_bps: u16,
        payout_kind: u8,
        distribution_interval_hours: u16,
        graduation_market_cap_sui: u64,
    }

    struct LaunchSeal<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        bc_id: 0x2::object::ID,
    }

    public fun launch<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: LaunchParams, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::registry::LaunchpadRegistry, arg6: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::treasury::LaunchpadTreasury, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::BondingCurve<T0>, LaunchSeal<T0, T1>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 4000000000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_fee());
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::treasury::deposit(arg6, arg4);
        assert!(arg3 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_supply());
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let (v1, v2) = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::safeguards::compute_windows(v0);
        let v3 = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::new<T0>(0x2::coin::mint<T0>(&mut arg0, arg3, arg8), arg3, arg2.graduation_market_cap_sui, arg8);
        let v4 = 0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::BondingCurve<T0>>(&v3);
        let v5 = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::new<T0, T1>(arg2.bonding_curve_tax_bps, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule::post_graduation_tax_bps(), arg2.payout_kind, arg2.distribution_interval_hours, arg2.graduation_market_cap_sui, arg3, v0, v1, v2, arg3 / 100, arg8);
        let v6 = 0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(&v5);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::registry::register<T0>(arg5, 0x2::tx_context::sender(arg8), v6, v4, arg2.bonding_curve_tax_bps, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule::post_graduation_tax_bps(), arg2.graduation_market_cap_sui, arg2.payout_kind, arg2.distribution_interval_hours, arg3, arg7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        let v7 = LaunchSeal<T0, T1>{
            vault_id : v6,
            bc_id    : v4,
        };
        (v5, v3, v7)
    }

    public fun launch_fee_mist() : u64 {
        4000000000
    }

    public fun max_interval_hours() : u16 {
        8760
    }

    public fun min_graduation_mcap_sui() : u64 {
        1000000000
    }

    public fun new_params(arg0: u16, arg1: u8, arg2: u16, arg3: u64) : LaunchParams {
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule::assert_valid_tax_bps(arg0);
        assert!(arg1 <= 1, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_dial());
        assert!(arg2 >= 1, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_interval());
        assert!(arg2 <= 8760, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_interval());
        assert!(arg3 >= 1000000000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_launch_bad_mcap());
        LaunchParams{
            bonding_curve_tax_bps       : arg0,
            payout_kind                 : arg1,
            distribution_interval_hours : arg2,
            graduation_market_cap_sui   : arg3,
        }
    }

    public fun seal<T0, T1>(arg0: LaunchSeal<T0, T1>, arg1: 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg2: 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::BondingCurve<T0>) {
        let LaunchSeal {
            vault_id : v0,
            bc_id    : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(&arg1) == v3, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_admin_unauthorized());
        assert!(0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::BondingCurve<T0>>(&arg2) == v2, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_admin_unauthorized());
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_exempt<T0, T1>(&mut arg1, 0x2::object::id_to_address(&v2));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_exempt<T0, T1>(&mut arg1, 0x2::object::id_to_address(&v3));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::share<T0, T1>(arg1);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::share<T0>(arg2);
    }

    // decompiled from Move bytecode v6
}

