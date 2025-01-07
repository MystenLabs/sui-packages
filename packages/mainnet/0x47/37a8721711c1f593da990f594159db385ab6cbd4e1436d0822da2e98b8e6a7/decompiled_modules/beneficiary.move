module 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::is_emergency(arg0), 302);
        assert!(0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::get_mut_pool<T0, T1>(arg0, 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::event::withdrew_event(0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::global_id<T0, T1>(v0), 0x4737a8721711c1f593da990f594159db385ab6cbd4e1436d0822da2e98b8e6a7::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

