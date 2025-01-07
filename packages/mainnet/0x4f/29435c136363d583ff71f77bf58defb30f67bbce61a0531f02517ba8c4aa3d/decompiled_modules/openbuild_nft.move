module 0x4f29435c136363d583ff71f77bf58defb30f67bbce61a0531f02517ba8c4aa3d::openbuild_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<0x1::string::String, address>,
    }

    struct OpenBuildNFT has store, key {
        id: 0x2::object::UID,
        token_id: 0x1::string::String,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        creator: address,
    }

    struct OPENBUILD_NFT has drop {
        dummy_field: bool,
    }

    public entry fun create_mint_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id         : 0x2::object::new(arg2),
            public_key : arg1,
        };
        0x2::transfer::share_object<MintCap>(v0);
    }

    fun init(arg0: OPENBUILD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://openbuild.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"OpenBuild NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://openbuild.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = 0x2::package::claim<OPENBUILD_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<OpenBuildNFT>(&v5, v0, v2, arg1);
        let v7 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<0x1::string::String, address>(arg1),
        };
        0x2::transfer::share_object<MintRecord>(v7);
        0x2::display::update_version<OpenBuildNFT>(&mut v6);
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OpenBuildNFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: &mut MintCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.record, arg2), 1);
        let v0 = 0x2::tx_context::sender(arg5);
        0x1::string::append(&mut arg2, arg3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &arg1.public_key, 0x1::string::bytes(&arg2)), 0);
        0x2::table::add<0x1::string::String, address>(&mut arg0.record, arg2, v0);
        let v1 = OpenBuildNFT{
            id        : 0x2::object::new(arg5),
            token_id  : arg2,
            image_url : arg3,
            name      : 0x1::string::utf8(b"OpenBuild"),
            creator   : v0,
        };
        0x2::transfer::public_transfer<OpenBuildNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

