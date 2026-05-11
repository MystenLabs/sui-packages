module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::swap_back {
    struct SwapBackTicket<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        amount_taken: u64,
    }

    public fun accrue<T0, T1>(arg0: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg2);
        if (v0 > 0) {
            0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::deposit_tax<T0, T1>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        if (v1 > 0) {
            0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::deposit_payout<T0, T1>(arg0, arg2);
        } else {
            0x2::balance::destroy_zero<T1>(arg2);
        };
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_accrual(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_accrual_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v1, v0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::payout_balance<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg3)));
    }

    public fun repay_swap_back<T0, T1>(arg0: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: SwapBackTicket<T0, T1>, arg3: &0x2::clock::Clock) {
        let SwapBackTicket {
            vault_id     : v0,
            amount_taken : v1,
        } = arg2;
        assert!(0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(arg0) == v0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_admin_unauthorized());
        let v2 = 0x2::balance::value<T1>(&arg1);
        if (v2 > 0) {
            0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::deposit_payout<T0, T1>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_accrual(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_accrual_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2, v1, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::payout_balance<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg3)));
    }

    public fun take_tax_for_conversion<T0, T1>(arg0: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>) : (0x2::balance::Balance<T0>, SwapBackTicket<T0, T1>) {
        let v0 = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::take_tax<T0, T1>(arg0);
        let v1 = SwapBackTicket<T0, T1>{
            vault_id     : 0x2::object::id<0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>>(arg0),
            amount_taken : 0x2::balance::value<T0>(&v0),
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

