module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::distribute {
    public fun can_distribute<T0, T1>(arg0: &0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (0x2::clock::timestamp_ms(arg1) < 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::last_tick<T0, T1>(arg0) + (0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::distribution_interval_hours<T0, T1>(arg0) as u64) * 3600000) {
            return false
        };
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::payout_balance<T0, T1>(arg0) > 0
    }

    public fun distribute_payout<T0, T1>(arg0: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, T1>, arg1: &0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_distribute_length_mismatch());
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 <= v1, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_snapshot_in_future());
        assert!(v1 - arg4 >= 30000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_snapshot_too_fresh());
        assert!(v1 - arg4 <= 600000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_snapshot_too_old());
        assert!(v1 >= 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::last_tick<T0, T1>(arg0) + (0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::distribution_interval_hours<T0, T1>(arg0) as u64) * 3600000, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_tick_cadence_locked());
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + (*0x1::vector::borrow<u64>(&arg3, v3) as u128);
            v3 = v3 + 1;
        };
        assert!(v2 <= (0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::payout_balance<T0, T1>(arg0) as u128), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_distribute_exceeds_pool());
        let v4 = (v2 as u64);
        let v5 = 0x2::coin::from_balance<T1>(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::take_payout<T0, T1>(arg0, v4), arg6);
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u64>(&arg3, v6);
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v5, v7, arg6), *0x1::vector::borrow<address>(&arg2, v6));
            };
            v6 = v6 + 1;
        };
        0x2::coin::destroy_zero<T1>(v5);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::set_last_tick<T0, T1>(arg0, v1);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::add_distributed<T0, T1>(arg0, v4);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_distribution(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_distribution_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), arg2, arg3, v4, arg4, v1));
    }

    public fun max_snapshot_age_ms() : u64 {
        600000
    }

    public fun min_snapshot_age_ms() : u64 {
        30000
    }

    public fun ms_per_hour() : u64 {
        3600000
    }

    // decompiled from Move bytecode v6
}

