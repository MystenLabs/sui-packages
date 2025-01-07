module 0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_workshop {
    struct NFT_WORKSHOP has drop {
        dummy_field: bool,
    }

    struct NftAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Workshop has store, key {
        id: 0x2::object::UID,
        state: u8,
        version: u64,
        urls: vector<vector<u8>>,
        whitelist: 0x2::table::Table<address, ClaimInfor>,
        template: 0x1::option::Option<Template>,
        total_supply: u64,
        total_mint: u64,
    }

    struct Template has store {
        name: vector<u8>,
        link: vector<u8>,
        description: vector<u8>,
        project_url: vector<u8>,
        edition: u64,
        thumbnail_url: vector<u8>,
        creator: vector<u8>,
        attributes_names: vector<vector<u8>>,
        attributes_values: vector<vector<u8>>,
    }

    struct ClaimInfor has copy, drop, store {
        version: u64,
        claimed: bool,
    }

    struct AddWhitelistEvent has copy, drop {
        id: address,
        users: vector<address>,
    }

    struct MintNftEvent has copy, drop {
        sender: address,
        nft: address,
    }

    struct BurnNftEvent has copy, drop {
        sender: address,
        nft: address,
    }

    struct ResetWhitelistEvent has copy, drop {
        id: address,
    }

    struct SetUrlsEvent has copy, drop {
        id: address,
        urls: vector<vector<u8>>,
    }

    public entry fun addWhiteList(arg0: &NftAdminCap, arg1: vector<address>, arg2: &mut Workshop, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.state != 3, 6100);
        let v0 = AddWhitelistEvent{
            id    : 0x2::object::id_address<Workshop>(arg2),
            users : arg1,
        };
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, ClaimInfor>(&arg2.whitelist, v1)) {
                let v2 = ClaimInfor{
                    version : arg2.version,
                    claimed : false,
                };
                0x2::table::add<address, ClaimInfor>(&mut arg2.whitelist, v1, v2);
                continue
            };
            if (0x2::table::borrow<address, ClaimInfor>(&arg2.whitelist, v1).version < arg2.version) {
                0x2::table::remove<address, ClaimInfor>(&mut arg2.whitelist, v1);
                let v3 = ClaimInfor{
                    version : arg2.version,
                    claimed : false,
                };
                0x2::table::add<address, ClaimInfor>(&mut arg2.whitelist, v1, v3);
            };
        };
        0x2::event::emit<AddWhitelistEvent>(v0);
    }

    public entry fun burnNft(arg0: 0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnNftEvent{
            sender : 0x2::tx_context::sender(arg1),
            nft    : 0x2::object::id_address<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(&arg0),
        };
        0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::burn(arg0);
        0x2::event::emit<BurnNftEvent>(v0);
    }

    public entry fun claimNft(arg0: &mut Workshop, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 6100);
        assert!(arg0.total_mint < arg0.total_supply, 6103);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, ClaimInfor>(&arg0.whitelist, v0) && 0x2::table::borrow<address, ClaimInfor>(&arg0.whitelist, v0).version >= arg0.version && !0x2::table::borrow<address, ClaimInfor>(&arg0.whitelist, v0).claimed, 6101);
        let v1 = 0x2::address::to_u256(v0) + (0x2::tx_context::epoch_timestamp_ms(arg1) as u256);
        let v2 = (0x1::vector::length<vector<u8>>(&arg0.urls) as u256);
        let v3 = 0x1::option::borrow_mut<Template>(&mut arg0.template);
        let v4 = &v3.attributes_names;
        let v5 = &v3.attributes_values;
        let v6 = 0x2::table::new<vector<u8>, vector<u8>>(arg1);
        let v7 = 0x1::vector::length<vector<u8>>(v4);
        while (v7 > 0) {
            v7 = v7 - 1;
            0x2::table::add<vector<u8>, vector<u8>>(&mut v6, *0x1::vector::borrow<vector<u8>>(v4, v7), *0x1::vector::borrow<vector<u8>>(v5, v7));
        };
        let v8 = 0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::mint(v3.name, v3.link, *0x1::vector::borrow<vector<u8>>(&arg0.urls, ((v1 - v2 * v1 / v2) as u64)), v3.description, v3.project_url, v3.edition, v3.thumbnail_url, v3.creator, v6, arg1);
        let v9 = MintNftEvent{
            sender : v0,
            nft    : 0x2::object::id_address<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(&v8),
        };
        0x2::transfer::public_transfer<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(v8, v0);
        0x2::table::borrow_mut<address, ClaimInfor>(&mut arg0.whitelist, v0).claimed = true;
        arg0.total_mint = arg0.total_mint + 1;
        0x2::event::emit<MintNftEvent>(v9);
    }

    public entry fun end(arg0: &NftAdminCap, arg1: &mut Workshop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state != 3, 6100);
        arg1.state = 3;
    }

    fun init(arg0: NFT_WORKSHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Workshop{
            id           : 0x2::object::new(arg1),
            state        : 1,
            version      : 0,
            urls         : 0x1::vector::empty<vector<u8>>(),
            whitelist    : 0x2::table::new<address, ClaimInfor>(arg1),
            template     : 0x1::option::none<Template>(),
            total_supply : 0,
            total_mint   : 0,
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::package::claim<NFT_WORKSHOP>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::PriNFT>(0x7cd33c48a526f7308675313e2bf7b6de81c4602d57d71526bfe30f8c41df1fd8::nft_private::mint(b"Genesis NFT campaign", b"https://seapad.fund/nftcampaign", b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1686475080033.png", b"Genesis NFT campaign", b"https://seapad.fund/", 1, b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1686475080033.png", b"SeaPadFoundation", 0x2::table::new<vector<u8>, vector<u8>>(arg1), arg1), 0x2::tx_context::sender(arg1));
        let v7 = NftAdminCap{id: 0x2::object::new(arg1)};
        let v8 = &mut v0;
        setTemplate(&v7, b"Seapad New Year Collection", b"https://seapad.fund/nftcampaign", b"Seapad New Year Collection", b"https://seapad.fund/", 1, b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1686475080033.png", b"SeaPad Foundation", 0x1::vector::empty<vector<u8>>(), 0x1::vector::empty<vector<u8>>(), 100000, v8);
        let v9 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v9, b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1686475080033.png");
        let v10 = &mut v0;
        setNftUrls(&v7, v9, v10, arg1);
        0x2::transfer::share_object<Workshop>(v0);
        0x2::transfer::public_transfer<NftAdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun resetWhiteList(arg0: &NftAdminCap, arg1: &mut Workshop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state != 2, 6100);
        arg1.version = arg1.version + 1;
        arg1.total_supply = 0;
        arg1.total_mint = 0;
        let v0 = ResetWhitelistEvent{id: 0x2::object::id_address<Workshop>(arg1)};
        0x2::event::emit<ResetWhitelistEvent>(v0);
    }

    public entry fun setNftUrls(arg0: &NftAdminCap, arg1: vector<vector<u8>>, arg2: &mut Workshop, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.state != 2, 6100);
        arg2.urls = arg1;
        let v0 = SetUrlsEvent{
            id   : 0x2::object::id_address<Workshop>(arg2),
            urls : arg1,
        };
        0x2::event::emit<SetUrlsEvent>(v0);
    }

    public entry fun setTemplate(arg0: &NftAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: u64, arg11: &mut Workshop) {
        assert!(arg11.state != 2, 6100);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg6) > 0 && 0x1::vector::length<vector<u8>>(&arg8) == 0x1::vector::length<vector<u8>>(&arg9) && arg10 > 0, 6102);
        if (0x1::option::is_some<Template>(&arg11.template)) {
            let v0 = 0x1::option::borrow_mut<Template>(&mut arg11.template);
            v0.name = arg1;
            v0.link = arg2;
            v0.description = arg3;
            v0.project_url = arg4;
            v0.edition = arg5;
            v0.thumbnail_url = arg6;
            v0.creator = arg7;
            v0.attributes_names = arg8;
            v0.attributes_values = arg9;
        } else {
            let v1 = Template{
                name              : arg1,
                link              : arg2,
                description       : arg3,
                project_url       : arg4,
                edition           : arg5,
                thumbnail_url     : arg6,
                creator           : arg7,
                attributes_names  : arg8,
                attributes_values : arg9,
            };
            0x1::option::fill<Template>(&mut arg11.template, v1);
        };
        arg11.total_supply = arg10;
        arg11.total_mint = 0;
    }

    public entry fun start(arg0: &NftAdminCap, arg1: &mut Workshop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state != 2 && 0x1::option::is_some<Template>(&arg1.template) && arg1.total_supply > 0, 6100);
        arg1.state = 2;
    }

    // decompiled from Move bytecode v6
}

