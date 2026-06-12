module 0x4944643c616caf8e6f6100cd4d4f885c12285c6c3fa3e6e8118df319a85860c5::provenance {
    struct PROVENANCE has drop {
        dummy_field: bool,
    }

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
            schema_version : 2,
        };
        0x2::transfer::freeze_object<CertificateReceipt>(v0);
    }

    fun init(arg0: PROVENANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PROVENANCE>(arg0, arg1);
        let v1 = 0x2::display::new<CertificateReceipt>(&v0, arg1);
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(x"4869745a4552c398204365727469666963617465"));
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Verified original creation. Tamper-proof provenance, anchored on Sui."));
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://hitzero.com/verify-sui-seal.png"));
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://hitzero.com/verify"));
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://hitzero.com"));
        0x2::display::add<CertificateReceipt>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(x"4869745a4552c398"));
        0x2::display::update_version<CertificateReceipt>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<CertificateReceipt>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

