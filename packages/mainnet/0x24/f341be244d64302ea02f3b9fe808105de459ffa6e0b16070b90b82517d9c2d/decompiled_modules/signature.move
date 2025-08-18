module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature {
    struct PayloadKeys has copy, drop {
        field_name: vector<u8>,
        field_type: u8,
    }

    fun add_intent_bytes_and_hash(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg0));
        0x2::hash::blake2b256(&v0)
    }

    public fun build_signed_message(arg0: vector<u8>, arg1: vector<PayloadKeys>, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"7b0a20202274797065223a2022");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, x"222c0a");
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0;
        let v3 = 0x1::vector::length<PayloadKeys>(&arg1);
        while (v2 < v3) {
            let v4 = 0x1::vector::remove<PayloadKeys>(&mut arg1, 0);
            v2 = v2 + 1;
            let v5 = if (v4.field_type == 1) {
                let v6 = 0x1::string::utf8(b"0x");
                0x1::string::append(&mut v6, 0x2::address::to_string(0x2::bcs::peel_address(&mut v1)));
                0x1::string::into_bytes(v6)
            } else if (v4.field_type == 2) {
                0x2::bcs::peel_vec_u8(&mut v1)
            } else if (v4.field_type == 3) {
                0x1::string::into_bytes(0x1::u64::to_string(0x2::bcs::peel_u64(&mut v1)))
            } else {
                assert!(v4.field_type == 4, 2001);
                if (0x2::bcs::peel_bool(&mut v1)) {
                    b"true"
                } else {
                    b"false"
                }
            };
            let v7 = if (v2 == v3) {
                x"220a"
            } else {
                x"222c0a"
            };
            let v8 = v7;
            let v9 = b"\": \"";
            if (v4.field_type == 4) {
                0x1::vector::remove<u8>(&mut v8, 0);
                0x1::vector::pop_back<u8>(&mut v9);
            };
            0x1::vector::append<u8>(&mut v0, b"  \"");
            0x1::vector::append<u8>(&mut v0, v4.field_name);
            0x1::vector::append<u8>(&mut v0, v9);
            0x1::vector::append<u8>(&mut v0, v5);
            0x1::vector::append<u8>(&mut v0, v8);
        };
        0x1::vector::append<u8>(&mut v0, b"}");
        add_intent_bytes_and_hash(v0)
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        if (arg2 == b"Bluefin Pro Withdrawal") {
            verify_withdrawal_signature(arg0, arg1, arg2)
        } else if (arg2 == b"Bluefin Pro Order") {
            verify_order_signature(arg0, arg1, arg2)
        } else if (arg2 == b"Bluefin Pro Authorize Account") {
            verify_authorize_account_signature(arg0, arg1, arg2)
        } else if (arg2 == b"Bluefin Pro Margin Adjustment") {
            verify_adjust_margin_signature(arg0, arg1, arg2)
        } else if (arg2 == b"Bluefin Pro Leverage Adjustment") {
            verify_adjust_leverage_signature(arg0, arg1, arg2)
        } else if (arg2 == b"Bluefin Pro Close Position For Delisted Market") {
            verify_close_position_signature(arg0, arg1, arg2)
        } else {
            let v1 = if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_funding_rate()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_pruning_table()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_authorizing_liquidator()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_fee_tier()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_type()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_fee()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_pool()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_adl()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_liquidate()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_asset_update()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_position_update()) {
                true
            } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_user_authorized_accounts_update()) {
                true
            } else {
                arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_user_trade_fee_update()
            };
            assert!(v1, 2004);
            verify_bcs_serialized_payload_signature(arg0, arg1, arg2)
        }
    }

    public fun verify_adjust_leverage_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"ids",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"market",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"leverage",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    public fun verify_adjust_margin_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"ids",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"market",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"add",
            field_type : 4,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"amount",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        let v7 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v7);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    public fun verify_authorize_account_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"ids",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"user",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"status",
            field_type : 4,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    public fun verify_bcs_serialized_payload_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_funding_rate()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_pruning_table()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_authorizing_liquidator()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_fee_tier()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_type()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_fee()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_pool()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_adl()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_liquidate()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_asset_update()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_position_update()) {
            true
        } else if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_user_authorized_accounts_update()) {
            true
        } else {
            arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_tee_user_trade_fee_update()
        };
        assert!(v0, 2000);
        verify_signature_and_recover_signer(add_intent_bytes_and_hash(arg0), arg1)
    }

    public fun verify_close_position_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"ids",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"market",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"isolated",
            field_type : 4,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    public fun verify_liquidation_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        abort 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::deprecated_function()
    }

    public fun verify_order_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"ids",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"market",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"price",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"quantity",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"leverage",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        let v7 = PayloadKeys{
            field_name : b"side",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v7);
        let v8 = PayloadKeys{
            field_name : b"positionType",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v8);
        let v9 = PayloadKeys{
            field_name : b"expiration",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v9);
        let v10 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v10);
        let v11 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v11);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    public fun verify_signature_and_recover_signer(arg0: vector<u8>, arg1: vector<u8>) : address {
        let v0 = 0x1::vector::remove<u8>(&mut arg1, 0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        while (v3 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        let v4 = if (v0 == 0) {
            0x1::vector::insert<u8>(&mut v2, 0, 0);
            0x2::ed25519::ed25519_verify(&v1, &v2, &arg0)
        } else if (v0 == 1) {
            0x1::vector::insert<u8>(&mut v2, 1, 0);
            0x2::ecdsa_k1::secp256k1_verify(&v1, &v2, &arg0, 1)
        } else {
            assert!(v0 == 5, 2002);
            return @0x0
        };
        assert!(v4, 2003);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v2))
    }

    public fun verify_withdrawal_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<PayloadKeys>();
        let v1 = PayloadKeys{
            field_name : b"eds",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v1);
        let v2 = PayloadKeys{
            field_name : b"assetSymbol",
            field_type : 2,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v2);
        let v3 = PayloadKeys{
            field_name : b"account",
            field_type : 1,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v3);
        let v4 = PayloadKeys{
            field_name : b"amount",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v4);
        let v5 = PayloadKeys{
            field_name : b"salt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v5);
        let v6 = PayloadKeys{
            field_name : b"signedAt",
            field_type : 3,
        };
        0x1::vector::push_back<PayloadKeys>(&mut v0, v6);
        verify_signature_and_recover_signer(build_signed_message(arg2, v0, arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

