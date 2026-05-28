module 0x847d379f8f32a7febbd93373224d4ba8d3c4050ac75326b7b15ed56746ca0f5b::certificate_project {
    struct Certificate has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        certificate_type: 0x1::string::String,
        issuer: 0x1::string::String,
        participant: 0x1::string::String,
        web_page: 0x1::string::String,
        issued_date: u64,
        expiry_date: u64,
        metadata: vector<u8>,
    }

    struct CertificateMinted has copy, drop {
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

    public fun burn_certificate(arg0: Certificate) {
        let Certificate {
            id               : v0,
            title            : _,
            certificate_type : _,
            issuer           : _,
            participant      : _,
            web_page         : _,
            issued_date      : _,
            expiry_date      : _,
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

    public entry fun mint_certificate(arg0: &MintConfig, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(0x2::tx_context::sender(arg10) == arg0.mint_authority, 2);
        let v0 = Certificate{
            id               : 0x2::object::new(arg10),
            title            : arg2,
            certificate_type : arg3,
            issuer           : arg4,
            participant      : arg5,
            web_page         : arg6,
            issued_date      : arg7,
            expiry_date      : arg8,
            metadata         : arg9,
        };
        let v1 = CertificateMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            recipient : arg1,
        };
        0x2::event::emit<CertificateMinted>(v1);
        0x2::transfer::transfer<Certificate>(v0, arg1);
    }

    public fun set_mint_authority(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.mint_authority = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

