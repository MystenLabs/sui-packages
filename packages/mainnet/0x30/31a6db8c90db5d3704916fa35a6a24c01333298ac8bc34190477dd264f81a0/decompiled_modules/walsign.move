module 0x3031a6db8c90db5d3704916fa35a6a24c01333298ac8bc34190477dd264f81a0::walsign {
    struct SigningRequest has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        blob_id: 0x1::string::String,
        document_hash: 0x1::string::String,
        creator: address,
        required_signers: vector<address>,
        signed_by: vector<address>,
        created_at: u64,
        completed: bool,
        revoked: bool,
        message: 0x1::string::String,
    }

    struct RequestCreated has copy, drop {
        request_id: address,
        creator: address,
        blob_id: 0x1::string::String,
        document_hash: 0x1::string::String,
        title: 0x1::string::String,
        signer_count: u64,
        created_at: u64,
    }

    struct DocumentSigned has copy, drop {
        request_id: address,
        signer: address,
        signed_at: u64,
        total_signed: u64,
        total_required: u64,
        completed: bool,
    }

    struct RequestRevoked has copy, drop {
        request_id: address,
        creator: address,
        revoked_at: u64,
    }

    public entry fun create_request(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<address>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = SigningRequest{
            id               : 0x2::object::new(arg6),
            title            : arg0,
            blob_id          : arg1,
            document_hash    : arg2,
            creator          : v0,
            required_signers : arg3,
            signed_by        : 0x1::vector::empty<address>(),
            created_at       : v1,
            completed        : false,
            revoked          : false,
            message          : arg4,
        };
        let v3 = RequestCreated{
            request_id    : 0x2::object::uid_to_address(&v2.id),
            creator       : v0,
            blob_id       : v2.blob_id,
            document_hash : v2.document_hash,
            title         : v2.title,
            signer_count  : 0x1::vector::length<address>(&arg3),
            created_at    : v1,
        };
        0x2::event::emit<RequestCreated>(v3);
        0x2::transfer::share_object<SigningRequest>(v2);
    }

    public fun get_blob_id(arg0: &SigningRequest) : &0x1::string::String {
        &arg0.blob_id
    }

    public fun get_creator(arg0: &SigningRequest) : address {
        arg0.creator
    }

    public fun get_document_hash(arg0: &SigningRequest) : &0x1::string::String {
        &arg0.document_hash
    }

    public fun has_signed(arg0: &SigningRequest, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.signed_by, &arg1)
    }

    public fun is_completed(arg0: &SigningRequest) : bool {
        arg0.completed
    }

    public fun is_required_signer(arg0: &SigningRequest, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.required_signers, &arg1)
    }

    public fun is_revoked(arg0: &SigningRequest) : bool {
        arg0.revoked
    }

    public fun required_count(arg0: &SigningRequest) : u64 {
        0x1::vector::length<address>(&arg0.required_signers)
    }

    public entry fun revoke(arg0: &mut SigningRequest, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
        assert!(!arg0.completed, 5);
        arg0.revoked = true;
        let v0 = RequestRevoked{
            request_id : 0x2::object::uid_to_address(&arg0.id),
            creator    : arg0.creator,
            revoked_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RequestRevoked>(v0);
    }

    public entry fun sign(arg0: &mut SigningRequest, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.revoked, 3);
        assert!(!arg0.completed, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.required_signers, &v0), 1);
        assert!(!0x1::vector::contains<address>(&arg0.signed_by, &v0), 2);
        0x1::vector::push_back<address>(&mut arg0.signed_by, v0);
        let v1 = 0x1::vector::length<address>(&arg0.signed_by);
        let v2 = 0x1::vector::length<address>(&arg0.required_signers);
        if (v1 == v2) {
            arg0.completed = true;
        };
        let v3 = DocumentSigned{
            request_id     : 0x2::object::uid_to_address(&arg0.id),
            signer         : v0,
            signed_at      : 0x2::clock::timestamp_ms(arg1),
            total_signed   : v1,
            total_required : v2,
            completed      : arg0.completed,
        };
        0x2::event::emit<DocumentSigned>(v3);
    }

    public fun signed_count(arg0: &SigningRequest) : u64 {
        0x1::vector::length<address>(&arg0.signed_by)
    }

    // decompiled from Move bytecode v6
}

