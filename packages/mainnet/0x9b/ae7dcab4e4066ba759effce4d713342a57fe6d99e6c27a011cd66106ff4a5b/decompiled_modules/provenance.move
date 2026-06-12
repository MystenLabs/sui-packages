module 0x9bae7dcab4e4066ba759effce4d713342a57fe6d99e6c27a011cd66106ff4a5b::provenance {
    struct CertificateReceipt has store, key {
        id: 0x2::object::UID,
        cert_id_hash: vector<u8>,
        content_hash: vector<u8>,
        issued_at: u64,
        issuer: address,
        schema_version: u16,
    }

    public fun anchor(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CertificateReceipt{
            id             : 0x2::object::new(arg3),
            cert_id_hash   : arg0,
            content_hash   : arg1,
            issued_at      : arg2,
            issuer         : 0x2::tx_context::sender(arg3),
            schema_version : 1,
        };
        0x2::transfer::freeze_object<CertificateReceipt>(v0);
    }

    // decompiled from Move bytecode v7
}

