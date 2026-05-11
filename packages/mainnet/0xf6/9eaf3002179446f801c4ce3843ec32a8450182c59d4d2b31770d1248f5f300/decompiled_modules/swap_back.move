module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::swap_back {
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

    // decompiled from Move bytecode v6
}

