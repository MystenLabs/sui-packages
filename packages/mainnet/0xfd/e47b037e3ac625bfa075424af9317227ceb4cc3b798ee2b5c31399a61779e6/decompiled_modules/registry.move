module 0xfde47b037e3ac625bfa075424af9317227ceb4cc3b798ee2b5c31399a61779e6::registry {
    struct Attestation has store, key {
        id: 0x2::object::UID,
        creator: address,
        blob_id: 0x1::string::String,
        credential_blob_id: 0x1::string::String,
        sha256: 0x1::string::String,
        phash: 0x1::string::String,
        media_type: 0x1::string::String,
        parent: 0x1::option::Option<0x2::object::ID>,
        encrypted: bool,
        created_at_ms: u64,
    }

    struct AttestationCreated has copy, drop {
        attestation_id: 0x2::object::ID,
        creator: address,
        blob_id: 0x1::string::String,
        sha256: 0x1::string::String,
        parent: 0x1::option::Option<0x2::object::ID>,
        created_at_ms: u64,
    }

    fun new_attestation(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = Attestation{
            id                 : 0x2::object::new(arg8),
            creator            : 0x2::tx_context::sender(arg8),
            blob_id            : 0x1::string::utf8(arg0),
            credential_blob_id : 0x1::string::utf8(arg1),
            sha256             : 0x1::string::utf8(arg2),
            phash              : 0x1::string::utf8(arg3),
            media_type         : 0x1::string::utf8(arg4),
            parent             : arg6,
            encrypted          : arg5,
            created_at_ms      : v0,
        };
        let v2 = AttestationCreated{
            attestation_id : 0x2::object::id<Attestation>(&v1),
            creator        : v1.creator,
            blob_id        : v1.blob_id,
            sha256         : v1.sha256,
            parent         : v1.parent,
            created_at_ms  : v0,
        };
        0x2::event::emit<AttestationCreated>(v2);
        0x2::transfer::public_freeze_object<Attestation>(v1);
    }

    public entry fun register(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        new_attestation(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x2::object::ID>(), arg6, arg7);
    }

    public entry fun register_derivative(arg0: &Attestation, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        new_attestation(arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<0x2::object::ID>(0x2::object::id<Attestation>(arg0)), arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

