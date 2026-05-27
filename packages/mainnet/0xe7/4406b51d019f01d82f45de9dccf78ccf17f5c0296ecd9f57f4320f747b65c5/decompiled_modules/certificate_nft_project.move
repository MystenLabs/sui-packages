module 0xe74406b51d019f01d82f45de9dccf78ccf17f5c0296ecd9f57f4320f747b65c5::certificate_nft_project {
    struct CertificateNft has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        certificate_type: 0x1::string::String,
        issuer: 0x1::string::String,
        participant: 0x1::string::String,
        web_page: 0x1::string::String,
        issued_date: u64,
        expiry_date: u64,
        image_url: 0x1::string::String,
        metadata: vector<u8>,
    }

    struct CertificateNftMinted has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        mint_authority: address,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_certificate_nft(arg0: CertificateNft) {
        let CertificateNft {
            id               : v0,
            title            : _,
            certificate_type : _,
            issuer           : _,
            participant      : _,
            web_page         : _,
            issued_date      : _,
            expiry_date      : _,
            image_url        : _,
            metadata         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun init_mint_config(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0, 2);
        let v0 = MintConfig{
            id             : 0x2::object::new(arg1),
            mint_authority : arg0,
            paused         : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MintConfig>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, arg0);
    }

    public entry fun mint_certificate_nft(arg0: &MintConfig, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(0x2::tx_context::sender(arg11) == arg0.mint_authority, 2);
        assert!(0x1::string::length(&arg9) > 0, 4);
        assert!((0x1::string::length(&arg9) as u64) <= 512, 6);
        let v0 = CertificateNft{
            id               : 0x2::object::new(arg11),
            title            : arg2,
            certificate_type : arg3,
            issuer           : arg4,
            participant      : arg5,
            web_page         : arg6,
            issued_date      : arg7,
            expiry_date      : arg8,
            image_url        : arg9,
            metadata         : arg10,
        };
        let v1 = CertificateNftMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            recipient : arg1,
        };
        0x2::event::emit<CertificateNftMinted>(v1);
        0x2::transfer::transfer<CertificateNft>(v0, arg1);
    }

    public fun set_mint_authority(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.mint_authority = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun setup_certificate_nft_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<CertificateNft>(arg0), 5);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{certificate_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{web_page}"));
        let v4 = 0x2::display::new_with_fields<CertificateNft>(arg0, v0, v2, arg1);
        0x2::display::update_version<CertificateNft>(&mut v4);
        0x2::transfer::public_share_object<0x2::display::Display<CertificateNft>>(v4);
    }

    // decompiled from Move bytecode v7
}

