module 0xa758d43692344544bbb27a31501eaf178a745d6bf2bc8e9f8e9d6dbde783b3b4::ocr3_base {
    struct UnvalidatedPublicKey has copy, drop, store {
        bytes: vector<u8>,
    }

    struct ConfigInfo has copy, drop, store {
        config_digest: vector<u8>,
        big_f: u8,
        n: u8,
        is_signature_verification_enabled: bool,
    }

    struct OCRConfig has copy, drop, store {
        config_info: ConfigInfo,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
    }

    struct OCR3BaseState has store, key {
        id: 0x2::object::UID,
        ocr3_configs: 0x2::table::Table<u8, OCRConfig>,
        signer_oracles: 0x2::table::Table<u8, vector<UnvalidatedPublicKey>>,
        transmitter_oracles: 0x2::table::Table<u8, vector<address>>,
    }

    struct ConfigSet has copy, drop {
        ocr_plugin_type: u8,
        config_digest: vector<u8>,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
        big_f: u8,
    }

    struct Transmitted has copy, drop {
        ocr_plugin_type: u8,
        config_digest: vector<u8>,
        sequence_number: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OCR3BaseState {
        OCR3BaseState{
            id                  : 0x2::object::new(arg0),
            ocr3_configs        : 0x2::table::new<u8, OCRConfig>(arg0),
            signer_oracles      : 0x2::table::new<u8, vector<UnvalidatedPublicKey>>(arg0),
            transmitter_oracles : 0x2::table::new<u8, vector<address>>(arg0),
        }
    }

    fun assign_signer_oracles(arg0: &mut 0x2::table::Table<u8, vector<UnvalidatedPublicKey>>, arg1: u8, arg2: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg2)) {
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address_vector(0x1::vector::borrow<vector<u8>>(arg2, v0));
            v0 = v0 + 1;
        };
        assert!(!has_duplicates<vector<u8>>(arg2), 8);
        let v1 = 0x1::vector::empty<UnvalidatedPublicKey>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg2, v2);
            let v4 = &mut v1;
            assert!(validate_public_key(v3), 13);
            let v5 = UnvalidatedPublicKey{bytes: *v3};
            0x1::vector::push_back<UnvalidatedPublicKey>(v4, v5);
            v2 = v2 + 1;
        };
        if (0x2::table::contains<u8, vector<UnvalidatedPublicKey>>(arg0, arg1)) {
            0x2::table::remove<u8, vector<UnvalidatedPublicKey>>(arg0, arg1);
        };
        0x2::table::add<u8, vector<UnvalidatedPublicKey>>(arg0, arg1, v1);
    }

    fun assign_transmitter_oracles(arg0: &mut 0x2::table::Table<u8, vector<address>>, arg1: u8, arg2: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg2)) {
            0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::address::assert_non_zero_address(*0x1::vector::borrow<address>(arg2, v0));
            v0 = v0 + 1;
        };
        assert!(!has_duplicates<address>(arg2), 9);
        if (0x2::table::contains<u8, vector<address>>(arg0, arg1)) {
            0x2::table::remove<u8, vector<address>>(arg0, arg1);
        };
        0x2::table::add<u8, vector<address>>(arg0, arg1, *arg2);
    }

    public(friend) fun config_signers(arg0: &OCRConfig) : vector<vector<u8>> {
        arg0.signers
    }

    public(friend) fun config_transmitters(arg0: &OCRConfig) : vector<address> {
        arg0.transmitters
    }

    public(friend) fun deserialize_sequence_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0;
        let v2 = v0 - 8;
        while (v2 < v0) {
            let v3 = v1 << 8;
            v1 = v3 + (*0x1::vector::borrow<u8>(&arg0, v2) as u64);
            v2 = v2 + 1;
        };
        v1
    }

    fun has_duplicates<T0>(arg0: &vector<T0>) : bool {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (0x1::vector::borrow<T0>(arg0, v1) == 0x1::vector::borrow<T0>(arg0, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    fun hash_report(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x2::hash::blake2b256(&arg0)
    }

    public(friend) fun latest_config_details(arg0: &OCR3BaseState, arg1: u8) : OCRConfig {
        assert!(0x2::table::contains<u8, OCRConfig>(&arg0.ocr3_configs, arg1), 20);
        *0x2::table::borrow<u8, OCRConfig>(&arg0.ocr3_configs, arg1)
    }

    public(friend) fun latest_config_details_fields(arg0: OCRConfig) : (vector<u8>, u8, u8, bool, vector<vector<u8>>, vector<address>) {
        (arg0.config_info.config_digest, arg0.config_info.big_f, arg0.config_info.n, arg0.config_info.is_signature_verification_enabled, arg0.signers, arg0.transmitters)
    }

    fun new_unvalidated_public_key_from_bytes(arg0: vector<u8>) : UnvalidatedPublicKey {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        UnvalidatedPublicKey{bytes: arg0}
    }

    public(friend) fun ocr_plugin_type_commit() : u8 {
        0
    }

    public(friend) fun ocr_plugin_type_execution() : u8 {
        1
    }

    public(friend) fun set_ocr3_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut OCR3BaseState, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: bool, arg6: vector<vector<u8>>, arg7: vector<address>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"ocr3_base"), 0x1::string::utf8(b"set_ocr3_config"), 1);
        assert!(arg4 != 0, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 14);
        let v0 = if (0x2::table::contains<u8, OCRConfig>(&arg1.ocr3_configs, arg3)) {
            0x2::table::borrow_mut<u8, OCRConfig>(&mut arg1.ocr3_configs, arg3)
        } else {
            let v1 = ConfigInfo{
                config_digest                     : b"",
                big_f                             : 0,
                n                                 : 0,
                is_signature_verification_enabled : false,
            };
            let v2 = OCRConfig{
                config_info  : v1,
                signers      : vector[],
                transmitters : vector[],
            };
            0x2::table::add<u8, OCRConfig>(&mut arg1.ocr3_configs, arg3, v2);
            0x2::table::borrow_mut<u8, OCRConfig>(&mut arg1.ocr3_configs, arg3)
        };
        let v3 = &mut v0.config_info;
        if (v3.big_f == 0) {
            v3.is_signature_verification_enabled = arg5;
        } else {
            assert!(v3.is_signature_verification_enabled == arg5, 3);
        };
        assert!(0x1::vector::length<address>(&arg7) <= 256, 6);
        assert!(0x1::vector::length<address>(&arg7) > 0, 7);
        if (arg5) {
            assert!(0x1::vector::length<vector<u8>>(&arg6) <= 256, 4);
            assert!(0x1::vector::length<vector<u8>>(&arg6) > 3 * (arg4 as u64), 5);
            assert!(0x1::vector::length<vector<u8>>(&arg6) >= 0x1::vector::length<address>(&arg7), 6);
            v3.n = (0x1::vector::length<vector<u8>>(&arg6) as u8);
            v0.signers = arg6;
            let v4 = &mut arg1.signer_oracles;
            assign_signer_oracles(v4, arg3, &arg6);
        };
        v0.transmitters = arg7;
        let v5 = &mut arg1.transmitter_oracles;
        assign_transmitter_oracles(v5, arg3, &arg7);
        v3.big_f = arg4;
        v3.config_digest = arg2;
        let v6 = ConfigSet{
            ocr_plugin_type : arg3,
            config_digest   : arg2,
            signers         : arg6,
            transmitters    : arg7,
            big_f           : arg4,
        };
        0x2::event::emit<ConfigSet>(v6);
    }

    fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg1 + arg2 <= 0x1::vector::length<T0>(arg0), 19);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public(friend) fun transmit(arg0: &OCR3BaseState, arg1: address, arg2: u8, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::tx_context::TxContext) {
        let v0 = latest_config_details(arg0, arg2);
        let v1 = &v0.config_info;
        let v2 = *0x1::vector::borrow<vector<u8>>(&arg3, 0);
        assert!(0x1::vector::length<u8>(&v2) == 32, 14);
        let v3 = *0x1::vector::borrow<vector<u8>>(&arg3, 1);
        assert!(0x1::vector::length<u8>(&v3) == 32, 15);
        assert!(v2 == v1.config_digest, 10);
        let v4 = *0x2::table::borrow<u8, vector<address>>(&arg0.transmitter_oracles, arg2);
        assert!(0x1::vector::contains<address>(&v4, &arg1), 11);
        if (v1.is_signature_verification_enabled) {
            assert!(0x1::vector::length<vector<u8>>(&arg5) == (v1.big_f as u64) + 1, 12);
            verify_signature(0x2::table::borrow<u8, vector<UnvalidatedPublicKey>>(&arg0.signer_oracles, arg2), hash_report(arg4, v2, v3), arg5);
        };
        let v5 = Transmitted{
            ocr_plugin_type : arg2,
            config_digest   : v2,
            sequence_number : deserialize_sequence_bytes(v3),
        };
        0x2::event::emit<Transmitted>(v5);
    }

    fun validate_public_key(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 32
    }

    fun verify_signature(arg0: &vector<UnvalidatedPublicKey>, arg1: vector<u8>, arg2: vector<vector<u8>>) {
        let v0 = 0x1::bit_vector::new(0x1::vector::length<UnvalidatedPublicKey>(arg0));
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(v1, v2);
            assert!(0x1::vector::length<u8>(v3) == 96, 21);
            let v4 = new_unvalidated_public_key_from_bytes(slice<u8>(v3, 0, 32));
            let (v5, v6) = 0x1::vector::index_of<UnvalidatedPublicKey>(arg0, &v4);
            assert!(v5, 16);
            assert!(!0x1::bit_vector::is_index_set(&v0, v6), 17);
            0x1::bit_vector::set(&mut v0, v6);
            let v7 = slice<u8>(v3, 32, 64);
            assert!(0x2::ed25519::ed25519_verify(&v7, &v4.bytes, &arg1), 18);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

