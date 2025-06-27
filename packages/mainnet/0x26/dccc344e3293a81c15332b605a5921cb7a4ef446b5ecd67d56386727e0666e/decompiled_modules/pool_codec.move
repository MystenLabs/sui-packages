module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec {
    public fun decode_deposit_payload(arg0: vector<u8>) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, u64, u16, u8, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0;
        let v2 = 2;
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v1, v1 + v2);
        let v4 = v1 + v2;
        let v5 = 2;
        let v6 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v4, v4 + v5);
        let v7 = v4 + v5;
        let v8 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v6) as u64);
        let v9 = v7 + v8;
        let v10 = 2;
        let v11 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v9, v9 + v10);
        let v12 = v9 + v10;
        let v13 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v11) as u64);
        let v14 = v12 + v13;
        let v15 = 8;
        let v16 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v14, v14 + v15);
        let v17 = v14 + v15;
        let v18 = 1;
        let v19 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v17, v17 + v18);
        let v20 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u8(&v19);
        let v21 = v17 + v18;
        let v22 = v21;
        let v23 = 0x1::vector::empty<u8>();
        if (v0 > v21) {
            let v24 = 2;
            let v25 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v21, v21 + v24);
            let v26 = v21 + v24;
            let v27 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v25) as u64);
            v23 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v26, v26 + v27);
            v22 = v26 + v27;
        };
        assert!(v20 == 0, 1);
        assert!(v0 == v22, 0);
        (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v7, v7 + v8)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v12, v12 + v13)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u64(&v16), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v3), v20, v23)
    }

    public fun decode_manage_pool_payload(arg0: vector<u8>) : (u16, u256, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 32;
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 1;
        let v8 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        assert!(0x1::vector::length<u8>(&arg0) == v6 + v7, 0);
        (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u256(&v5), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u8(&v8))
    }

    public fun decode_send_message_payload(arg0: vector<u8>) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, u16, u8, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0;
        let v2 = 2;
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v1, v1 + v2);
        let v4 = v1 + v2;
        let v5 = 2;
        let v6 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v4, v4 + v5);
        let v7 = v4 + v5;
        let v8 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v6) as u64);
        let v9 = v7 + v8;
        let v10 = 1;
        let v11 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v9, v9 + v10);
        let v12 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u8(&v11);
        let v13 = v9 + v10;
        let v14 = v13;
        let v15 = 0x1::vector::empty<u8>();
        if (v0 > v13) {
            let v16 = 2;
            let v17 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v13, v13 + v16);
            let v18 = v13 + v16;
            let v19 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v17) as u64);
            v15 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v18, v18 + v19);
            v14 = v18 + v19;
        };
        assert!(v12 == 2, 1);
        assert!(v0 == v14, 0);
        (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v7, v7 + v8)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v3), v12, v15)
    }

    public fun decode_withdraw_payload(arg0: vector<u8>) : (u16, u64, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, u64, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v8) as u64);
        let v11 = v9 + v10;
        let v12 = 2;
        let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v11, v11 + v12);
        let v14 = v11 + v12;
        let v15 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v13) as u64);
        let v16 = v14 + v15;
        let v17 = 8;
        let v18 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v16, v16 + v17);
        let v19 = v16 + v17;
        let v20 = 1;
        let v21 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v19, v19 + v20);
        let v22 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u8(&v21);
        assert!(v22 == 1, 1);
        assert!(0x1::vector::length<u8>(&arg0) == v19 + v20, 0);
        (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u64(&v5), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v9, v9 + v10)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v14, v14 + v15)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u64(&v18), v22)
    }

    public fun encode_deposit_payload(arg0: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg1: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg2: u64, arg3: u16, arg4: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, arg3);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v1);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v2) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u64(&mut v0, arg2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u8(&mut v0, 0);
        if (0x1::vector::length<u8>(&arg4) > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&arg4) as u16));
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, arg4);
        };
        v0
    }

    public fun encode_manage_pool_payload(arg0: u16, arg1: u256, arg2: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, arg0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u256(&mut v0, arg1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u8(&mut v0, arg2);
        v0
    }

    public fun encode_send_message_payload(arg0: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg1: u16, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, arg1);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u8(&mut v0, 2);
        if (0x1::vector::length<u8>(&arg2) > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&arg2) as u16));
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, arg2);
        };
        v0
    }

    public fun encode_withdraw_payload(arg0: u16, arg1: u64, arg2: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg3: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, arg0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u64(&mut v0, arg1);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v1);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg3);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v2) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u64(&mut v0, arg4);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u8(&mut v0, 1);
        v0
    }

    public fun get_delete_owner_type() : u8 {
        5
    }

    public fun get_delete_spender_type() : u8 {
        6
    }

    public fun get_deposit_type() : u8 {
        0
    }

    public fun get_register_owner_type() : u8 {
        3
    }

    public fun get_register_spender_type() : u8 {
        4
    }

    public fun get_send_message_type() : u8 {
        2
    }

    public fun get_withdraw_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

