module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::remote_gov_codec {
    public fun decode_relayer_payload(arg0: vector<u8>) : (0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = (0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u16(&v2) as u64);
        let v5 = v3 + v4;
        let v6 = 1;
        let v7 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v5, v5 + v6);
        assert!(0x1::vector::length<u8>(&arg0) == v5 + v6, 1);
        (0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::decode_dola_address(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::vector_slice<u8>(&arg0, v3, v3 + v4)), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::deserialize_u8(&v7))
    }

    public fun encode_relayer_payload(arg0: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::encode_dola_address(arg0);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_vector(&mut v0, v1);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::serde::serialize_u8(&mut v0, arg1);
        v0
    }

    public fun get_add_relayer_opcode() : u8 {
        0
    }

    public fun get_remove_relayer_opcode() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

