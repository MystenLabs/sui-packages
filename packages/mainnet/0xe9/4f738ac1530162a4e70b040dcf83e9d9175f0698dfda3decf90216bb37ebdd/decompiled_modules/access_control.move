module 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::access_control {
    struct AccessPolicy has key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        name: 0x1::string::String,
        authorized_readers: vector<address>,
        created_by: address,
    }

    struct AccessPolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct AccessPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        document_id: 0x2::object::ID,
        created_by: address,
    }

    struct ReaderAdded has copy, drop {
        policy_id: 0x2::object::ID,
        reader: address,
    }

    struct ReaderRevoked has copy, drop {
        policy_id: 0x2::object::ID,
        reader: address,
    }

    struct BlobPublished has copy, drop {
        policy_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    public fun create_policy(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : AccessPolicyCap {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AccessPolicy{
            id                 : v0,
            document_id        : arg0,
            name               : arg1,
            authorized_readers : arg2,
            created_by         : 0x2::tx_context::sender(arg3),
        };
        let v3 = AccessPolicyCap{
            id        : 0x2::object::new(arg3),
            policy_id : v1,
        };
        let v4 = AccessPolicyCreated{
            policy_id   : v1,
            document_id : arg0,
            created_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AccessPolicyCreated>(v4);
        0x2::transfer::share_object<AccessPolicy>(v2);
        v3
    }

    entry fun create_policy_entry(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_policy(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<AccessPolicyCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_authorized_readers(arg0: &AccessPolicy) : vector<address> {
        arg0.authorized_readers
    }

    public fun get_created_by(arg0: &AccessPolicy) : address {
        arg0.created_by
    }

    public fun get_document_id(arg0: &AccessPolicy) : 0x2::object::ID {
        arg0.document_id
    }

    public fun get_namespace(arg0: &AccessPolicy) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun get_policy_id(arg0: &AccessPolicy) : 0x2::object::ID {
        0x2::object::id<AccessPolicy>(arg0)
    }

    public fun get_policy_name(arg0: &AccessPolicy) : 0x1::string::String {
        arg0.name
    }

    public fun get_reader_count(arg0: &AccessPolicy) : u64 {
        0x1::vector::length<address>(&arg0.authorized_readers)
    }

    public fun grant_access(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<AccessPolicy>(arg0), 0);
        assert!(!0x1::vector::contains<address>(&arg0.authorized_readers, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg0.authorized_readers, arg2);
        let v0 = ReaderAdded{
            policy_id : 0x2::object::id<AccessPolicy>(arg0),
            reader    : arg2,
        };
        0x2::event::emit<ReaderAdded>(v0);
    }

    fun has_access_internal(arg0: address, arg1: vector<u8>, arg2: &AccessPolicy) : bool {
        if (!is_prefix(get_namespace(arg2), arg1)) {
            return false
        };
        0x1::vector::contains<address>(&arg2.authorized_readers, &arg0)
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

    public fun is_reader_authorized(arg0: &AccessPolicy, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_readers, &arg1)
    }

    public fun publish_blob(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: 0x1::string::String) {
        assert!(arg1.policy_id == 0x2::object::id<AccessPolicy>(arg0), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, arg2, 4);
        let v0 = BlobPublished{
            policy_id : 0x2::object::id<AccessPolicy>(arg0),
            blob_id   : arg2,
        };
        0x2::event::emit<BlobPublished>(v0);
    }

    public fun revoke_access(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<AccessPolicy>(arg0), 0);
        let v0 = vector[];
        let v1 = arg0.authorized_readers;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            if (&v3 != &arg2) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        arg0.authorized_readers = v0;
        let v4 = ReaderRevoked{
            policy_id : 0x2::object::id<AccessPolicy>(arg0),
            reader    : arg2,
        };
        0x2::event::emit<ReaderRevoked>(v4);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access_internal(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    public fun verify_read_permission(arg0: &AccessPolicy, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_readers, &arg1)
    }

    // decompiled from Move bytecode v6
}

