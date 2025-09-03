module 0x5e537069e74ea010fb472df17011ffeba1f63d1bae387f42751e81f020ee0d1f::seal_manager {
    struct AccessPolicy has store, key {
        id: 0x2::object::UID,
        creator: address,
        rules: 0x2::vec_map::VecMap<address, bool>,
    }

    struct EncryptedFile has store, key {
        id: 0x2::object::UID,
        blob_id: vector<u8>,
        policy_id: 0x2::object::ID,
        metadata: vector<u8>,
    }

    struct TEEAttestation has store, key {
        id: 0x2::object::UID,
        enclave_id: vector<u8>,
        attested_by: address,
        blob_id: vector<u8>,
    }

    public entry fun create_access_policy(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x61dc067b264b423cc4ca3bcc57f4867c08c01619aa0b6d156ac24d0fabff044a, 7);
        assert!(0x1::vector::length<address>(&arg0) > 0, 4);
        let v0 = 0x2::vec_map::empty<address, bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x2::vec_map::insert<address, bool>(&mut v0, *0x1::vector::borrow<address>(&arg0, v1), true);
            v1 = v1 + 1;
        };
        let v2 = AccessPolicy{
            id      : 0x2::object::new(arg1),
            creator : 0x2::tx_context::sender(arg1),
            rules   : v0,
        };
        0x2::transfer::share_object<AccessPolicy>(v2);
    }

    public fun get_access_policy(arg0: &AccessPolicy) : (address, &0x2::vec_map::VecMap<address, bool>) {
        (arg0.creator, &arg0.rules)
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun namespace(arg0: &AccessPolicy) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public entry fun register_tee_attestation(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x61dc067b264b423cc4ca3bcc57f4867c08c01619aa0b6d156ac24d0fabff044a, 7);
        let v0 = TEEAttestation{
            id          : 0x2::object::new(arg3),
            enclave_id  : arg0,
            attested_by : arg2,
            blob_id     : arg1,
        };
        0x2::transfer::share_object<TEEAttestation>(v0);
    }

    public entry fun save_encrypted_file(arg0: vector<u8>, arg1: &AccessPolicy, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x61dc067b264b423cc4ca3bcc57f4867c08c01619aa0b6d156ac24d0fabff044a, 7);
        let v0 = EncryptedFile{
            id        : 0x2::object::new(arg3),
            blob_id   : arg0,
            policy_id : 0x2::object::uid_to_inner(&arg1.id),
            metadata  : arg2,
        };
        0x2::transfer::share_object<EncryptedFile>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &EncryptedFile, arg2: &AccessPolicy, arg3: &TEEAttestation, arg4: address) {
        assert!(is_prefix(namespace(arg2), arg0), 6);
        assert!(arg1.blob_id == arg0, 3);
        assert!(arg1.policy_id == 0x2::object::uid_to_inner(&arg2.id), 0);
        assert!(0x2::vec_map::contains<address, bool>(&arg2.rules, &arg4), 2);
        assert!(arg3.attested_by != @0x0, 5);
        assert!(arg3.blob_id == arg1.blob_id, 3);
    }

    // decompiled from Move bytecode v6
}

