module 0x212b3966f9235171499e0e6c1f276fb6d815ff366e29b95a270a9288e5fff508::memory {
    struct MemoryObject has store, key {
        id: 0x2::object::UID,
        owner: address,
        schema_type: u8,
        data: vector<u8>,
        version: u64,
        created_at: u64,
        cap_epoch: u64,
    }

    struct MemoryCap has store, key {
        id: 0x2::object::UID,
        memory_id: 0x2::object::ID,
        permissions: u8,
        expiry: 0x1::option::Option<u64>,
        created_at: u64,
        issued_epoch: u64,
    }

    struct MemoryCreated has copy, drop {
        memory_id: 0x2::object::ID,
        schema_type: u8,
        owner: address,
        created_at: u64,
    }

    struct EpisodicAppend has copy, drop {
        memory_id: 0x2::object::ID,
        actor: address,
        version: u64,
        payload_size: u64,
        timestamp: u64,
    }

    struct SemanticUpdate has copy, drop {
        memory_id: 0x2::object::ID,
        actor: address,
        version: u64,
        key_hash: vector<u8>,
        timestamp: u64,
    }

    struct MemoryDestroyed has copy, drop {
        memory_id: 0x2::object::ID,
        final_version: u64,
    }

    struct CapabilityDelegated has copy, drop {
        cap_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        grantor: address,
        grantee: address,
        permissions: u8,
        expiry: 0x1::option::Option<u64>,
        created_at: u64,
    }

    struct CapabilityRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        revoked_by: address,
    }

    struct CapabilityUsed has copy, drop {
        cap_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        actor: address,
        operation: u8,
        timestamp: u64,
    }

    entry fun append(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg3);
        assert!(arg0.schema_type == 0, 0);
        append_internal(arg0, arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    fun append_internal(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = (0x1::vector::length<u8>(&arg1) as u64);
        assert!(v0 <= 4294967295, 6);
        let v1 = 44 + v0;
        assert!(v1 <= 4294967295, 6);
        let v2 = 4 + v1;
        assert!(v2 <= 65536, 7);
        assert!((0x1::vector::length<u8>(&arg0.data) as u64) + v2 <= 1048576, 8);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 8) {
            0x1::vector::push_back<u8>(&mut v4, ((v3 & 255) as u8));
            v3 = v3 >> 8;
            v5 = v5 + 1;
        };
        let v6 = 0x2::address::to_bytes(arg2);
        let v7 = 0;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v6, v7));
            v7 = v7 + 1;
        };
        let v8 = 0;
        while (v8 < 4) {
            0x1::vector::push_back<u8>(&mut v4, ((v0 & 255) as u8));
            v0 = v0 >> 8;
            v8 = v8 + 1;
        };
        0x1::vector::append<u8>(&mut v4, arg1);
        let v9 = 0x1::vector::empty<u8>();
        let v10 = (0x1::vector::length<u8>(&v4) as u64);
        let v11 = 0;
        while (v11 < 4) {
            0x1::vector::push_back<u8>(&mut v9, ((v10 & 255) as u8));
            v10 = v10 >> 8;
            v11 = v11 + 1;
        };
        0x1::vector::append<u8>(&mut v9, v4);
        0x1::vector::append<u8>(&mut arg0.data, v9);
        arg0.version = arg0.version + 1;
        let v12 = EpisodicAppend{
            memory_id    : 0x2::object::uid_to_inner(&arg0.id),
            actor        : arg2,
            version      : arg0.version,
            payload_size : v0,
            timestamp    : v3,
        };
        0x2::event::emit<EpisodicAppend>(v12);
    }

    public fun append_owner(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg3);
        assert!(arg0.schema_type == 0, 0);
        append_internal(arg0, arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun append_with_cap(arg0: &mut MemoryObject, arg1: &MemoryCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_valid_cap(arg1, arg0, 2, arg3);
        assert!(arg0.schema_type == 0, 0);
        let v0 = CapabilityUsed{
            cap_id    : 0x2::object::uid_to_inner(&arg1.id),
            memory_id : arg1.memory_id,
            actor     : 0x2::tx_context::sender(arg4),
            operation : 2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapabilityUsed>(v0);
        append_internal(arg0, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    fun assert_is_owner(arg0: &MemoryObject, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 5);
    }

    fun assert_valid_cap(arg0: &MemoryCap, arg1: &MemoryObject, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(arg0.memory_id == 0x2::object::uid_to_inner(&arg1.id), 1);
        assert!(arg0.permissions & arg2 == arg2, 2);
        assert!(arg0.issued_epoch == arg1.cap_epoch, 2);
        if (0x1::option::is_some<u64>(&arg0.expiry)) {
            assert!(0x2::clock::timestamp_ms(arg3) < *0x1::option::borrow<u64>(&arg0.expiry), 3);
        };
    }

    entry fun cap_append(arg0: &mut MemoryObject, arg1: &MemoryCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_valid_cap(arg1, arg0, 2, arg3);
        assert!(arg0.schema_type == 0, 0);
        let v0 = CapabilityUsed{
            cap_id    : 0x2::object::uid_to_inner(&arg1.id),
            memory_id : arg1.memory_id,
            actor     : 0x2::tx_context::sender(arg4),
            operation : 2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapabilityUsed>(v0);
        append_internal(arg0, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun cap_created_at(arg0: &MemoryCap) : u64 {
        arg0.created_at
    }

    public fun cap_expiry(arg0: &MemoryCap) : 0x1::option::Option<u64> {
        arg0.expiry
    }

    public fun cap_get_data(arg0: &MemoryObject, arg1: &MemoryCap, arg2: &0x2::clock::Clock) : &vector<u8> {
        assert_valid_cap(arg1, arg0, 1, arg2);
        &arg0.data
    }

    public fun cap_has_permission(arg0: &MemoryCap, arg1: u8) : bool {
        arg0.permissions & arg1 == arg1
    }

    public fun cap_is_expired(arg0: &MemoryCap, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<u64>(&arg0.expiry) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.expiry)
    }

    public fun cap_is_valid(arg0: &MemoryCap, arg1: &MemoryObject, arg2: u8, arg3: &0x2::clock::Clock) : bool {
        if (arg0.memory_id != 0x2::object::uid_to_inner(&arg1.id)) {
            return false
        };
        if (arg0.permissions & arg2 != arg2) {
            return false
        };
        if (arg0.issued_epoch != arg1.cap_epoch) {
            return false
        };
        0x1::option::is_some<u64>(&arg0.expiry) && 0x2::clock::timestamp_ms(arg3) < *0x1::option::borrow<u64>(&arg0.expiry) || true
    }

    public fun cap_memory_id(arg0: &MemoryCap) : 0x2::object::ID {
        arg0.memory_id
    }

    public fun cap_permissions(arg0: &MemoryCap) : u8 {
        arg0.permissions
    }

    entry fun cap_update(arg0: &mut MemoryObject, arg1: &MemoryCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_valid_cap(arg1, arg0, 4, arg4);
        assert!(arg0.schema_type == 1, 0);
        let v0 = CapabilityUsed{
            cap_id    : 0x2::object::uid_to_inner(&arg1.id),
            memory_id : arg1.memory_id,
            actor     : 0x2::tx_context::sender(arg5),
            operation : 4,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CapabilityUsed>(v0);
        update_internal(arg0, arg2, arg3, 0x2::tx_context::sender(arg5), arg4);
    }

    entry fun create_episodic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_episodic(arg0, arg1);
        0x2::transfer::transfer<MemoryObject>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun create_semantic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_semantic(arg0, arg1);
        0x2::transfer::transfer<MemoryObject>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun create_shared_episodic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MemoryObject>(new_episodic(arg0, arg1));
    }

    entry fun create_shared_semantic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MemoryObject>(new_semantic(arg0, arg1));
    }

    entry fun delegate(arg0: &MemoryObject, arg1: address, arg2: u8, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg5);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = new_cap(v0, arg2, arg3, arg0.cap_epoch, arg4, arg5);
        let v2 = CapabilityDelegated{
            cap_id      : 0x2::object::uid_to_inner(&v1.id),
            memory_id   : v0,
            grantor     : 0x2::tx_context::sender(arg5),
            grantee     : arg1,
            permissions : arg2,
            expiry      : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CapabilityDelegated>(v2);
        0x2::transfer::transfer<MemoryCap>(v1, arg1);
    }

    entry fun delegate_append(arg0: &MemoryObject, arg1: address, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delegate(arg0, arg1, 1 | 2, arg2, arg3, arg4);
    }

    entry fun delegate_full(arg0: &MemoryObject, arg1: address, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delegate(arg0, arg1, 1 | 2 | 4, arg2, arg3, arg4);
    }

    entry fun delegate_read(arg0: &MemoryObject, arg1: address, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delegate(arg0, arg1, 1, arg2, arg3, arg4);
    }

    entry fun delegate_update(arg0: &MemoryObject, arg1: address, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delegate(arg0, arg1, 1 | 4, arg2, arg3, arg4);
    }

    entry fun destroy(arg0: MemoryObject, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 5);
        let MemoryObject {
            id          : v0,
            owner       : _,
            schema_type : _,
            data        : _,
            version     : v4,
            created_at  : _,
            cap_epoch   : _,
        } = arg0;
        let v7 = v0;
        let v8 = MemoryDestroyed{
            memory_id     : 0x2::object::uid_to_inner(&v7),
            final_version : v4,
        };
        0x2::event::emit<MemoryDestroyed>(v8);
        0x2::object::delete(v7);
    }

    public fun get_created_at(arg0: &MemoryObject) : u64 {
        arg0.created_at
    }

    public fun get_data_for_owner(arg0: &MemoryObject, arg1: &0x2::tx_context::TxContext) : &vector<u8> {
        assert_is_owner(arg0, arg1);
        &arg0.data
    }

    public fun get_id(arg0: &MemoryObject) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_owner(arg0: &MemoryObject) : address {
        arg0.owner
    }

    public fun get_schema_type(arg0: &MemoryObject) : u8 {
        arg0.schema_type
    }

    public fun get_version(arg0: &MemoryObject) : u64 {
        arg0.version
    }

    public fun is_episodic(arg0: &MemoryObject) : bool {
        arg0.schema_type == 0
    }

    public fun is_semantic(arg0: &MemoryObject) : bool {
        arg0.schema_type == 1
    }

    fun new_cap(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MemoryCap {
        assert!(arg1 > 0 && arg1 <= 7, 4);
        MemoryCap{
            id           : 0x2::object::new(arg5),
            memory_id    : arg0,
            permissions  : arg1,
            expiry       : arg2,
            created_at   : 0x2::clock::timestamp_ms(arg4),
            issued_epoch : arg3,
        }
    }

    fun new_episodic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : MemoryObject {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = MemoryCreated{
            memory_id   : 0x2::object::uid_to_inner(&v0),
            schema_type : 0,
            owner       : v1,
            created_at  : v2,
        };
        0x2::event::emit<MemoryCreated>(v3);
        MemoryObject{
            id          : v0,
            owner       : v1,
            schema_type : 0,
            data        : 0x1::vector::empty<u8>(),
            version     : 0,
            created_at  : v2,
            cap_epoch   : 0,
        }
    }

    fun new_semantic(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : MemoryObject {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = MemoryCreated{
            memory_id   : 0x2::object::uid_to_inner(&v0),
            schema_type : 1,
            owner       : v1,
            created_at  : v2,
        };
        0x2::event::emit<MemoryCreated>(v3);
        MemoryObject{
            id          : v0,
            owner       : v1,
            schema_type : 1,
            data        : 0x1::vector::empty<u8>(),
            version     : 0,
            created_at  : v2,
            cap_epoch   : 0,
        }
    }

    entry fun revoke(arg0: MemoryCap, arg1: &0x2::tx_context::TxContext) {
        let MemoryCap {
            id           : v0,
            memory_id    : v1,
            permissions  : _,
            expiry       : _,
            created_at   : _,
            issued_epoch : _,
        } = arg0;
        let v6 = v0;
        let v7 = CapabilityRevoked{
            cap_id     : 0x2::object::uid_to_inner(&v6),
            memory_id  : v1,
            revoked_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CapabilityRevoked>(v7);
        0x2::object::delete(v6);
    }

    entry fun revoke_all_caps(arg0: &mut MemoryObject, arg1: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg1);
        arg0.cap_epoch = arg0.cap_epoch + 1;
    }

    entry fun transfer_ownership(arg0: &mut MemoryObject, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg2);
        arg0.owner = arg1;
        arg0.cap_epoch = arg0.cap_epoch + 1;
    }

    entry fun update(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg4);
        assert!(arg0.schema_type == 1, 0);
        update_internal(arg0, arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    fun update_internal(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock) {
        let v0 = (0x1::vector::length<u8>(&arg1) as u64);
        let v1 = (0x1::vector::length<u8>(&arg2) as u64);
        assert!(v0 <= 4294967295, 6);
        assert!(v1 <= 4294967295, 6);
        let v2 = 4 + v0 + 4 + v1 + 8;
        assert!(v2 <= 4294967295, 6);
        let v3 = 4 + v2;
        assert!(v3 <= 65536, 7);
        assert!((0x1::vector::length<u8>(&arg0.data) as u64) + v3 <= 1048576, 8);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 4) {
            0x1::vector::push_back<u8>(&mut v5, ((v0 & 255) as u8));
            v0 = v0 >> 8;
            v6 = v6 + 1;
        };
        0x1::vector::append<u8>(&mut v5, arg1);
        let v7 = 0;
        while (v7 < 4) {
            0x1::vector::push_back<u8>(&mut v5, ((v1 & 255) as u8));
            v1 = v1 >> 8;
            v7 = v7 + 1;
        };
        0x1::vector::append<u8>(&mut v5, arg2);
        let v8 = 0;
        while (v8 < 8) {
            0x1::vector::push_back<u8>(&mut v5, ((v4 & 255) as u8));
            v4 = v4 >> 8;
            v8 = v8 + 1;
        };
        let v9 = 0x1::vector::empty<u8>();
        let v10 = (0x1::vector::length<u8>(&v5) as u64);
        let v11 = 0;
        while (v11 < 4) {
            0x1::vector::push_back<u8>(&mut v9, ((v10 & 255) as u8));
            v10 = v10 >> 8;
            v11 = v11 + 1;
        };
        0x1::vector::append<u8>(&mut v9, v5);
        0x1::vector::append<u8>(&mut arg0.data, v9);
        arg0.version = arg0.version + 1;
        let v12 = SemanticUpdate{
            memory_id : 0x2::object::uid_to_inner(&arg0.id),
            actor     : arg3,
            version   : arg0.version,
            key_hash  : 0x1::hash::sha2_256(arg1),
            timestamp : v4,
        };
        0x2::event::emit<SemanticUpdate>(v12);
    }

    public fun update_owner(arg0: &mut MemoryObject, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, arg4);
        assert!(arg0.schema_type == 1, 0);
        update_internal(arg0, arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun update_with_cap(arg0: &mut MemoryObject, arg1: &MemoryCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_valid_cap(arg1, arg0, 4, arg4);
        assert!(arg0.schema_type == 1, 0);
        let v0 = CapabilityUsed{
            cap_id    : 0x2::object::uid_to_inner(&arg1.id),
            memory_id : arg1.memory_id,
            actor     : 0x2::tx_context::sender(arg5),
            operation : 4,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CapabilityUsed>(v0);
        update_internal(arg0, arg2, arg3, 0x2::tx_context::sender(arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

