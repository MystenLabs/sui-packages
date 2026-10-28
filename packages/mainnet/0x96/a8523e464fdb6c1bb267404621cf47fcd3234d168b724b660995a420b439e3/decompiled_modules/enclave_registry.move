module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::enclave_registry {
    struct ENCLAVE_REGISTRY has drop {
        dummy_field: bool,
    }

    struct EnclaveRegistry has key {
        id: 0x2::object::UID,
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
        version: u64,
    }

    struct KeyRecord has drop, store {
        pk: vector<u8>,
        revoked: bool,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct PcrsUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        old_pcr0: vector<u8>,
        old_pcr1: vector<u8>,
        old_pcr2: vector<u8>,
        new_pcr0: vector<u8>,
        new_pcr1: vector<u8>,
        new_pcr2: vector<u8>,
    }

    struct EnclaveKeyRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        session_address: address,
    }

    struct EnclaveKeyRevoked has copy, drop {
        registry_id: 0x2::object::ID,
        session_address: address,
    }

    struct RegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    fun assert_pcr_values(arg0: &vector<u8>, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) {
        let v0 = false;
        let v1 = false;
        let v2 = false;
        let v3 = false;
        let v4 = false;
        let v5 = false;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(arg0)) {
            let v7 = *0x1::vector::borrow<u8>(arg0, v6);
            let v8 = 0x1::vector::borrow<vector<u8>>(arg1, v6);
            if (v7 == 0) {
                assert!(!v3, 13837029814639001613);
                v3 = true;
                v0 = *v8 == *arg2;
            };
            if (v7 == 1) {
                assert!(!v4, 13837029836113838093);
                v4 = true;
                v1 = *v8 == *arg3;
            };
            if (v7 == 2) {
                assert!(!v5, 13837029857588674573);
                v5 = true;
                v2 = *v8 == *arg4;
            };
            v6 = v6 + 1;
        };
        let v9 = if (v0) {
            if (v1) {
                v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 13835341033497427969);
    }

    fun assert_pcrs(arg0: &EnclaveRegistry, arg1: &0x2::nitro_attestation::NitroAttestationDocument) {
        let v0 = 0x2::nitro_attestation::pcrs(arg1);
        let v1 = b"";
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(v0)) {
            let v4 = 0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, v3);
            0x1::vector::push_back<u8>(&mut v1, 0x2::nitro_attestation::index(v4));
            0x1::vector::push_back<vector<u8>>(&mut v2, *0x2::nitro_attestation::value(v4));
            v3 = v3 + 1;
        };
        assert_pcr_values(&v1, &v2, &arg0.pcr0, &arg0.pcr1, &arg0.pcr2);
    }

    fun assert_registry_version(arg0: &EnclaveRegistry) {
        assert!(arg0.version == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13837310946018459663);
    }

    public fun current_version() : u64 {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current()
    }

    fun init(arg0: ENCLAVE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EnclaveRegistry{
            id      : 0x2::object::new(arg1),
            pcr0    : b"",
            pcr1    : b"",
            pcr2    : b"",
            version : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        let v1 = RegistryCreated{registry_id: 0x2::object::id<EnclaveRegistry>(&v0)};
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<EnclaveRegistry>(v0);
    }

    public fun is_registered(arg0: &EnclaveRegistry, arg1: address) : bool {
        if (!0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            return false
        };
        !0x2::dynamic_field::borrow<address, KeyRecord>(&arg0.id, arg1).revoked
    }

    public fun is_revoked(arg0: &EnclaveRegistry, arg1: address) : bool {
        if (!0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            return false
        };
        0x2::dynamic_field::borrow<address, KeyRecord>(&arg0.id, arg1).revoked
    }

    public fun migrate_enclave_registry(arg0: &mut EnclaveRegistry) {
        assert!(arg0.version < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13837310967493296143);
        arg0.version = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current();
        let v0 = RegistryMigrated{
            registry_id  : 0x2::object::id<EnclaveRegistry>(arg0),
            from_version : arg0.version,
            to_version   : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::event::emit<RegistryMigrated>(v0);
    }

    public fun register_enclave_key(arg0: &mut EnclaveRegistry, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) : address {
        assert_registry_version(arg0);
        assert_pcrs(arg0, &arg1);
        let v0 = 0x2::nitro_attestation::public_key(&arg1);
        assert!(0x1::option::is_some<vector<u8>>(v0), 13835621967308390403);
        let v1 = *0x1::option::borrow<vector<u8>>(v0);
        assert!(0x1::vector::length<u8>(&v1) == 32, 13835903450875166725);
        let v2 = sui_address_for_ed25519(&v1);
        if (0x2::dynamic_field::exists<address>(&arg0.id, v2)) {
            assert!(!0x2::dynamic_field::borrow<address, KeyRecord>(&arg0.id, v2).revoked, 13836747905870462987);
            abort 13836184960211746823
        };
        let v3 = KeyRecord{
            pk      : v1,
            revoked : false,
        };
        0x2::dynamic_field::add<address, KeyRecord>(&mut arg0.id, v2, v3);
        let v4 = EnclaveKeyRegistered{
            registry_id     : 0x2::object::id<EnclaveRegistry>(arg0),
            session_address : v2,
        };
        0x2::event::emit<EnclaveKeyRegistered>(v4);
        v2
    }

    public fun registry_version(arg0: &EnclaveRegistry) : u64 {
        arg0.version
    }

    public fun revoke_key(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut EnclaveRegistry, arg3: address) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        assert!(0x2::dynamic_field::exists<address>(&arg2.id, arg3), 13836466181785518089);
        let v0 = 0x2::dynamic_field::borrow_mut<address, KeyRecord>(&mut arg2.id, arg3);
        assert!(!v0.revoked, 13836466190375452681);
        v0.revoked = true;
        let v1 = EnclaveKeyRevoked{
            registry_id     : 0x2::object::id<EnclaveRegistry>(arg2),
            session_address : arg3,
        };
        0x2::event::emit<EnclaveKeyRevoked>(v1);
    }

    fun sui_address_for_ed25519(arg0: &vector<u8>) : address {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 0);
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun update_pcrs(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut EnclaveRegistry, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        assert!(0x1::vector::length<u8>(&arg3) == 48, 13837591948548898833);
        assert!(0x1::vector::length<u8>(&arg4) == 48, 13837591952843866129);
        assert!(0x1::vector::length<u8>(&arg5) == 48, 13837591957138833425);
        arg2.pcr0 = arg3;
        arg2.pcr1 = arg4;
        arg2.pcr2 = arg5;
        let v0 = PcrsUpdated{
            registry_id : 0x2::object::id<EnclaveRegistry>(arg2),
            old_pcr0    : arg2.pcr0,
            old_pcr1    : arg2.pcr1,
            old_pcr2    : arg2.pcr2,
            new_pcr0    : arg2.pcr0,
            new_pcr1    : arg2.pcr1,
            new_pcr2    : arg2.pcr2,
        };
        0x2::event::emit<PcrsUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

