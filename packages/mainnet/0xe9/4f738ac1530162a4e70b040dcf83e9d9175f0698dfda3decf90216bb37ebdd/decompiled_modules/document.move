module 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::document {
    struct Document has store, key {
        id: 0x2::object::UID,
        walrus_blob_id: 0x1::string::String,
        seal_id: 0x1::string::String,
        owner: address,
        file_name: 0x1::string::String,
        file_size: u64,
        mime_type: 0x1::string::String,
        encryption_key_version: u64,
        signers: vector<Signer>,
        status: u8,
        final_blob_id: 0x1::string::String,
        final_key_version: u64,
        created_at_ms: u64,
        pipeline_id: 0x1::option::Option<0x2::object::ID>,
        access_policy_id: 0x1::option::Option<0x2::object::ID>,
        comment_thread_id: 0x1::option::Option<0x2::object::ID>,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct Signer has copy, drop, store {
        address: address,
        has_signed: bool,
        signature: vector<u8>,
        timestamp: u64,
    }

    struct SignerCap has store, key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        signer_address: address,
    }

    struct VerificationProof has store, key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        signers: vector<address>,
        signatures: vector<vector<u8>>,
        document_hash: vector<u8>,
        completion_timestamp: u64,
    }

    struct DocumentCreated has copy, drop {
        document_id: 0x2::object::ID,
        owner: address,
        walrus_blob_id: 0x1::string::String,
        signer_count: u64,
        created_at_ms: u64,
    }

    struct SignerAdded has copy, drop {
        document_id: 0x2::object::ID,
        signer_address: address,
    }

    struct DocumentSigned has copy, drop {
        document_id: 0x2::object::ID,
        signer: address,
        timestamp: u64,
    }

    struct DocumentCompleted has copy, drop {
        document_id: 0x2::object::ID,
        final_blob_id: 0x1::string::String,
        completion_timestamp: u64,
    }

    struct DocumentRejected has copy, drop {
        document_id: 0x2::object::ID,
        rejector: address,
        timestamp: u64,
    }

    struct DocumentCancelled has copy, drop {
        document_id: 0x2::object::ID,
        cancelled_by: address,
        timestamp: u64,
    }

    struct DocumentExpired has copy, drop {
        document_id: 0x2::object::ID,
        expired_at_ms: u64,
    }

    struct PipelineAttached has copy, drop {
        document_id: 0x2::object::ID,
        pipeline_id: 0x2::object::ID,
    }

    struct AccessPolicyAttached has copy, drop {
        document_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    struct CommentThreadAttached has copy, drop {
        document_id: 0x2::object::ID,
        thread_id: 0x2::object::ID,
    }

    struct ExpirationSet has copy, drop {
        document_id: 0x2::object::ID,
        expires_at_ms: u64,
    }

    public fun add_signer(arg0: &Document, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : SignerCap {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Signer>(&arg0.signers)) {
            if (0x1::vector::borrow<Signer>(&arg0.signers, v1).address == arg1) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 2);
        let v2 = 0x2::object::id<Document>(arg0);
        let v3 = SignerAdded{
            document_id    : v2,
            signer_address : arg1,
        };
        0x2::event::emit<SignerAdded>(v3);
        SignerCap{
            id             : 0x2::object::new(arg2),
            document_id    : v2,
            signer_address : arg1,
        }
    }

    public fun attach_access_policy(arg0: &mut Document, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.access_policy_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = AccessPolicyAttached{
            document_id : 0x2::object::id<Document>(arg0),
            policy_id   : arg1,
        };
        0x2::event::emit<AccessPolicyAttached>(v0);
    }

    public fun attach_comment_thread(arg0: &mut Document, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.comment_thread_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = CommentThreadAttached{
            document_id : 0x2::object::id<Document>(arg0),
            thread_id   : arg1,
        };
        0x2::event::emit<CommentThreadAttached>(v0);
    }

    public fun attach_pipeline(arg0: &mut Document, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.pipeline_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = PipelineAttached{
            document_id : 0x2::object::id<Document>(arg0),
            pipeline_id : arg1,
        };
        0x2::event::emit<PipelineAttached>(v0);
    }

    public fun cancel_document(arg0: &mut Document, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        assert!(arg0.status != 3, 5);
        arg0.status = 5;
        let v0 = DocumentCancelled{
            document_id  : 0x2::object::id<Document>(arg0),
            cancelled_by : 0x2::tx_context::sender(arg1),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DocumentCancelled>(v0);
    }

    fun check_all_signed(arg0: &Document) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Signer>(&arg0.signers)) {
            if (!0x1::vector::borrow<Signer>(&arg0.signers, v0).has_signed) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun check_expiration(arg0: &mut Document, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<u64>(&arg0.expires_at_ms)) {
            let v0 = 0x2::clock::timestamp_ms(arg1);
            if (v0 > *0x1::option::borrow<u64>(&arg0.expires_at_ms) && arg0.status == 1) {
                arg0.status = 6;
                let v1 = DocumentExpired{
                    document_id   : 0x2::object::id<Document>(arg0),
                    expired_at_ms : v0,
                };
                0x2::event::emit<DocumentExpired>(v1);
            };
        };
    }

    public fun complete_document(arg0: &mut Document, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg0.status == 3, 4);
        arg0.final_blob_id = arg1;
        arg0.final_key_version = arg2;
        let v0 = DocumentCompleted{
            document_id          : 0x2::object::id<Document>(arg0),
            final_blob_id        : arg1,
            completion_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DocumentCompleted>(v0);
    }

    public fun create_document(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) : Document {
        let v0 = 0x1::vector::length<address>(&arg6);
        assert!(v0 <= 50, 10);
        let v1 = 0x1::vector::empty<Signer>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg6, v2);
            let v4 = 0;
            while (v4 < v2) {
                assert!(v3 != *0x1::vector::borrow<address>(&arg6, v4), 9);
                v4 = v4 + 1;
            };
            let v5 = Signer{
                address    : v3,
                has_signed : false,
                signature  : 0x1::vector::empty<u8>(),
                timestamp  : 0,
            };
            0x1::vector::push_back<Signer>(&mut v1, v5);
            v2 = v2 + 1;
        };
        let v6 = 0x2::object::new(arg7);
        let v7 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        let v8 = DocumentCreated{
            document_id    : 0x2::object::uid_to_inner(&v6),
            owner          : 0x2::tx_context::sender(arg7),
            walrus_blob_id : arg0,
            signer_count   : v0,
            created_at_ms  : v7,
        };
        0x2::event::emit<DocumentCreated>(v8);
        Document{
            id                     : v6,
            walrus_blob_id         : arg0,
            seal_id                : arg1,
            owner                  : 0x2::tx_context::sender(arg7),
            file_name              : arg2,
            file_size              : arg3,
            mime_type              : arg4,
            encryption_key_version : arg5,
            signers                : v1,
            status                 : 0,
            final_blob_id          : 0x1::string::utf8(b""),
            final_key_version      : 0,
            created_at_ms          : v7,
            pipeline_id            : 0x1::option::none<0x2::object::ID>(),
            access_policy_id       : 0x1::option::none<0x2::object::ID>(),
            comment_thread_id      : 0x1::option::none<0x2::object::ID>(),
            expires_at_ms          : 0x1::option::none<u64>(),
        }
    }

    public fun error_already_signed() : u64 {
        3
    }

    public fun error_not_owner() : u64 {
        1
    }

    public fun error_not_signer() : u64 {
        2
    }

    public fun get_access_policy_id(arg0: &Document) : 0x1::option::Option<0x2::object::ID> {
        arg0.access_policy_id
    }

    public fun get_comment_thread_id(arg0: &Document) : 0x1::option::Option<0x2::object::ID> {
        arg0.comment_thread_id
    }

    public fun get_document_id(arg0: &Document) : 0x2::object::ID {
        0x2::object::id<Document>(arg0)
    }

    public fun get_expires_at(arg0: &Document) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun get_final_blob_id(arg0: &Document) : 0x1::string::String {
        arg0.final_blob_id
    }

    public fun get_owner(arg0: &Document) : address {
        arg0.owner
    }

    public fun get_pipeline_id(arg0: &Document) : 0x1::option::Option<0x2::object::ID> {
        arg0.pipeline_id
    }

    public fun get_signer_count(arg0: &Document) : u64 {
        0x1::vector::length<Signer>(&arg0.signers)
    }

    public fun get_status(arg0: &Document) : u8 {
        arg0.status
    }

    public fun get_walrus_blob_id(arg0: &Document) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public fun mint_verification_proof(arg0: &Document, arg1: &mut 0x2::tx_context::TxContext) : VerificationProof {
        assert!(arg0.status == 3, 5);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Signer>(&arg0.signers)) {
            let v3 = 0x1::vector::borrow<Signer>(&arg0.signers, v2);
            0x1::vector::push_back<address>(&mut v0, v3.address);
            0x1::vector::push_back<vector<u8>>(&mut v1, v3.signature);
            v2 = v2 + 1;
        };
        VerificationProof{
            id                   : 0x2::object::new(arg1),
            document_id          : 0x2::object::id<Document>(arg0),
            signers              : v0,
            signatures           : v1,
            document_hash        : 0x1::vector::empty<u8>(),
            completion_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        }
    }

    public fun reject_document(arg0: &mut Document, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Signer>(&arg0.signers)) {
            if (0x1::vector::borrow<Signer>(&arg0.signers, v2).address == v0) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 2);
        assert!(arg0.status != 3, 5);
        arg0.status = 4;
        let v3 = DocumentRejected{
            document_id : 0x2::object::id<Document>(arg0),
            rejector    : v0,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DocumentRejected>(v3);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Document, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::string::utf8(arg0) == arg1.seal_id, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg1.owner) {
            return
        } else {
            let v1 = 0;
            while (v1 < 0x1::vector::length<Signer>(&arg1.signers)) {
                if (0x1::vector::borrow<Signer>(&arg1.signers, v1).address == v0) {
                    return
                };
                v1 = v1 + 1;
            };
            abort 2
        };
    }

    public fun set_expiration(arg0: &mut Document, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.expires_at_ms = 0x1::option::some<u64>(arg1);
        let v0 = ExpirationSet{
            document_id   : 0x2::object::id<Document>(arg0),
            expires_at_ms : arg1,
        };
        0x2::event::emit<ExpirationSet>(v0);
    }

    public fun sign_document(arg0: &mut Document, arg1: &SignerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 4, 6);
        assert!(arg0.status != 5, 7);
        assert!(arg0.status != 6, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<Document>(arg0);
        assert!(arg1.document_id == v1, 2);
        assert!(arg1.signer_address == v0, 2);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Signer>(&arg0.signers)) {
            let v4 = 0x1::vector::borrow_mut<Signer>(&mut arg0.signers, v2);
            if (v4.address == v0) {
                assert!(!v4.has_signed, 3);
                v4.has_signed = true;
                v4.signature = arg2;
                v4.timestamp = 0x2::tx_context::epoch_timestamp_ms(arg3);
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 2);
        if (check_all_signed(arg0)) {
            arg0.status = 3;
        } else {
            arg0.status = 2;
        };
        let v5 = DocumentSigned{
            document_id : v1,
            signer      : v0,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DocumentSigned>(v5);
    }

    // decompiled from Move bytecode v6
}

