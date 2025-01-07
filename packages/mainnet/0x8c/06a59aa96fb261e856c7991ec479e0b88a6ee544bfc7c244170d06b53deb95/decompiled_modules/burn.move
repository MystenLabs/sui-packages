module 0x8c06a59aa96fb261e856c7991ec479e0b88a6ee544bfc7c244170d06b53deb95::burn {
    struct BurnRule has drop {
        dummy_field: bool,
    }

    struct BurnRequest has drop {
        nft_id: 0x2::object::ID,
    }

    struct Burnt has copy, drop {
        nft_id: 0x2::object::ID,
    }

    public fun add_ob_strategy<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>, BurnRule>(arg0, arg1);
    }

    public fun add_strategy<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = BurnRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, BurnRule, bool>(v0, arg0, arg1, true);
    }

    public fun confirm_burn<T0>(arg0: 0x2::object::UID, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::transfer_policy::item<T0>(arg1);
        let v1 = Burnt{nft_id: v0};
        0x2::event::emit<Burnt>(v1);
        assert!(v0 == 0x2::object::uid_to_inner(&arg0), 0);
        0x2::object::delete(arg0);
        let v2 = BurnRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, BurnRule>(v2, arg1);
    }

    public fun confirm_ob_burn<T0>(arg0: 0x2::object::UID, arg1: BurnRequest, arg2: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let BurnRequest { nft_id: v0 } = arg1;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0), 0);
        let v1 = Burnt{nft_id: v0};
        0x2::event::emit<Burnt>(v1);
        0x2::object::delete(arg0);
        let v2 = BurnRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<T0, BurnRule>(arg2, &v2);
    }

    public fun withdraw_nft_for_burning<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) : (BurnRequest, T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft<T0>(arg0, arg1, arg2, arg3);
        let v2 = BurnRequest{nft_id: arg1};
        (v2, v0, v1)
    }

    public fun withdraw_nft_signed_for_burning<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (BurnRequest, T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg0, arg1, arg2);
        let v2 = BurnRequest{nft_id: arg1};
        (v2, v0, v1)
    }

    // decompiled from Move bytecode v6
}

