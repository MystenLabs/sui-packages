module 0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::outbox_bridge {
    struct OutboxBridge has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        latest_epoch: u64,
        is_initialized: bool,
        roots: 0x2::table::Table<u64, vector<u8>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        bridge_id: 0x2::object::ID,
    }

    struct OUTBOX_BRIDGE has drop {
        dummy_field: bool,
    }

    struct InitialMerkleRootSetEvent has copy, drop {
        epoch: u64,
        root: vector<u8>,
    }

    struct MerkleRootUpdatedEvent has copy, drop {
        epoch: u64,
        root: vector<u8>,
    }

    struct EmergencyMerkleRootResetEvent has copy, drop {
        epoch: u64,
        roots: vector<vector<u8>>,
    }

    fun assert_bridge_version(arg0: &OutboxBridge) {
        assert!(arg0.package_version == 1, 12);
    }

    fun assert_valid_non_zero_root(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 10);
        assert!(!is_zero_hash(arg0), 13);
    }

    fun create_merkle_update_message_hash(arg0: u64, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"MERKLE_UPDATE");
        0x1::vector::append<u8>(&mut v0, 0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::utils::u64_to_be_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::hash::sha2_256(v0)
    }

    fun create_outbox_proof_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"OUTBOX");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, b"OUTBOUND");
        0x1::vector::append<u8>(&mut v1, 0x1::hash::sha2_256(v0));
        0x1::vector::append<u8>(&mut v1, 0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::utils::u64_to_be_bytes(arg2));
        0x1::hash::sha2_256(v1)
    }

    public fun emergency_reset_merkle_root(arg0: &AdminCap, arg1: &mut OutboxBridge, arg2: u64, arg3: vector<vector<u8>>) {
        assert_bridge_version(arg1);
        assert!(arg0.bridge_id == 0x2::object::id<OutboxBridge>(arg1), 1);
        assert!(arg1.is_initialized, 3);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0 && v0 <= 3, 15);
        assert!(arg2 >= v0 - 1, 15);
        assert_valid_non_zero_root(0x1::vector::borrow<vector<u8>>(&arg3, 0));
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg3, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 10);
            set_root_for_epoch(arg1, arg2 - v1, *v2);
            v1 = v1 + 1;
        };
        arg1.latest_epoch = arg2;
        let v3 = EmergencyMerkleRootResetEvent{
            epoch : arg2,
            roots : arg3,
        };
        0x2::event::emit<EmergencyMerkleRootResetEvent>(v3);
    }

    fun init(arg0: OUTBOX_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<OUTBOX_BRIDGE>(arg0, arg1);
        let (v0, v1) = init_bridge(arg1);
        0x2::transfer::share_object<OutboxBridge>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_bridge(arg0: &mut 0x2::tx_context::TxContext) : (OutboxBridge, AdminCap) {
        let v0 = OutboxBridge{
            id              : 0x2::object::new(arg0),
            package_version : 1,
            latest_epoch    : 0,
            is_initialized  : false,
            roots           : 0x2::table::new<u64, vector<u8>>(arg0),
        };
        let v1 = AdminCap{
            id        : 0x2::object::new(arg0),
            bridge_id : 0x2::object::id<OutboxBridge>(&v0),
        };
        (v0, v1)
    }

    fun is_zero_hash(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun latest_epoch(arg0: &OutboxBridge) : u64 {
        arg0.latest_epoch
    }

    public fun migrate_bridge_version(arg0: &AdminCap, arg1: &mut OutboxBridge) {
        assert_bridge_version(arg1);
        assert!(arg0.bridge_id == 0x2::object::id<OutboxBridge>(arg1), 1);
        arg1.package_version = 1 + 1;
    }

    public fun root_by_epoch(arg0: &OutboxBridge, arg1: u64) : vector<u8> {
        if (0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg1)) {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg1)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun set_initial_merkle_root(arg0: &mut OutboxBridge, arg1: u64, arg2: vector<u8>) {
        assert_bridge_version(arg0);
        assert!(!arg0.is_initialized, 2);
        assert_valid_non_zero_root(&arg2);
        arg0.is_initialized = true;
        arg0.latest_epoch = arg1;
        set_root_for_epoch(arg0, arg1, arg2);
        let v0 = InitialMerkleRootSetEvent{
            epoch : arg1,
            root  : arg2,
        };
        0x2::event::emit<InitialMerkleRootSetEvent>(v0);
    }

    fun set_root_for_epoch(arg0: &mut OutboxBridge, arg1: u64, arg2: vector<u8>) {
        if (0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg1)) {
            0x2::table::remove<u64, vector<u8>>(&mut arg0.roots, arg1);
        };
        if (!is_zero_hash(&arg2)) {
            0x2::table::add<u64, vector<u8>>(&mut arg0.roots, arg1, arg2);
        };
    }

    public fun update_merkle_root(arg0: &mut OutboxBridge, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: vector<u8>) {
        assert_bridge_version(arg0);
        assert!(arg0.is_initialized, 3);
        assert!(arg1 == arg0.latest_epoch + 1, 4);
        assert_valid_non_zero_root(&arg2);
        assert!(0x1::vector::length<u8>(&arg5) == 64, 5);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 6);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg0.latest_epoch), 9);
        verify_update_signature(arg1, arg2, arg3, arg4, arg5, arg6, *0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg0.latest_epoch));
        arg0.latest_epoch = arg1;
        set_root_for_epoch(arg0, arg1, arg2);
        let v0 = MerkleRootUpdatedEvent{
            epoch : arg1,
            root  : arg2,
        };
        0x2::event::emit<MerkleRootUpdatedEvent>(v0);
    }

    public fun verify_outbox_message(arg0: &OutboxBridge, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>) {
        assert_bridge_version(arg0);
        assert!(arg0.is_initialized, 3);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 11);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 11);
        assert!(0x1::vector::length<u8>(&arg6) == 64, 5);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 6);
        assert!(arg3 <= arg0.latest_epoch, 9);
        assert!(arg3 + 3 > arg0.latest_epoch, 14);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg3), 9);
        verify_receive_signature(create_outbox_proof_hash(arg2, arg1, arg3), *0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg3), arg4, arg5, arg6, arg7);
    }

    fun verify_receive_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>) {
        assert!(0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::merkle::verify_merkle_aggregation(arg2, arg4, arg3, arg1), 7);
        let (v0, _) = 0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::bn254::hash_to_g1(arg0);
        assert!(0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::bn254::verify(arg5, arg4, v0), 8);
    }

    fun verify_update_signature(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::merkle::verify_merkle_aggregation(arg2, arg4, arg3, arg6), 7);
        let (v0, _) = 0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::bn254::hash_to_g1(create_merkle_update_message_hash(arg0, arg1));
        assert!(0x51b770db737e25e57389fc93761ba4f6f134af39102d0eda521f1f05455e19a0::bn254::verify(arg5, arg4, v0), 8);
    }

    // decompiled from Move bytecode v6
}

