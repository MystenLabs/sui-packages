module 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager {
    struct VerificationKeyManager has store, key {
        id: 0x2::object::UID,
        admin: address,
        keys: vector<VerificationKey>,
        is_paused: bool,
    }

    struct VerificationKey has copy, drop, store {
        key_type: u8,
        key_id: vector<u8>,
        key_data: vector<u8>,
        circuit_hash: vector<u8>,
        created_at: u64,
        is_active: bool,
    }

    struct KeyUpdatedEvent has copy, drop {
        key_type: u8,
        key_id: vector<u8>,
        old_key_hash: vector<u8>,
        new_key_hash: vector<u8>,
        updated_by: address,
    }

    struct KeyManagerCreatedEvent has copy, drop {
        manager_id: address,
        admin: address,
    }

    struct EmergencyPauseEvent has copy, drop {
        paused: bool,
        triggered_by: address,
    }

    public fun create_key_manager(arg0: &mut 0x2::tx_context::TxContext) : VerificationKeyManager {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = VerificationKeyManager{
            id        : 0x2::object::new(arg0),
            admin     : v0,
            keys      : 0x1::vector::empty<VerificationKey>(),
            is_paused : false,
        };
        let v2 = KeyManagerCreatedEvent{
            manager_id : 0x2::object::uid_to_address(&v1.id),
            admin      : v0,
        };
        0x2::event::emit<KeyManagerCreatedEvent>(v2);
        v1
    }

    public entry fun deactivate_key(arg0: &mut VerificationKeyManager, arg1: u8, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<VerificationKey>(&arg0.keys)) {
            let v1 = 0x1::vector::borrow_mut<VerificationKey>(&mut arg0.keys, v0);
            if (v1.key_type == arg1 && v1.key_id == arg2) {
                v1.is_active = false;
                break
            };
            v0 = v0 + 1;
        };
    }

    public entry fun emergency_pause(arg0: &mut VerificationKeyManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.is_paused = true;
        let v0 = EmergencyPauseEvent{
            paused       : true,
            triggered_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public fun get_admin(arg0: &VerificationKeyManager) : address {
        arg0.admin
    }

    public fun get_key_count(arg0: &VerificationKeyManager) : u64 {
        0x1::vector::length<VerificationKey>(&arg0.keys)
    }

    fun get_key_hash_if_exists(arg0: &VerificationKeyManager, arg1: u8, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VerificationKey>(&arg0.keys)) {
            let v1 = 0x1::vector::borrow<VerificationKey>(&arg0.keys, v0);
            if (v1.key_type == arg1 && &v1.key_id == arg2) {
                return 0x2::hash::keccak256(&v1.key_data)
            };
            v0 = v0 + 1;
        };
        0x1::vector::empty<u8>()
    }

    public fun get_keys_for_circuit(arg0: &VerificationKeyManager, arg1: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<VerificationKey>(&arg0.keys)) {
            let v5 = 0x1::vector::borrow<VerificationKey>(&arg0.keys, v4);
            if (&v5.circuit_hash == arg1 && v5.is_active) {
                if (v5.key_type == 1) {
                    v0 = v5.key_data;
                } else if (v5.key_type == 2) {
                    v1 = v5.key_data;
                } else if (v5.key_type == 3) {
                    v2 = v5.key_data;
                } else if (v5.key_type == 4) {
                    v3 = v5.key_data;
                };
            };
            v4 = v4 + 1;
        };
        (v0, v1, v2, v3)
    }

    public fun get_verification_key(arg0: &VerificationKeyManager, arg1: u8, arg2: &vector<u8>) : vector<u8> {
        assert!(!arg0.is_paused, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<VerificationKey>(&arg0.keys)) {
            let v1 = 0x1::vector::borrow<VerificationKey>(&arg0.keys, v0);
            let v2 = if (v1.key_type == arg1) {
                if (&v1.key_id == arg2) {
                    v1.is_active
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v1.key_data
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    public fun is_paused(arg0: &VerificationKeyManager) : bool {
        arg0.is_paused
    }

    fun is_valid_key_length(arg0: u8, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        let v1 = if (arg0 == 1) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        };
        v1 && v0 == 64 || arg0 == 2 && v0 == 384 || arg0 == 5 && v0 > 100 && v0 < 500
    }

    fun is_valid_key_type(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    public fun key_type_alpha() : u8 {
        2
    }

    public fun key_type_complete_vk() : u8 {
        5
    }

    public fun key_type_delta() : u8 {
        4
    }

    public fun key_type_gamma() : u8 {
        3
    }

    public fun key_type_vk() : u8 {
        1
    }

    fun remove_key_if_exists(arg0: &mut VerificationKeyManager, arg1: u8, arg2: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VerificationKey>(&arg0.keys)) {
            let v1 = 0x1::vector::borrow<VerificationKey>(&arg0.keys, v0);
            if (v1.key_type == arg1 && &v1.key_id == arg2) {
                0x1::vector::remove<VerificationKey>(&mut arg0.keys, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public entry fun resume_operations(arg0: &mut VerificationKeyManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.is_paused = false;
        let v0 = EmergencyPauseEvent{
            paused       : false,
            triggered_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public entry fun transfer_admin(arg0: &mut VerificationKeyManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public entry fun update_verification_key(arg0: &mut VerificationKeyManager, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(!arg0.is_paused, 1);
        assert!(is_valid_key_type(arg1), 4);
        assert!(is_valid_key_length(arg1, &arg3), 2);
        let v0 = get_key_hash_if_exists(arg0, arg1, &arg2);
        remove_key_if_exists(arg0, arg1, &arg2);
        let v1 = VerificationKey{
            key_type     : arg1,
            key_id       : arg2,
            key_data     : arg3,
            circuit_hash : arg4,
            created_at   : 0x2::tx_context::epoch(arg5),
            is_active    : true,
        };
        0x1::vector::push_back<VerificationKey>(&mut arg0.keys, v1);
        let v2 = KeyUpdatedEvent{
            key_type     : arg1,
            key_id       : arg2,
            old_key_hash : v0,
            new_key_hash : 0x2::hash::keccak256(&arg3),
            updated_by   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<KeyUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

