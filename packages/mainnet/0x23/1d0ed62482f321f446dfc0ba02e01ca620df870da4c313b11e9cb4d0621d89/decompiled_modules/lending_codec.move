module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec {
    public fun decode_claim_reward_payload(arg0: vector<u8>) : (u16, u64, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u16, u8, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v8) as u64);
        let v11 = v9 + v10;
        let v12 = 2;
        let v13 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v11, v11 + v12);
        let v14 = v11 + v12;
        let v15 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v13) as u64);
        let v16 = v14 + v15;
        let v17 = 2;
        let v18 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v16, v16 + v17);
        let v19 = v16 + v17;
        let v20 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v18) as u64);
        let v21 = v19 + v20;
        let v22 = 2;
        let v23 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v21, v21 + v22);
        let v24 = v21 + v22;
        let v25 = 1;
        let v26 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v24, v24 + v25);
        let v27 = v24 + v25;
        let v28 = 1;
        let v29 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v27, v27 + v28);
        assert!(v27 + v28 == 0x1::vector::length<u8>(&arg0), 0);
        (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v5), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v9, v9 + v10)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v14, v14 + v15)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v19, v19 + v20)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v23), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v26), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v29))
    }

    public fun decode_deposit_payload(arg0: vector<u8>) : (u16, u64, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v8) as u64);
        let v11 = v9 + v10;
        let v12 = 1;
        let v13 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v11, v11 + v12);
        assert!(v11 + v12 == 0x1::vector::length<u8>(&arg0), 0);
        (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v5), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v9, v9 + v10)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v13))
    }

    public fun decode_liquidate_payload(arg0: vector<u8>) : (u16, u64, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v8) as u64);
        let v11 = v9 + v10;
        let v12 = 8;
        let v13 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v11, v11 + v12);
        let v14 = v11 + v12;
        let v15 = 1;
        let v16 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v14, v14 + v15);
        let v17 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v16);
        assert!(v17 == 4, 1);
        assert!(v14 + v15 == 0x1::vector::length<u8>(&arg0), 0);
        (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v5), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v9, v9 + v10)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v13), v17)
    }

    public fun decode_liquidate_payload_v2(arg0: vector<u8>) : (u16, u64, u16, u64, u16, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = 8;
        let v11 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v9, v9 + v10);
        let v12 = v9 + v10;
        let v13 = 2;
        let v14 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v12, v12 + v13);
        let v15 = v12 + v13;
        let v16 = 1;
        let v17 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v15, v15 + v16);
        let v18 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v17);
        assert!(v18 == 4, 1);
        assert!(v15 + v16 == 0x1::vector::length<u8>(&arg0), 0);
        (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v5), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v8), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v11), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v14), v18)
    }

    public fun decode_manage_collateral_payload(arg0: vector<u8>) : (vector<u16>, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 0;
        let v5 = 0x1::vector::empty<u16>();
        while (v4 < 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2)) {
            let v6 = 2;
            let v7 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v6);
            0x1::vector::push_back<u16>(&mut v5, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v7));
            v3 = v3 + v6;
            v4 = v4 + 1;
        };
        let v8 = 1;
        let v9 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v8);
        assert!(v3 + v8 == 0x1::vector::length<u8>(&arg0), 0);
        (v5, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v9))
    }

    public fun decode_withdraw_payload(arg0: vector<u8>) : (u16, u64, u64, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 8;
        let v8 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = 2;
        let v11 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v9, v9 + v10);
        let v12 = v9 + v10;
        let v13 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v11) as u64);
        let v14 = v12 + v13;
        let v15 = 2;
        let v16 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v14, v14 + v15);
        let v17 = v14 + v15;
        let v18 = (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v16) as u64);
        let v19 = v17 + v18;
        let v20 = 1;
        let v21 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v19, v19 + v20);
        assert!(v19 + v20 == 0x1::vector::length<u8>(&arg0), 0);
        (0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u16(&v2), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v5), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u64(&v8), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v12, v12 + v13)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::decode_dola_address(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::vector_slice<u8>(&arg0, v17, v17 + v18)), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::deserialize_u8(&v21))
    }

    public fun encode_claim_reward_payload(arg0: u16, arg1: u64, arg2: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg3: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg4: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg5: u16, arg6: u8, arg7: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg1);
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v1);
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg3);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v2) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v2);
        let v3 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg4);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v3) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v3);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg5);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, arg6);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, arg7);
        v0
    }

    public fun encode_deposit_payload(arg0: u16, arg1: u64, arg2: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg3: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg1);
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, arg3);
        v0
    }

    public fun encode_liquidate_payload(arg0: u16, arg1: u64, arg2: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg1);
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg3);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, 4);
        v0
    }

    public fun encode_liquidate_payload_v2(arg0: u16, arg1: u64, arg2: u16, arg3: u64, arg4: u16) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg3);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg4);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, 4);
        v0
    }

    public fun encode_manage_collateral_payload(arg0: vector<u16>, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u16>(&arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (v1 as u16));
        let v2 = 0;
        while (v2 < v1) {
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, *0x1::vector::borrow<u16>(&arg0, v2));
            v2 = v2 + 1;
        };
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, arg1);
        v0
    }

    public fun encode_withdraw_payload(arg0: u16, arg1: u64, arg2: u64, arg3: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg4: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg5: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, arg0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u64(&mut v0, arg2);
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg3);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v1);
        let v2 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::encode_dola_address(arg4);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v2) as u16));
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_vector(&mut v0, v2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::serde::serialize_u8(&mut v0, arg5);
        v0
    }

    public fun get_as_colleteral_type() : u8 {
        5
    }

    public fun get_borrow_type() : u8 {
        2
    }

    public fun get_cancel_as_colleteral_type() : u8 {
        6
    }

    public fun get_claim_reward_type() : u8 {
        8
    }

    public fun get_liquidate_type() : u8 {
        4
    }

    public fun get_repay_type() : u8 {
        3
    }

    public fun get_sponsor_type() : u8 {
        7
    }

    public fun get_supply_type() : u8 {
        0
    }

    public fun get_withdraw_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

