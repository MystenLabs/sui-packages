module 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::attestation {
    struct EnclaveConfig has key {
        id: 0x2::object::UID,
        version: u64,
        pcrs: 0x2::vec_map::VecMap<u8, vector<u8>>,
        enclave_pubkey: vector<u8>,
        registrar: address,
    }

    struct EnclaveRegistered has copy, drop {
        config_id: 0x2::object::ID,
        enclave_pubkey: vector<u8>,
        registrar: address,
    }

    struct CommandAttested has copy, drop {
        config_id: 0x2::object::ID,
        machine_id: 0x2::object::ID,
        seq: u64,
        manifest_hash: vector<u8>,
        enclave_pubkey: vector<u8>,
    }

    fun attestation_preimage(arg0: 0x2::object::ID, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"REEG_NAUTILUS_ATTEST_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        v0
    }

    public fun enclave_pubkey(arg0: &EnclaveConfig) : vector<u8> {
        arg0.enclave_pubkey
    }

    public fun has_pcr(arg0: &EnclaveConfig, arg1: u8) : bool {
        0x2::vec_map::contains<u8, vector<u8>>(&arg0.pcrs, &arg1)
    }

    public fun pcr(arg0: &EnclaveConfig, arg1: u8) : vector<u8> {
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.pcrs, &arg1)
    }

    public fun register_attested_command(arg0: &EnclaveConfig, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.version == 1, 3);
        let v0 = attestation_preimage(arg1, arg2, &arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.enclave_pubkey, &v0), 2);
        let v1 = CommandAttested{
            config_id      : 0x2::object::id<EnclaveConfig>(arg0),
            machine_id     : arg1,
            seq            : arg2,
            manifest_hash  : arg3,
            enclave_pubkey : arg0.enclave_pubkey,
        };
        0x2::event::emit<CommandAttested>(v1);
    }

    public fun register_enclave(arg0: 0x2::nitro_attestation::NitroAttestationDocument, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::nitro_attestation::public_key(&arg0);
        assert!(0x1::option::is_some<vector<u8>>(v0), 0);
        let v1 = *0x1::option::borrow<vector<u8>>(v0);
        assert!(0x1::vector::length<u8>(&v1) == 32, 1);
        let v2 = 0x2::nitro_attestation::pcrs(&arg0);
        let v3 = 0x2::vec_map::empty<u8, vector<u8>>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(v2)) {
            let v5 = 0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v2, v4);
            let v6 = 0x2::nitro_attestation::index(v5);
            if (!0x2::vec_map::contains<u8, vector<u8>>(&v3, &v6)) {
                0x2::vec_map::insert<u8, vector<u8>>(&mut v3, v6, *0x2::nitro_attestation::value(v5));
            };
            v4 = v4 + 1;
        };
        let v7 = EnclaveConfig{
            id             : 0x2::object::new(arg1),
            version        : 1,
            pcrs           : v3,
            enclave_pubkey : v1,
            registrar      : 0x2::tx_context::sender(arg1),
        };
        let v8 = EnclaveRegistered{
            config_id      : 0x2::object::id<EnclaveConfig>(&v7),
            enclave_pubkey : v7.enclave_pubkey,
            registrar      : v7.registrar,
        };
        0x2::event::emit<EnclaveRegistered>(v8);
        0x2::transfer::share_object<EnclaveConfig>(v7);
    }

    public fun registrar(arg0: &EnclaveConfig) : address {
        arg0.registrar
    }

    public fun version(arg0: &EnclaveConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

