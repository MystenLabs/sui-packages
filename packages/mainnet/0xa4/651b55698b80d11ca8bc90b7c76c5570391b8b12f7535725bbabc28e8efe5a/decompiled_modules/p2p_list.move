module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::p2p_list {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct P2PListRule has drop {
        dummy_field: bool,
    }

    public fun transfer<T0: store + key>(arg0: &0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_signed<T0>(arg3, arg4, arg2, 0, arg7);
        let v1 = &mut v0;
        confirm_transfer_<T0>(arg0, v1, arg1, arg2, arg6, arg5, 0x2::kiosk::owner(arg3), 0x2::kiosk::owner(arg4), arg7);
        v0
    }

    fun confirm_<T0>(arg0: &0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: vector<u8>, arg6: &vector<u8>, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg4));
        let v1 = 0x2::tx_context::epoch(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, arg5);
        0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::assert_transferable(arg0, 0x1::type_name::get<T0>(), arg1, &v0, arg6);
    }

    fun confirm_transfer_<T0>(arg0: &0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg2: &vector<u8>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &vector<u8>, arg6: address, arg7: address, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(arg1, &v0);
        confirm_<T0>(arg0, arg2, arg3, arg6, arg7, arg4, arg5, arg8);
        let v1 = P2PListRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_receipt<T0, P2PListRule>(arg1, v1);
    }

    public fun drop<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::remove_originbyte_rule<T0, P2PListRule, bool>(arg0, arg1);
    }

    public fun drop_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, P2PListRule>(arg0, arg1);
    }

    public entry fun enforce<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = P2PListRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_originbyte_rule<T0, P2PListRule, bool>(v0, arg0, arg1, false);
    }

    public entry fun enforce_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, P2PListRule>(arg0, arg1);
    }

    public fun transfer_into_new_kiosk<T0: store + key>(arg0: &0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: address, arg5: &vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg4, arg7);
        let v2 = v0;
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_signed<T0>(arg3, &mut v2, arg2, 0, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        let v4 = &mut v3;
        confirm_transfer_<T0>(arg0, v4, arg1, arg2, arg6, arg5, 0x2::kiosk::owner(arg3), arg4, arg7);
        v3
    }

    // decompiled from Move bytecode v6
}

