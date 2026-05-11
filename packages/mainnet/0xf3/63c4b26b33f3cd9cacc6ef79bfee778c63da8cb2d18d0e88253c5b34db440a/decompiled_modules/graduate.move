module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::graduate {
    struct GraduationSeal<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
    }

    public fun graduate<T0, T1>(arg0: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::BondingCurve<T0>, arg1: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>, GraduationSeal<T0, T1>) {
        assert!(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::current_market_cap_sui<T0>(arg0) >= 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::graduation_market_cap_sui<T0, T1>(arg1), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_graduation_threshold_not_met());
        assert!(!0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::is_graduated<T0, T1>(arg1), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_already_graduated());
        let (v0, v1) = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve::seal_and_drain<T0>(arg0);
        let v2 = v1;
        let v3 = v0;
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::mark_graduated<T0, T1>(arg1);
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v4 = GraduationSeal<T0, T1>{vault_id: 0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(arg1)};
        (0x2::coin::from_balance<T0>(v3, arg3), 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), v4)
    }

    public fun seal_graduation<T0, T1>(arg0: GraduationSeal<T0, T1>, arg1: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let GraduationSeal { vault_id: v0 } = arg0;
        assert!(0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(arg1) == v0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_admin_unauthorized());
        let v1 = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::position_lock::new(arg2, arg7);
        let v2 = 0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::position_lock::LockedPosition>(&v1);
        let v3 = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::position_lock::pool_id(&v1);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::position_lock::share(v1);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_exempt<T0, T1>(arg1, 0x2::object::id_to_address(&v3));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_exempt<T0, T1>(arg1, 0x2::object::id_to_address(&arg3));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_exempt<T0, T1>(arg1, 0x2::object::id_to_address(&v2));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_graduation(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_graduation_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v3, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6)));
    }

    // decompiled from Move bytecode v6
}

