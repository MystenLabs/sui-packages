module 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::quilt_registry {
    struct QuiltRegistry has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        quilts: 0x2::table::Table<vector<u8>, QuiltInfo>,
        quilt_ids: vector<vector<u8>>,
        total_memories: u64,
        created_at: u64,
    }

    struct QuiltRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct QuiltInfo has copy, drop, store {
        blob_id: vector<u8>,
        certified_epoch: u64,
        expires_epoch: u64,
        memory_count: u64,
        encrypted: bool,
        seal_id: vector<u8>,
        created_at: u64,
        quilt_url: vector<u8>,
    }

    struct QuiltRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct QuiltRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        blob_id: vector<u8>,
        memory_count: u64,
        expires_epoch: u64,
        encrypted: bool,
    }

    struct QuiltRenewed has copy, drop {
        registry_id: 0x2::object::ID,
        blob_id: vector<u8>,
        old_expires: u64,
        new_expires: u64,
    }

    struct AllQuiltsRenewed has copy, drop {
        registry_id: 0x2::object::ID,
        quilts_renewed: u64,
        new_expires_epoch: u64,
    }

    public fun create_registry(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVaultOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (QuiltRegistry, QuiltRegistryCap) {
        assert!(0x2::object::id<0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault>(arg0) == 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::vault_owner_cap_for(arg1), 2);
        let v0 = QuiltRegistry{
            id             : 0x2::object::new(arg3),
            vault_id       : 0x2::object::id<0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault>(arg0),
            quilts         : 0x2::table::new<vector<u8>, QuiltInfo>(arg3),
            quilt_ids      : 0x1::vector::empty<vector<u8>>(),
            total_memories : 0,
            created_at     : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = 0x2::object::id<QuiltRegistry>(&v0);
        let v2 = QuiltRegistryCap{
            id  : 0x2::object::new(arg3),
            for : v1,
        };
        let v3 = QuiltRegistryCreated{
            registry_id : v1,
            vault_id    : 0x2::object::id<0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault>(arg0),
            owner       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<QuiltRegistryCreated>(v3);
        (v0, v2)
    }

    public fun get_expiring_count(arg0: &QuiltRegistry, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.quilt_ids)) {
            let v2 = 0x2::table::borrow<vector<u8>, QuiltInfo>(&arg0.quilts, *0x1::vector::borrow<vector<u8>>(&arg0.quilt_ids, v1));
            let v3 = if (v2.expires_epoch > arg1) {
                v2.expires_epoch - arg1
            } else {
                0
            };
            if (v3 > 0 && v3 <= arg2) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_quilt(arg0: &QuiltRegistry, arg1: vector<u8>) : &QuiltInfo {
        0x2::table::borrow<vector<u8>, QuiltInfo>(&arg0.quilts, arg1)
    }

    public fun has_quilt(arg0: &QuiltRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, QuiltInfo>(&arg0.quilts, arg1)
    }

    public fun quilt_expires_epoch(arg0: &QuiltInfo) : u64 {
        arg0.expires_epoch
    }

    public fun quilt_is_encrypted(arg0: &QuiltInfo) : bool {
        arg0.encrypted
    }

    public fun quilt_memory_count(arg0: &QuiltInfo) : u64 {
        arg0.memory_count
    }

    public fun quilt_seal_id(arg0: &QuiltInfo) : vector<u8> {
        arg0.seal_id
    }

    public fun quilt_url(arg0: &QuiltInfo) : vector<u8> {
        arg0.quilt_url
    }

    public fun register_quilt(arg0: &mut QuiltRegistry, arg1: &QuiltRegistryCap, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(0x2::object::id<QuiltRegistry>(arg0) == arg1.for, 2);
        assert!(arg4 > arg3, 3);
        let v0 = QuiltInfo{
            blob_id         : arg2,
            certified_epoch : arg3,
            expires_epoch   : arg4,
            memory_count    : arg5,
            encrypted       : arg6,
            seal_id         : arg7,
            created_at      : 0x2::clock::timestamp_ms(arg8),
            quilt_url       : 0x1::vector::empty<u8>(),
        };
        0x2::table::add<vector<u8>, QuiltInfo>(&mut arg0.quilts, arg2, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.quilt_ids, arg2);
        arg0.total_memories = arg0.total_memories + arg5;
        let v1 = QuiltRegistered{
            registry_id   : 0x2::object::id<QuiltRegistry>(arg0),
            blob_id       : arg2,
            memory_count  : arg5,
            expires_epoch : arg4,
            encrypted     : arg6,
        };
        0x2::event::emit<QuiltRegistered>(v1);
    }

    public fun register_quilt_with_url(arg0: &mut QuiltRegistry, arg1: &QuiltRegistryCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        assert!(0x2::object::id<QuiltRegistry>(arg0) == arg1.for, 2);
        assert!(arg5 > arg4, 3);
        let v0 = QuiltInfo{
            blob_id         : arg2,
            certified_epoch : arg4,
            expires_epoch   : arg5,
            memory_count    : arg6,
            encrypted       : arg7,
            seal_id         : arg8,
            created_at      : 0x2::clock::timestamp_ms(arg9),
            quilt_url       : arg3,
        };
        0x2::table::add<vector<u8>, QuiltInfo>(&mut arg0.quilts, arg2, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.quilt_ids, arg2);
        arg0.total_memories = arg0.total_memories + arg6;
        let v1 = QuiltRegistered{
            registry_id   : 0x2::object::id<QuiltRegistry>(arg0),
            blob_id       : arg2,
            memory_count  : arg6,
            expires_epoch : arg5,
            encrypted     : arg7,
        };
        0x2::event::emit<QuiltRegistered>(v1);
    }

    public fun renew_all(arg0: &mut QuiltRegistry, arg1: &QuiltRegistryCap, arg2: u64) {
        assert!(0x2::object::id<QuiltRegistry>(arg0) == arg1.for, 2);
        let v0 = 0x1::vector::length<vector<u8>>(&arg0.quilt_ids);
        let v1 = 0;
        while (v1 < v0) {
            0x2::table::borrow_mut<vector<u8>, QuiltInfo>(&mut arg0.quilts, *0x1::vector::borrow<vector<u8>>(&arg0.quilt_ids, v1)).expires_epoch = arg2;
            v1 = v1 + 1;
        };
        let v2 = AllQuiltsRenewed{
            registry_id       : 0x2::object::id<QuiltRegistry>(arg0),
            quilts_renewed    : v0,
            new_expires_epoch : arg2,
        };
        0x2::event::emit<AllQuiltsRenewed>(v2);
    }

    public fun renew_quilt(arg0: &mut QuiltRegistry, arg1: &QuiltRegistryCap, arg2: vector<u8>, arg3: u64) {
        assert!(0x2::object::id<QuiltRegistry>(arg0) == arg1.for, 2);
        assert!(0x2::table::contains<vector<u8>, QuiltInfo>(&arg0.quilts, arg2), 0);
        let v0 = 0x2::table::borrow_mut<vector<u8>, QuiltInfo>(&mut arg0.quilts, arg2);
        let v1 = v0.expires_epoch;
        assert!(arg3 > v1, 3);
        v0.expires_epoch = arg3;
        let v2 = QuiltRenewed{
            registry_id : 0x2::object::id<QuiltRegistry>(arg0),
            blob_id     : arg2,
            old_expires : v1,
            new_expires : arg3,
        };
        0x2::event::emit<QuiltRenewed>(v2);
    }

    entry fun seal_approve_quilt(arg0: vector<u8>, arg1: &QuiltRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 == 0x2::object::id<QuiltRegistry>(arg1), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg4) < arg3, 1);
        assert!(0x2::table::contains<vector<u8>, QuiltInfo>(&arg1.quilts, arg0), 0);
        assert!(0x2::table::borrow<vector<u8>, QuiltInfo>(&arg1.quilts, arg0).encrypted, 2);
    }

    public fun total_memories(arg0: &QuiltRegistry) : u64 {
        arg0.total_memories
    }

    public fun total_quilts(arg0: &QuiltRegistry) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.quilt_ids)
    }

    public fun vault_id(arg0: &QuiltRegistry) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

