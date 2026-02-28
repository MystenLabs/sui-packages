module 0xef4bc4b793364d91434e824d180ec61459f2d393cf699820562c97ee49335447::trust_certificate {
    struct TrustCertificate has store, key {
        id: 0x2::object::UID,
        validation_id: 0x1::string::String,
        trust_score: u8,
        ipfs_cid: 0x1::string::String,
        prompt: 0x1::string::String,
        timestamp: u64,
        image_url: 0x1::string::String,
        owner: address,
    }

    struct CertificateMinted has copy, drop {
        certificate_id: address,
        validation_id: 0x1::string::String,
        trust_score: u8,
        recipient: address,
        fee_paid: u64,
    }

    struct TRUST_CERTIFICATE has drop {
        dummy_field: bool,
    }

    public fun get_image_url(arg0: &TrustCertificate) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_trust_score(arg0: &TrustCertificate) : u8 {
        arg0.trust_score
    }

    public fun get_validation_id(arg0: &TrustCertificate) : 0x1::string::String {
        arg0.validation_id
    }

    fun init(arg0: TRUST_CERTIFICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRUST_CERTIFICATE>(arg0, arg1);
        let v1 = 0x2::display::new<TrustCertificate>(&v0, arg1);
        0x2::display::add<TrustCertificate>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Trust Ops Certificate #{validation_id}"));
        0x2::display::add<TrustCertificate>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Decentralized AI validation certificate with trust score: {trust_score}/100"));
        0x2::display::add<TrustCertificate>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TrustCertificate>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://trustops.app"));
        0x2::display::add<TrustCertificate>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Trust Ops Protocol"));
        0x2::display::update_version<TrustCertificate>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TrustCertificate>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_certificate<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 100000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x319b22babb64339f17a550c978fe3c1bc8c37c825681744145b408f45e946ae1);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"https://trust-ops-agent-production.up.railway.app/api/nft-image/");
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = TrustCertificate{
            id            : 0x2::object::new(arg7),
            validation_id : 0x1::string::utf8(arg1),
            trust_score   : arg2,
            ipfs_cid      : 0x1::string::utf8(arg3),
            prompt        : 0x1::string::utf8(arg4),
            timestamp     : arg5,
            image_url     : 0x1::string::utf8(v0),
            owner         : arg6,
        };
        let v2 = CertificateMinted{
            certificate_id : 0x2::object::uid_to_address(&v1.id),
            validation_id  : v1.validation_id,
            trust_score    : v1.trust_score,
            recipient      : arg6,
            fee_paid       : 100000,
        };
        0x2::event::emit<CertificateMinted>(v2);
        0x2::transfer::public_transfer<TrustCertificate>(v1, arg6);
    }

    // decompiled from Move bytecode v6
}

