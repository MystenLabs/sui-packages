module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::system_codec {
    public fun decode_bind_payload(arg0: vector<u8>) : (u16, u64, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = 8;
        let v5 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v3, v3 + v4);
        let v6 = v3 + v4;
        let v7 = 2;
        let v8 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v6, v6 + v7);
        let v9 = v6 + v7;
        let v10 = (0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u16(&v8) as u64);
        let v11 = v9 + v10;
        let v12 = 1;
        let v13 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v11, v11 + v12);
        assert!(0x1::vector::length<u8>(&arg0) == v11 + v12, 0);
        (0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u16(&v2), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u64(&v5), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::decode_dola_address(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v9, v9 + v10)), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u8(&v13))
    }

    public fun encode_bind_payload(arg0: u16, arg1: u64, arg2: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg3: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u16(&mut v0, arg0);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u64(&mut v0, arg1);
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::encode_dola_address(arg2);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_vector(&mut v0, v1);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u8(&mut v0, arg3);
        v0
    }

    public fun get_binding_type() : u8 {
        0
    }

    public fun get_unbinding_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

