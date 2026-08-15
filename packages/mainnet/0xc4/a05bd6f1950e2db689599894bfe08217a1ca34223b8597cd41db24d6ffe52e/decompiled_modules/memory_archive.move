module 0x681b894c304cf148494cf2f1ab792e918cd83e510cb7fe2e912b5098d855851d::memory_archive {
    struct ArchivePolicy has key {
        id: 0x2::object::UID,
        archive_fee_mist: u64,
        treasury: address,
        version: u64,
        admin_cap_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Memory<T0: store + key> has key {
        id: 0x2::object::UID,
        artifact: T0,
        archived_by: address,
        archived_at_ms: u64,
        message: 0x1::string::String,
        sealer_signature: 0x1::string::String,
        image_url: 0x1::string::String,
        image_hash: vector<u8>,
        source_type: u8,
        storage_type: u8,
        artifact_id: 0x2::object::ID,
    }

    struct ArchiveEntry has key {
        id: 0x2::object::UID,
        archive_id: 0x2::object::ID,
        artifact_id: 0x2::object::ID,
        archived_by: address,
        archived_at_ms: u64,
        source_type: u8,
        storage_type: u8,
    }

    struct MemoryArchived has copy, drop {
        archive_id: 0x2::object::ID,
        original_object_id: 0x2::object::ID,
        archived_by: address,
        archived_at_ms: u64,
        storage_type: u8,
        source_type: u8,
        artifact_id: 0x2::object::ID,
    }

    struct PolicyUpdated has copy, drop {
        archive_fee_mist: u64,
        treasury: address,
        version: u64,
    }

    public fun archive_fee_mist(arg0: &ArchivePolicy) : u64 {
        arg0.archive_fee_mist
    }

    public fun archive_forever<T0: store + key>(arg0: &ArchivePolicy, arg1: T0, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: u8, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate_metadata(&arg3, &arg4, &arg5, &arg6, arg7, arg8);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.archive_fee_mist, 1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = Memory<T0>{
            id               : 0x2::object::new(arg10),
            artifact         : arg1,
            archived_by      : v0,
            archived_at_ms   : v1,
            message          : arg3,
            sealer_signature : arg4,
            image_url        : arg5,
            image_hash       : arg6,
            source_type      : arg7,
            storage_type     : arg8,
            artifact_id      : v2,
        };
        let v4 = 0x2::object::id<Memory<T0>>(&v3);
        let v5 = ArchiveEntry{
            id             : 0x2::object::new(arg10),
            archive_id     : v4,
            artifact_id    : v2,
            archived_by    : v0,
            archived_at_ms : v1,
            source_type    : arg7,
            storage_type   : arg8,
        };
        if (arg0.archive_fee_mist > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg0.archive_fee_mist, arg10), arg0.treasury);
        };
        let v6 = MemoryArchived{
            archive_id         : v4,
            original_object_id : v2,
            archived_by        : v0,
            archived_at_ms     : v1,
            storage_type       : arg8,
            source_type        : arg7,
            artifact_id        : v2,
        };
        0x2::event::emit<MemoryArchived>(v6);
        0x2::transfer::freeze_object<ArchiveEntry>(v5);
        0x2::transfer::freeze_object<Memory<T0>>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ArchivePolicy{
            id               : 0x2::object::new(arg0),
            archive_fee_mist : 0,
            treasury         : 0x2::tx_context::sender(arg0),
            version          : 1,
            admin_cap_id     : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ArchivePolicy>(v1);
    }

    public fun policy_version(arg0: &ArchivePolicy) : u64 {
        arg0.version
    }

    public fun source_online() : u8 {
        1
    }

    public fun source_original() : u8 {
        0
    }

    public fun source_uploaded() : u8 {
        2
    }

    public fun storage_arweave() : u8 {
        3
    }

    public fun storage_external() : u8 {
        1
    }

    public fun storage_ipfs() : u8 {
        2
    }

    public fun storage_none() : u8 {
        0
    }

    public fun treasury(arg0: &ArchivePolicy) : address {
        arg0.treasury
    }

    public fun update_policy(arg0: &mut ArchivePolicy, arg1: &AdminCap, arg2: u64, arg3: address) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 0);
        assert!(arg3 != @0x0, 9);
        arg0.archive_fee_mist = arg2;
        arg0.treasury = arg3;
        arg0.version = arg0.version + 1;
        let v0 = PolicyUpdated{
            archive_fee_mist : arg2,
            treasury         : arg3,
            version          : arg0.version,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    fun validate_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &vector<u8>, arg4: u8, arg5: u8) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) <= 16384, 2);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg1)) <= 16384, 3);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg2)) <= 16384, 4);
        assert!(arg5 <= 3, 5);
        assert!(arg4 <= 2, 5);
        if (arg5 == 0) {
            assert!(arg4 == 0, 10);
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg2)), 6);
            assert!(0x1::vector::is_empty<u8>(arg3), 6);
        } else {
            assert!(!0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg2)), 7);
            if (arg4 != 0) {
                assert!(0x1::vector::length<u8>(arg3) == 32, 8);
            };
            if (arg4 == 1) {
                assert!(arg5 == 1, 10);
            };
        };
    }

    // decompiled from Move bytecode v7
}

