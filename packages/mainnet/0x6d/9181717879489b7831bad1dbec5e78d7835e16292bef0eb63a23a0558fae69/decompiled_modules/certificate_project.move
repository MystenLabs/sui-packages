module 0x6d9181717879489b7831bad1dbec5e78d7835e16292bef0eb63a23a0558fae69::certificate_project {
    struct Certificate has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        issuer: 0x1::string::String,
        issued_date: u64,
        expiry_date: u64,
        description: 0x1::string::String,
        metadata: vector<u8>,
    }

    struct CertificateMinted has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
    }

    public entry fun mint_certificate(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{
            id          : 0x2::object::new(arg7),
            title       : arg1,
            issuer      : arg2,
            issued_date : arg3,
            expiry_date : arg4,
            description : arg5,
            metadata    : arg6,
        };
        let v1 = CertificateMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            recipient : arg0,
        };
        0x2::event::emit<CertificateMinted>(v1);
        0x2::transfer::public_transfer<Certificate>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

