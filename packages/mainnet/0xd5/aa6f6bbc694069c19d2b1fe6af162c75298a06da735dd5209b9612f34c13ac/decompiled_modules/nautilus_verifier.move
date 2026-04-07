module 0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::nautilus_verifier {
    struct EnclaveRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        pubkeys: vector<vector<u8>>,
    }

    struct AttestationMessage has copy, drop {
        x_user_id: u64,
        sui_address: address,
        nonce: u64,
        expires_at: u64,
        registry_id: address,
    }

    struct OwnerRecoveryMessage has copy, drop {
        x_user_id: u64,
        vault_id: address,
        current_owner: address,
        new_owner: address,
        recovery_counter: u64,
        expires_at: u64,
        registry_id: address,
    }

    struct PubkeyRegistered has copy, drop {
        admin: address,
        pubkey: vector<u8>,
    }

    struct PubkeyRemoved has copy, drop {
        admin: address,
        pubkey: vector<u8>,
    }

    struct RegistryPaused has copy, drop {
        registry_id: address,
        admin: address,
    }

    struct RegistryUnpaused has copy, drop {
        registry_id: address,
        admin: address,
    }

    struct RegistryCreated has copy, drop {
        registry_id: address,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = EnclaveRegistry{
            id      : 0x2::object::new(arg0),
            admin   : v0,
            paused  : false,
            pubkeys : 0x1::vector::empty<vector<u8>>(),
        };
        let v2 = RegistryCreated{
            registry_id : 0x2::object::uid_to_address(&v1.id),
            admin       : v0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<EnclaveRegistry>(v1);
    }

    public fun pause(arg0: &mut EnclaveRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(!arg0.paused, 7);
        arg0.paused = true;
        let v0 = RegistryPaused{
            registry_id : 0x2::object::uid_to_address(&arg0.id),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RegistryPaused>(v0);
    }

    public fun register_pubkey(arg0: &mut EnclaveRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.pubkeys)) {
            assert!(0x1::vector::borrow<vector<u8>>(&arg0.pubkeys, v0) != &arg1, 3);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg0.pubkeys, arg1);
        let v1 = PubkeyRegistered{
            admin  : 0x2::tx_context::sender(arg2),
            pubkey : arg1,
        };
        0x2::event::emit<PubkeyRegistered>(v1);
    }

    public fun remove_pubkey(arg0: &mut EnclaveRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.pubkeys)) {
            if (0x1::vector::borrow<vector<u8>>(&arg0.pubkeys, v0) == &arg1) {
                0x1::vector::swap_remove<vector<u8>>(&mut arg0.pubkeys, v0);
                let v1 = PubkeyRemoved{
                    admin  : 0x2::tx_context::sender(arg2),
                    pubkey : arg1,
                };
                0x2::event::emit<PubkeyRemoved>(v1);
                return
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    fun signature_matches_registered_pubkey(arg0: &EnclaveRegistry, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.pubkeys)) {
            if (0x2::ed25519::ed25519_verify(arg1, 0x1::vector::borrow<vector<u8>>(&arg0.pubkeys, v1), arg2)) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun unpause(arg0: &mut EnclaveRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(arg0.paused, 8);
        arg0.paused = false;
        let v0 = RegistryUnpaused{
            registry_id : 0x2::object::uid_to_address(&arg0.id),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RegistryUnpaused>(v0);
    }

    public fun verify_attestation(arg0: &EnclaveRegistry, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert!(!arg0.paused, 6);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg4, 2);
        assert!(0x1::vector::length<u8>(&arg5) == 64, 9);
        let v0 = AttestationMessage{
            x_user_id   : arg1,
            sui_address : arg2,
            nonce       : arg3,
            expires_at  : arg4,
            registry_id : 0x2::object::uid_to_address(&arg0.id),
        };
        let v1 = 0x2::bcs::to_bytes<AttestationMessage>(&v0);
        assert!(signature_matches_registered_pubkey(arg0, &arg5, &v1), 1);
    }

    public fun verify_owner_recovery_attestation(arg0: &EnclaveRegistry, arg1: u64, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(!arg0.paused, 6);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg6, 2);
        assert!(0x1::vector::length<u8>(&arg7) == 64, 9);
        let v0 = OwnerRecoveryMessage{
            x_user_id        : arg1,
            vault_id         : arg2,
            current_owner    : arg3,
            new_owner        : arg4,
            recovery_counter : arg5,
            expires_at       : arg6,
            registry_id      : 0x2::object::uid_to_address(&arg0.id),
        };
        let v1 = 0x2::bcs::to_bytes<OwnerRecoveryMessage>(&v0);
        assert!(signature_matches_registered_pubkey(arg0, &arg7, &v1), 1);
    }

    // decompiled from Move bytecode v6
}

