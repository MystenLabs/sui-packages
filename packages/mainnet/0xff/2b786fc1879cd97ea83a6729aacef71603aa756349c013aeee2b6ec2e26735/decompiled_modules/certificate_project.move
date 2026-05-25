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
            id          : v0,
            title       : _,
            issuer      : _,
            issued_date : _,
            expiry_date : _,
            description : _,
            metadata    : _,
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

    public entry fun mint_certificate(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public entry fun mint_certificate_v2(arg0: &MintConfig, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(0x2::tx_context::sender(arg8) == arg0.mint_authority, 2);
        let v0 = Certificate{
            id          : 0x2::object::new(arg8),
            title       : arg2,
            issuer      : arg3,
            issued_date : arg4,
            expiry_date : arg5,
            description : arg6,
            metadata    : arg7,
        };
        let v1 = CertificateMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            recipient : arg1,
        };
        0x2::event::emit<CertificateMinted>(v1);
        0x2::transfer::public_transfer<Certificate>(v0, arg1);
    }

    public entry fun mint_certificate_v3(arg0: &MintConfig, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(0x2::tx_context::sender(arg3) == arg0.mint_authority, 2);
        let v0 = 0x1::string::utf8(b"");
        let v1 = Certificate{
            id          : 0x2::object::new(arg3),
            title       : v0,
            issuer      : v0,
            issued_date : 0,
            expiry_date : 0,
            description : v0,
            metadata    : arg2,
        };
        let v2 = CertificateMinted{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            recipient : arg1,
        };
        0x2::event::emit<CertificateMinted>(v2);
        0x2::transfer::public_transfer<Certificate>(v1, arg1);
    }

    public fun set_mint_authority(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.mint_authority = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

