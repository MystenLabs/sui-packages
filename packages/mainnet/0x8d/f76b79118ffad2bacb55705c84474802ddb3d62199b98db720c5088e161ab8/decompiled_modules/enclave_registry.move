module 0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry {
    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
        pos3: vector<u8>,
    }

    struct EnclaveRegistered has copy, drop {
        pk: vector<u8>,
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
        pcr16: vector<u8>,
    }

    struct ENCLAVE_REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        enclaves: 0x2::table::Table<vector<u8>, Pcrs>,
    }

    fun compress_secp256k1_pubkey(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 64, 2);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = if (*0x1::vector::borrow<u8>(arg0, 63) % 2 == 0) {
            2
        } else {
            3
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_pcrs(arg0: &Registry, arg1: &vector<u8>) : &Pcrs {
        assert!(0x2::table::contains<vector<u8>, Pcrs>(&arg0.enclaves, *arg1), 0);
        0x2::table::borrow<vector<u8>, Pcrs>(&arg0.enclaves, *arg1)
    }

    fun init(arg0: ENCLAVE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg1),
            enclaves : 0x2::table::new<vector<u8>, Pcrs>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_registered(arg0: &Registry, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Pcrs>(&arg0.enclaves, *arg1)
    }

    fun load_pk(arg0: &0x2::nitro_attestation::NitroAttestationDocument) : vector<u8> {
        assert!(0x1::option::is_some<vector<u8>>(0x2::nitro_attestation::public_key(arg0)), 3);
        normalize_pk(0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(arg0)))
    }

    public fun new_pcrs(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : Pcrs {
        Pcrs{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
            pos3 : arg3,
        }
    }

    fun normalize_pk(arg0: vector<u8>) : vector<u8> {
        if (0x1::vector::length<u8>(&arg0) == 65) {
            assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 4, 4);
            let v0 = 0x1::vector::empty<u8>();
            let v1 = 1;
            while (v1 < 65) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
                v1 = v1 + 1;
            };
            arg0 = v0;
        };
        if (0x1::vector::length<u8>(&arg0) == 64) {
            let v2 = &arg0;
            arg0 = compress_secp256k1_pubkey(v2);
        };
        if (0x1::vector::length<u8>(&arg0) == 33) {
            assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 2 || *0x1::vector::borrow<u8>(&arg0, 0) == 3, 5);
        } else {
            assert!(0x1::vector::length<u8>(&arg0) == 32, 2);
        };
        arg0
    }

    public fun pcr_0(arg0: &Pcrs) : &vector<u8> {
        &arg0.pos0
    }

    public fun pcr_1(arg0: &Pcrs) : &vector<u8> {
        &arg0.pos1
    }

    public fun pcr_16(arg0: &Pcrs) : &vector<u8> {
        &arg0.pos3
    }

    public fun pcr_2(arg0: &Pcrs) : &vector<u8> {
        &arg0.pos2
    }

    public fun register_enclave(arg0: &mut Registry, arg1: 0x2::nitro_attestation::NitroAttestationDocument) {
        let v0 = load_pk(&arg1);
        let v1 = to_pcrs(&arg1);
        assert!(!0x2::table::contains<vector<u8>, Pcrs>(&arg0.enclaves, v0), 1);
        0x2::table::add<vector<u8>, Pcrs>(&mut arg0.enclaves, v0, v1);
        let v2 = EnclaveRegistered{
            pk    : v0,
            pcr0  : *pcr_0(&v1),
            pcr1  : *pcr_1(&v1),
            pcr2  : *pcr_2(&v1),
            pcr16 : *pcr_16(&v1),
        };
        0x2::event::emit<EnclaveRegistered>(v2);
    }

    fun to_pcrs(arg0: &0x2::nitro_attestation::NitroAttestationDocument) : Pcrs {
        let v0 = 0x2::nitro_attestation::pcrs(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(v0)) {
            let v6 = 0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, v5);
            let v7 = 0x2::nitro_attestation::index(v6);
            if (v7 == 0) {
                v1 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 1) {
                v2 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 2) {
                v3 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 16) {
                v4 = *0x2::nitro_attestation::value(v6);
            };
            v5 = v5 + 1;
        };
        Pcrs{
            pos0 : v1,
            pos1 : v2,
            pos2 : v3,
            pos3 : v4,
        }
    }

    // decompiled from Move bytecode v6
}

