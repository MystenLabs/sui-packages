module 0x6b035ab5dc61b2479ca9c2c07c1bccd2e87d0e74cf1f15f4a47d0df26cf7e68::registry {
    struct ProofRecord has store, key {
        id: 0x2::object::UID,
        file_hash: 0x1::string::String,
        issuer: address,
        created_at: u64,
        status: u8,
        reference_id: 0x1::string::String,
        file_type: 0x1::string::String,
        metadata_hash: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RegisterSignatureEvent has copy, drop {
        object_id: address,
        file_hash: 0x1::string::String,
        issuer: address,
        created_at: u64,
        reference_id: 0x1::string::String,
        file_type: 0x1::string::String,
    }

    struct RevokeSignatureEvent has copy, drop {
        object_id: address,
        file_hash: 0x1::string::String,
        issuer: address,
        revoked_by: address,
        revoked_at: u64,
    }

    public entry fun admin_revoke_signature(arg0: &AdminCap, arg1: &mut ProofRecord, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status != 2, 1002);
        arg1.status = 2;
        let v0 = RevokeSignatureEvent{
            object_id  : 0x2::object::uid_to_address(&arg1.id),
            file_hash  : arg1.file_hash,
            issuer     : arg1.issuer,
            revoked_by : 0x2::tx_context::sender(arg3),
            revoked_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RevokeSignatureEvent>(v0);
    }

    public fun get_created_at(arg0: &ProofRecord) : u64 {
        arg0.created_at
    }

    public fun get_file_hash(arg0: &ProofRecord) : &0x1::string::String {
        &arg0.file_hash
    }

    public fun get_file_type(arg0: &ProofRecord) : &0x1::string::String {
        &arg0.file_type
    }

    public fun get_issuer(arg0: &ProofRecord) : address {
        arg0.issuer
    }

    public fun get_reference_id(arg0: &ProofRecord) : &0x1::string::String {
        &arg0.reference_id
    }

    public fun get_status(arg0: &ProofRecord) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_revoked(arg0: &ProofRecord) : bool {
        arg0.status == 2
    }

    public fun is_valid(arg0: &ProofRecord) : bool {
        arg0.status == 1
    }

    public entry fun register_signature(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 1003);
        assert!(0x1::string::length(&arg0) == 64, 1004);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = ProofRecord{
            id            : 0x2::object::new(arg5),
            file_hash     : arg0,
            issuer        : v0,
            created_at    : v1,
            status        : 1,
            reference_id  : arg1,
            file_type     : arg2,
            metadata_hash : arg3,
        };
        let v3 = RegisterSignatureEvent{
            object_id    : 0x2::object::uid_to_address(&v2.id),
            file_hash    : v2.file_hash,
            issuer       : v0,
            created_at   : v1,
            reference_id : v2.reference_id,
            file_type    : v2.file_type,
        };
        0x2::event::emit<RegisterSignatureEvent>(v3);
        0x2::transfer::transfer<ProofRecord>(v2, v0);
    }

    public entry fun revoke_signature(arg0: &mut ProofRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.issuer, 1001);
        assert!(arg0.status != 2, 1002);
        arg0.status = 2;
        let v1 = RevokeSignatureEvent{
            object_id  : 0x2::object::uid_to_address(&arg0.id),
            file_hash  : arg0.file_hash,
            issuer     : arg0.issuer,
            revoked_by : v0,
            revoked_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RevokeSignatureEvent>(v1);
    }

    public fun status_revoked() : u8 {
        2
    }

    public fun status_valid() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

