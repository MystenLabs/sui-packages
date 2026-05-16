module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::manifest_anchor {
    struct MilestoneManifestAnchored has copy, drop {
        order_id: 0x1::string::String,
        milestone_id: 0x1::string::String,
        manifest_cid: 0x1::string::String,
        manifest_sha256: 0x1::string::String,
        seller_address: address,
        seller_sig_hash: 0x1::string::String,
    }

    struct ManagedStorageFeePaid has copy, drop {
        order_id: 0x1::string::String,
        milestone_id: 0x1::string::String,
        payer_address: address,
        amount_atomic: u64,
        asset: 0x1::string::String,
        recipient_address: address,
    }

    public(friend) entry fun anchor_milestone_manifest(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_not_authorized());
        assert_non_empty_with_max(&arg1, 128);
        assert_non_empty_with_max(&arg2, 128);
        assert_non_empty_with_max(&arg3, 256);
        assert_hex_string(&arg4);
        assert_hex_string(&arg5);
        let v0 = MilestoneManifestAnchored{
            order_id        : arg1,
            milestone_id    : arg2,
            manifest_cid    : arg3,
            manifest_sha256 : arg4,
            seller_address  : arg0,
            seller_sig_hash : arg5,
        };
        0x2::event::emit<MilestoneManifestAnchored>(v0);
    }

    fun assert_hex_string(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 64 && is_lower_hex_ascii(v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_manifest_anchor_input());
    }

    fun assert_non_empty_with_max(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0 && v0 <= arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_manifest_anchor_input());
    }

    fun is_lower_hex_ascii(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = v1 >= 48 && v1 <= 57;
            let v3 = v1 >= 97 && v1 <= 102;
            if (!v2 && !v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) entry fun pay_managed_storage_fee_coin<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        pay_managed_storage_fee_typed_order_asset<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) entry fun pay_managed_storage_fee_sui(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        pay_managed_storage_fee_with_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"SUI"), arg4);
    }

    public(friend) entry fun pay_managed_storage_fee_typed_order_asset<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::is_supported_order_typed_non_sui_asset<T0>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_kind());
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_policy_kind<T0>() == 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::fee_policy_exact_typed_order_asset(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        pay_managed_storage_fee_with_coin<T0>(arg0, arg1, arg2, arg3, 0x1::string::utf8(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::exact_type_bytes_for<T0>()), arg4);
    }

    fun pay_managed_storage_fee_with_coin<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_non_empty_with_max(&arg0, 128);
        assert_non_empty_with_max(&arg1, 128);
        assert!(arg2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_address());
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg2);
        let v1 = ManagedStorageFeePaid{
            order_id          : arg0,
            milestone_id      : arg1,
            payer_address     : 0x2::tx_context::sender(arg5),
            amount_atomic     : v0,
            asset             : arg4,
            recipient_address : arg2,
        };
        0x2::event::emit<ManagedStorageFeePaid>(v1);
    }

    // decompiled from Move bytecode v7
}

