module 0x67df2b8d68d74dde4c289ee3bb1c8f5f4aeeb624880e48d46a9b78a2f9714d02::helper {
    public entry fun remove_lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(0x2::kiosk::owner(arg0), arg3);
        let v2 = v0;
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_signed<T0>(arg0, &mut v2, arg1, 0, arg3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_nothing_paid<T0>(&mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, 0x2::sui::SUI>(v3, arg2, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    // decompiled from Move bytecode v6
}

