module 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation {
    public fun assert_content_sha256(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2001);
    }

    public fun assert_valid_role(arg0: u8) {
        assert!(is_valid_role(arg0), 2002);
    }

    public fun attestation_bytes(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u8, arg6: u64) : vector<u8> {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 2003);
        assert_content_sha256(&arg3);
        assert_valid_role(arg5);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        let v1 = &mut v0;
        push_length_prefixed(v1, b"DECOT/ATTESTATION/v1");
        let v2 = &mut v0;
        push_length_prefixed(v2, arg0);
        let v3 = &mut v0;
        push_length_prefixed(v3, arg1);
        let v4 = &mut v0;
        push_length_prefixed(v4, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        0x1::vector::push_back<u8>(&mut v0, arg5);
        let v5 = &mut v0;
        push_u64_be(v5, arg6);
        v0
    }

    public fun attestation_digest(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u8, arg6: u64) : vector<u8> {
        0x1::hash::sha2_256(attestation_bytes(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    public fun commitment_version() : u8 {
        1
    }

    public fun document_bytes(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 2003);
        assert_content_sha256(&arg3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        let v1 = &mut v0;
        push_length_prefixed(v1, b"DECOT/DOCUMENT/v1");
        let v2 = &mut v0;
        push_length_prefixed(v2, arg0);
        let v3 = &mut v0;
        push_length_prefixed(v3, arg1);
        let v4 = &mut v0;
        push_length_prefixed(v4, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        v0
    }

    public fun document_digest(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(document_bytes(arg0, arg1, arg2, arg3))
    }

    public fun domain_attestation() : vector<u8> {
        b"DECOT/ATTESTATION/v1"
    }

    public fun domain_document() : vector<u8> {
        b"DECOT/DOCUMENT/v1"
    }

    public fun is_valid_role(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun push_length_prefixed(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 <= 1024, 2004);
        push_u32_be(arg0, v0);
        0x1::vector::append<u8>(arg0, arg1);
    }

    fun push_u32_be(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 4;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v1 & 255) as u8));
        };
    }

    fun push_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 8;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v1 & 255) as u8));
        };
    }

    public fun role_agent() : u8 {
        2
    }

    public fun role_customer() : u8 {
        1
    }

    public fun role_system() : u8 {
        4
    }

    public fun role_witness() : u8 {
        3
    }

    // decompiled from Move bytecode v7
}

