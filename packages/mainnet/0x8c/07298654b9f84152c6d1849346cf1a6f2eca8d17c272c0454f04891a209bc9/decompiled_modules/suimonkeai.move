module 0x8c07298654b9f84152c6d1849346cf1a6f2eca8d17c272c0454f04891a209bc9::suimonkeai {
    struct SUIMONKEAI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        minted: u64,
    }

    struct SuiMonkeAi has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    fun init(arg0: SUIMONKEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id     : 0x2::object::new(arg1),
            minted : 0,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.suimonkeai.wtf"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        let v6 = 0x2::package::claim<SUIMONKEAI>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<SuiMonkeAi>(&v6, v2, v4, arg1);
        0x2::display::update_version<SuiMonkeAi>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiMonkeAi>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Storage>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 700000000, 0);
        assert!(arg0.minted < 15000, 1);
        let v0 = SuiMonkeAi{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"SuiMonkeAI NFT"),
            description : 0x1::string::utf8(b"MonkeAI are proud to present the most adorable AI meme token on SuiNetwork, with the aim of making AI Technology more accessible for everyone."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"bafybeiaicf7a2vvtw7eppizwtfr3gpw76nu6t2gujzxykro5wb2hz5m2wi/SuiMonkeAI.png"),
        };
        arg0.minted = arg0.minted + 1;
        0x2::transfer::public_transfer<SuiMonkeAi>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x151aa1a3d11ff085161c14a3bf2aadad07996fa39d2e1764f5ad7c4a8bb0b5ab);
    }

    // decompiled from Move bytecode v6
}

