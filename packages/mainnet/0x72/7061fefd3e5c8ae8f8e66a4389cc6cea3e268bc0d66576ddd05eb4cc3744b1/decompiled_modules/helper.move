module 0x727061fefd3e5c8ae8f8e66a4389cc6cea3e268bc0d66576ddd05eb4cc3744b1::helper {
    public entry fun remove_lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg4: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(0x2::kiosk::owner(arg0), arg5);
        let v2 = v0;
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_signed<T0>(arg0, &mut v2, arg1, 0, arg5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg3, &mut v3);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, 0x2::sui::SUI>(arg4, &mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, 0x2::sui::SUI>(v3, arg2, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    // decompiled from Move bytecode v6
}

