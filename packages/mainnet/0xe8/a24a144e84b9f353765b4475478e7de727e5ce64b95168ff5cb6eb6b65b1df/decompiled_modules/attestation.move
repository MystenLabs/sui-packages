module 0xe8a24a144e84b9f353765b4475478e7de727e5ce64b95168ff5cb6eb6b65b1df::attestation {
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
        let v0 = Attestation{
            id               : 0x2::object::new(arg5),
            document_name    : arg1,
            blob_id          : arg2,
            file_hash        : arg3,
            uploader         : 0x2::tx_context::sender(arg5),
            upload_timestamp : arg4,
            status           : 0,
            auditor          : 0x1::option::none<address>(),
            audit_timestamp  : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.attestations, 0x2::object::id<Attestation>(&v0));
        0x2::transfer::share_object<Attestation>(v0);
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

