module 0x864ac66ca450ba0f84144f9ddaa9afaf758f239d4a88c4ad61e3aa7388e89363::capsule {
    struct PersistCapsule has store, key {
        id: 0x2::object::UID,
        walrus_blob_id: vector<u8>,
        creator: address,
        nominee: address,
        release_time_ms: u64,
        status: u8,
        oracle_pubkey: vector<u8>,
        inactivity_window_ms: u64,
    }

    struct CapsuleCreated has copy, drop {
        capsule_id: 0x2::object::ID,
        creator: address,
        nominee: address,
        release_time_ms: u64,
    }

    struct CapsuleClaimed has copy, drop {
        capsule_id: 0x2::object::ID,
        nominee: address,
    }

    entry fun claim_capsule(arg0: &mut PersistCapsule, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.nominee, 0);
        assert!(arg0.status == 0, 1);
        arg0.status = 1;
        let v0 = CapsuleClaimed{
            capsule_id : 0x2::object::uid_to_inner(&arg0.id),
            nominee    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CapsuleClaimed>(v0);
    }

    entry fun create_capsule(arg0: vector<u8>, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 4);
        assert!(arg1 != v0, 5);
        let v1 = 0x2::object::new(arg6);
        let v2 = PersistCapsule{
            id                   : v1,
            walrus_blob_id       : arg0,
            creator              : v0,
            nominee              : arg1,
            release_time_ms      : arg2,
            status               : 0,
            oracle_pubkey        : arg3,
            inactivity_window_ms : arg4,
        };
        let v3 = CapsuleCreated{
            capsule_id      : 0x2::object::uid_to_inner(&v1),
            creator         : v0,
            nominee         : arg1,
            release_time_ms : arg2,
        };
        0x2::event::emit<CapsuleCreated>(v3);
        0x2::transfer::share_object<PersistCapsule>(v2);
    }

    public fun get_creator(arg0: &PersistCapsule) : address {
        arg0.creator
    }

    public fun get_inactivity_window_ms(arg0: &PersistCapsule) : u64 {
        arg0.inactivity_window_ms
    }

    public fun get_nominee(arg0: &PersistCapsule) : address {
        arg0.nominee
    }

    public fun get_release_time_ms(arg0: &PersistCapsule) : u64 {
        arg0.release_time_ms
    }

    public fun get_status(arg0: &PersistCapsule) : u8 {
        arg0.status
    }

    public fun get_walrus_blob_id(arg0: &PersistCapsule) : &vector<u8> {
        &arg0.walrus_blob_id
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PersistCapsule, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(arg0 == 0x2::object::id_to_bytes(&v0), 6);
        assert!(0x2::tx_context::sender(arg4) == arg1.nominee, 0);
        let v1 = false;
        if (!0x1::vector::is_empty<u8>(&arg2)) {
            if (0x2::ed25519::ed25519_verify(&arg2, &arg1.oracle_pubkey, &arg0)) {
                v1 = true;
            };
        };
        if (!v1 && 0x2::clock::timestamp_ms(arg3) >= arg1.release_time_ms) {
            v1 = true;
        };
        assert!(v1, 2);
    }

    entry fun update_blob_id(arg0: &mut PersistCapsule, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 3);
        assert!(0x1::vector::is_empty<u8>(&arg0.walrus_blob_id), 7);
        arg0.walrus_blob_id = arg1;
    }

    // decompiled from Move bytecode v6
}

