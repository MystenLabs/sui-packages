module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist {
    struct AllowlistRule has drop {
        dummy_field: bool,
    }

    public fun confirm_transfer<T0>(arg0: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) {
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::assert_transferable(arg0, 0x1::type_name::get<T0>(), 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::get_transfer_request_auth<T0>(arg1));
        let v0 = AllowlistRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_receipt<T0, AllowlistRule>(arg1, v0);
    }

    public fun confirm_transfer_<T0, T1>(arg0: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>) {
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::assert_transferable(arg0, 0x1::type_name::get<T0>(), 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::get_transfer_request_auth_<T0, T1>(arg1));
        let v0 = AllowlistRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::add_receipt<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, AllowlistRule>(arg1, &v0);
    }

    public fun drop<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::remove_originbyte_rule<T0, AllowlistRule, bool>(arg0, arg1);
    }

    public fun drop_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, AllowlistRule>(arg0, arg1);
    }

    public entry fun enforce<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = AllowlistRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_originbyte_rule<T0, AllowlistRule, bool>(v0, arg0, arg1, false);
    }

    public entry fun enforce_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, AllowlistRule>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

