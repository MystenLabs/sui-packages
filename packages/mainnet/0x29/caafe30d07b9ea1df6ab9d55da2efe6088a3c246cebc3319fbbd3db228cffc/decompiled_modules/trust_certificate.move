module 0x29caafe30d07b9ea1df6ab9d55da2efe6088a3c246cebc3319fbbd3db228cffc::trust_certificate {
    struct TrustCertificate has store, key {
        id: 0x2::object::UID,
        validation_id: 0x1::string::String,
        trust_score: u8,
        ipfs_cid: 0x1::string::String,
        prompt: 0x1::string::String,
        timestamp: u64,
        image_url: 0x2::url::Url,
        owner: address,
    }

    struct CertificateMinted has copy, drop {
        certificate_id: address,
        validation_id: 0x1::string::String,
        trust_score: u8,
        recipient: address,
    }

    public fun get_trust_score(arg0: &TrustCertificate) : u8 {
        arg0.trust_score
    }

    public fun get_validation_id(arg0: &TrustCertificate) : 0x1::string::String {
        arg0.validation_id
    }

    public fun mint_certificate(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TrustCertificate{
            id            : 0x2::object::new(arg6),
            validation_id : 0x1::string::utf8(arg0),
            trust_score   : arg1,
            ipfs_cid      : 0x1::string::utf8(arg2),
            prompt        : 0x1::string::utf8(arg3),
            timestamp     : arg4,
            image_url     : 0x2::url::new_unsafe_from_bytes(b"https://trustops.app/api/nft-image/"),
            owner         : arg5,
        };
        let v1 = CertificateMinted{
            certificate_id : 0x2::object::uid_to_address(&v0.id),
            validation_id  : v0.validation_id,
            trust_score    : v0.trust_score,
            recipient      : arg5,
        };
        0x2::event::emit<CertificateMinted>(v1);
        0x2::transfer::public_transfer<TrustCertificate>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

