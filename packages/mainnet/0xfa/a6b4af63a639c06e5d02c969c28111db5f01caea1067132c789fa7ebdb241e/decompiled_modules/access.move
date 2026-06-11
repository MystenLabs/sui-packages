module 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::access {
    struct Grant has copy, drop, store {
        rights: u8,
        expiry_ms: u64,
    }

    struct AccessPolicy has key {
        id: 0x2::object::UID,
        machine_id: 0x2::object::ID,
        owner: address,
        version: u64,
        grants: 0x2::vec_map::VecMap<address, Grant>,
    }

    struct AccessGranted has copy, drop {
        machine_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        grantee: address,
        rights: u8,
        expiry_ms: u64,
        seq: u64,
        blob_id: u256,
        manifest_hash: vector<u8>,
        payload_hash: vector<u8>,
        prev_head: vector<u8>,
        new_head: vector<u8>,
        timestamp_ms: u64,
    }

    struct AccessRevoked has copy, drop {
        machine_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        grantee: address,
        seq: u64,
        blob_id: u256,
        manifest_hash: vector<u8>,
        payload_hash: vector<u8>,
        prev_head: vector<u8>,
        new_head: vector<u8>,
        timestamp_ms: u64,
    }

    fun access_payload_hash(arg0: address, arg1: u8, arg2: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::hash::blake2b256(&v0)
    }

    fun assert_owner_and_binding(arg0: &0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine, arg1: &AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1.machine_id == 0x2::object::id<0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine>(arg0), 4);
        assert!(0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::policy_id(arg0) == 0x2::object::id<AccessPolicy>(arg1), 4);
    }

    entry fun create_shared_machine(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_machine_and_policy(arg0);
        let v2 = v0;
        0x2::transfer::share_object<AccessPolicy>(v1);
        0x2::transfer::public_transfer<0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine>(v2, 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::owner(&v2));
    }

    fun expected_identity(arg0: &AccessPolicy) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(&arg0.id);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.machine_id));
        v0
    }

    public fun grant(arg0: &mut 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine, arg1: &mut AccessPolicy, arg2: address, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_owner_and_binding(arg0, arg1, arg6);
        if (0x2::vec_map::contains<address, Grant>(&arg1.grants, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<address, Grant>(&mut arg1.grants, &arg2);
            v0.rights = arg3;
            v0.expiry_ms = arg4;
        } else {
            let v1 = Grant{
                rights    : arg3,
                expiry_ms : arg4,
            };
            0x2::vec_map::insert<address, Grant>(&mut arg1.grants, arg2, v1);
        };
        let v2 = access_payload_hash(arg2, arg3, arg4);
        let (v3, v4, v5, v6) = 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::register_grant(arg0, v2, arg5, arg6);
        let v7 = AccessGranted{
            machine_id    : 0x2::object::id<0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine>(arg0),
            policy_id     : 0x2::object::id<AccessPolicy>(arg1),
            grantee       : arg2,
            rights        : arg3,
            expiry_ms     : arg4,
            seq           : v3,
            blob_id       : 0,
            manifest_hash : b"",
            payload_hash  : v2,
            prev_head     : v4,
            new_head      : v5,
            timestamp_ms  : v6,
        };
        0x2::event::emit<AccessGranted>(v7);
    }

    public fun grantees(arg0: &AccessPolicy) : vector<address> {
        0x2::vec_map::keys<address, Grant>(&arg0.grants)
    }

    public fun is_granted(arg0: &AccessPolicy, arg1: address) : bool {
        0x2::vec_map::contains<address, Grant>(&arg0.grants, &arg1)
    }

    public fun machine_id(arg0: &AccessPolicy) : 0x2::object::ID {
        arg0.machine_id
    }

    public fun migrate(arg0: &mut AccessPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    fun new_machine_and_policy(arg0: &mut 0x2::tx_context::TxContext) : (0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine, AccessPolicy) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::create(0x2::object::uid_to_inner(&v1), arg0);
        let v3 = 0x2::vec_map::empty<address, Grant>();
        let v4 = Grant{
            rights    : 1 | 2,
            expiry_ms : 0,
        };
        0x2::vec_map::insert<address, Grant>(&mut v3, v0, v4);
        let v5 = AccessPolicy{
            id         : v1,
            machine_id : 0x2::object::id<0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine>(&v2),
            owner      : v0,
            version    : 1,
            grants     : v3,
        };
        (v2, v5)
    }

    public fun policy_owner(arg0: &AccessPolicy) : address {
        arg0.owner
    }

    public fun revoke(arg0: &mut 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine, arg1: &mut AccessPolicy, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner_and_binding(arg0, arg1, arg4);
        assert!(arg2 != arg1.owner, 6);
        if (0x2::vec_map::contains<address, Grant>(&arg1.grants, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, Grant>(&mut arg1.grants, &arg2);
        };
        let v2 = access_payload_hash(arg2, 0, 0);
        let (v3, v4, v5, v6) = 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::register_revoke(arg0, v2, arg3, arg4);
        let v7 = AccessRevoked{
            machine_id    : 0x2::object::id<0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine>(arg0),
            policy_id     : 0x2::object::id<AccessPolicy>(arg1),
            grantee       : arg2,
            seq           : v3,
            blob_id       : 0,
            manifest_hash : b"",
            payload_hash  : v2,
            prev_head     : v4,
            new_head      : v5,
            timestamp_ms  : v6,
        };
        0x2::event::emit<AccessRevoked>(v7);
    }

    entry fun seal_approve_allowlist(arg0: vector<u8>, arg1: &AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(arg0 == expected_identity(arg1), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, Grant>(&arg1.grants, &v0), 2);
    }

    entry fun seal_approve_until(arg0: vector<u8>, arg1: &AccessPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(arg0 == expected_identity(arg1), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_map::contains<address, Grant>(&arg1.grants, &v0), 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::vec_map::get<address, Grant>(&arg1.grants, &v1);
        assert!(v2.expiry_ms == 0 || 0x2::clock::timestamp_ms(arg2) < v2.expiry_ms, 3);
    }

    public fun version(arg0: &AccessPolicy) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

