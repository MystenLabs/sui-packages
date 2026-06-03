module 0x5a8db6902e1c026bac025be39a912d3a64862fc8c41f64912bf42e1b9157656e::attestation {
    struct Attestation has store, key {
        id: 0x2::object::UID,
        document_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        uploader: address,
        upload_timestamp: u64,
        status: u8,
        auditor: 0x1::option::Option<address>,
        audit_timestamp: 0x1::option::Option<u64>,
    }

    struct AttestationRegistry has key {
        id: 0x2::object::UID,
        attestations: vector<0x2::object::ID>,
    }

    public entry fun approve_attestation(arg0: &mut Attestation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        arg0.status = 1;
        arg0.auditor = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        arg0.audit_timestamp = 0x1::option::some<u64>(arg1);
    }

    public entry fun create_attestation(arg0: &mut AttestationRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Attestation{
            id               : 0x2::object::new(arg5),
            document_name    : arg1,
            blob_id          : arg2,
            file_hash        : arg3,
            uploader         : v0,
            upload_timestamp : arg4,
            status           : 0,
            auditor          : 0x1::option::none<address>(),
            audit_timestamp  : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.attestations, 0x2::object::id<Attestation>(&v1));
        0x2::transfer::public_transfer<Attestation>(v1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttestationRegistry{
            id           : 0x2::object::new(arg0),
            attestations : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<AttestationRegistry>(v0);
    }

    // decompiled from Move bytecode v7
}

