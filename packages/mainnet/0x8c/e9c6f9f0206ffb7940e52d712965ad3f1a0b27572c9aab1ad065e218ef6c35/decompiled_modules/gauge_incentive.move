module 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_incentive {
    struct AddIncentiveEvent<phantom T0> has copy, drop, store {
        gauge_id: address,
        user: address,
        timestamp: u64,
        amount: u64,
    }

    public fun add_incentive<T0>(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        let (_, v1, v2, _) = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_fields(arg0);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::get_gauge_not_paused(v2, &arg1);
        let (v6, v7) = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::coin_xy(v5);
        let v8 = if (v4 == v6) {
            true
        } else if (v4 == v7) {
            true
        } else {
            0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::is_whitelisted_incentive(v2, &v4)
        };
        assert!(v8, 0);
        let v9 = 0x2::clock::timestamp_ms(arg3);
        let v10 = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::epoch_id(v1, v9);
        assert!(v10 == 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::current_epoch_id(v5), 1);
        assert!(v9 >= 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::epoch_start(v1, v10) && v9 <= 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::epoch_finale_start(v1, v10), 2);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::add_incentive<T0>(v5, arg2);
        let v11 = AddIncentiveEvent<T0>{
            gauge_id  : arg1,
            user      : 0x2::tx_context::sender(arg4),
            timestamp : v9,
            amount    : 0x2::balance::value<T0>(&arg2),
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<AddIncentiveEvent<T0>>(v11);
    }

    // decompiled from Move bytecode v6
}

