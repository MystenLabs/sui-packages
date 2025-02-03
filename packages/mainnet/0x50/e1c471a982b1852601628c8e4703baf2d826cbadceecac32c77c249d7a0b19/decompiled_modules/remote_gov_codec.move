module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::remote_gov_codec {
    public fun decode_relayer_payload(arg0: vector<u8>) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, u8) {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        let v3 = v0 + v1;
        let v4 = (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u16(&v2) as u64);
        let v5 = v3 + v4;
        let v6 = 1;
        let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v5, v5 + v6);
        assert!(0x1::vector::length<u8>(&arg0) == v5 + v6, 1);
        (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::decode_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::vector_slice<u8>(&arg0, v3, v3 + v4)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::deserialize_u8(&v7))
    }

    public fun encode_relayer_payload(arg0: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::encode_dola_address(arg0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v1) as u16));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_vector(&mut v0, v1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::serde::serialize_u8(&mut v0, arg1);
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

