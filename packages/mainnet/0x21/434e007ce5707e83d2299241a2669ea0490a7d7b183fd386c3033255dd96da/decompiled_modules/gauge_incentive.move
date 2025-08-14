module 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge_incentive {
    struct AddIncentiveEvent<phantom T0> has copy, drop, store {
        gauge_id: address,
        user: address,
        timestamp: u64,
        amount: u64,
    }

    public fun add_incentive<T0>(arg0: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::ve_mmt::VeMMT, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::ve_mmt::assert_supported_version(arg0);
        let (_, v1, v2, _) = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::ve_mmt::gauge_fields(arg0);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge_globals::get_gauge_not_paused(v2, &arg1);
        let (v6, v7) = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::coin_xy(v5);
        let v8 = if (v4 == v6) {
            true
        } else if (v4 == v7) {
            true
        } else {
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge_globals::is_whitelisted_incentive(v2, &v4)
        };
        assert!(v8, 0);
        let v9 = 0x2::clock::timestamp_ms(arg3);
        let v10 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::epoch_id(v1, v9);
        assert!(v10 == 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::current_epoch_id(v5), 1);
        assert!(v9 >= 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::epoch_start(v1, v10) && v9 <= 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::epoch_finale_start(v1, v10), 2);
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::add_incentive<T0>(v5, arg2);
        let v11 = AddIncentiveEvent<T0>{
            gauge_id  : arg1,
            user      : 0x2::tx_context::sender(arg4),
            timestamp : v9,
            amount    : 0x2::balance::value<T0>(&arg2),
        };
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::event::emit<AddIncentiveEvent<T0>>(v11);
    }

    // decompiled from Move bytecode v6
}

