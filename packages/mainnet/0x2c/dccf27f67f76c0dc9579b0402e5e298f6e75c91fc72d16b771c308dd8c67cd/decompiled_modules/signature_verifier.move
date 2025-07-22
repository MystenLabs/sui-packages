module 0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::signature_verifier {
    struct SignatureConfig has store {
        require_signature: bool,
        backend_public_key: vector<u8>,
        used_nonces: 0x2::table::Table<u64, u64>,
    }

    fun address_to_string(arg0: address) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, bytes_to_hex_string(0x2::address::to_bytes(arg0)));
        v0
    }

    public fun admin_cleanup_expired_nonces(arg0: &mut SignatureConfig, arg1: vector<u64>, arg2: u64, arg3: &0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::admin::DropkitAdminCap) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            if (admin_remove_expired_nonce(arg0, *0x1::vector::borrow<u64>(&arg1, v1), arg2, arg3)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun admin_remove_expired_nonce(arg0: &mut SignatureConfig, arg1: u64, arg2: u64, arg3: &0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::admin::DropkitAdminCap) : bool {
        if (0x2::table::contains<u64, u64>(&arg0.used_nonces, arg1)) {
            if (*0x2::table::borrow<u64, u64>(&arg0.used_nonces, arg1) + 3600000 < arg2) {
                0x2::table::remove<u64, u64>(&mut arg0.used_nonces, arg1);
                true
            } else {
                false
            }
        } else {
            false
        }
    }

    fun bytes_to_hex_string(arg0: vector<u8>) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 4 & 15) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 & 15) as u64)));
            v2 = v2 + 1;
        };
        v1
    }

    fun create_domain_separated_message(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: address) : vector<u8> {
        let v0 = b"user=";
        0x1::vector::append<u8>(&mut v0, address_to_string(arg0));
        0x1::vector::append<u8>(&mut v0, b":nonce=");
        0x1::vector::append<u8>(&mut v0, u64_to_string(arg1));
        0x1::vector::append<u8>(&mut v0, b":expiry=");
        0x1::vector::append<u8>(&mut v0, u64_to_string(arg2));
        0x1::vector::append<u8>(&mut v0, b":amount=");
        0x1::vector::append<u8>(&mut v0, u64_to_string(arg3));
        0x1::vector::append<u8>(&mut v0, b":curve=");
        0x1::vector::append<u8>(&mut v0, address_to_string(arg4));
        v0
    }

    public fun get_backend_public_key(arg0: &SignatureConfig) : vector<u8> {
        arg0.backend_public_key
    }

    public fun get_used_nonces_count(arg0: &SignatureConfig) : u64 {
        0x2::table::length<u64, u64>(&arg0.used_nonces)
    }

    public fun is_nonce_used(arg0: &SignatureConfig, arg1: u64) : bool {
        0x2::table::contains<u64, u64>(&arg0.used_nonces, arg1)
    }

    public fun new_signature_config(arg0: bool, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : SignatureConfig {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 12);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        SignatureConfig{
            require_signature  : arg0,
            backend_public_key : arg1,
            used_nonces        : 0x2::table::new<u64, u64>(arg2),
        }
    }

    public fun requires_signature(arg0: &SignatureConfig) : bool {
        arg0.require_signature
    }

    public fun set_signature_requirement(arg0: &mut SignatureConfig, arg1: bool, arg2: vector<u8>, arg3: &0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::admin::DropkitAdminCap) {
        if (arg1) {
            assert!(!0x1::vector::is_empty<u8>(&arg2), 12);
            assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        };
        arg0.require_signature = arg1;
        arg0.backend_public_key = arg2;
    }

    fun u64_to_string(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun update_backend_public_key(arg0: &mut SignatureConfig, arg1: vector<u8>, arg2: &0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::admin::DropkitAdminCap) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 12);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        arg0.backend_public_key = arg1;
    }

    public fun verify_signature(arg0: &mut SignatureConfig, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: address) {
        if (!arg0.require_signature) {
            return
        };
        assert!(arg2 != 0, 8);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 7);
        assert!(0x1::vector::length<u8>(&arg5) == 64, 6);
        assert!(!0x1::vector::is_empty<u8>(&arg0.backend_public_key), 12);
        assert!(0x1::vector::length<u8>(&arg0.backend_public_key) == 32, 5);
        assert!(arg3 != 0, 11);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg3, 2);
        assert!(!0x2::table::contains<u64, u64>(&arg0.used_nonces, arg2), 3);
        let v0 = create_domain_separated_message(arg1, arg2, arg3, arg4, arg7);
        assert!(!0x1::vector::is_empty<u8>(&v0), 9);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.backend_public_key, &v0), 10);
        0x2::table::add<u64, u64>(&mut arg0.used_nonces, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

