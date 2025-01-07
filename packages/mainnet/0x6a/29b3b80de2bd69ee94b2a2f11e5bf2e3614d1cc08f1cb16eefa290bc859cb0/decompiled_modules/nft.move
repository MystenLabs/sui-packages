module 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft {
    struct YOUSUINFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: vector<u8>,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Infomation has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        mint_index: u64,
        project_url: 0x2::url::Url,
        description_og: 0x1::string::String,
        description_pfp: 0x1::string::String,
        description_tier1: 0x1::string::String,
        description_tier2: 0x1::string::String,
        description_tier3: 0x1::string::String,
        description_tier4: 0x1::string::String,
        description_tier5: 0x1::string::String,
        creator: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: YOUSUINFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<YOUSUINFT>(arg0, arg1);
    }

    public entry fun burn(arg0: YOUSUINFT, arg1: &mut 0x2::tx_context::TxContext) {
        let YOUSUINFT {
            id          : v0,
            name        : _,
            description : _,
            type        : _,
            image_url   : _,
            project_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &YOUSUINFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &YOUSUINFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Infomation{
            id                : 0x2::object::new(arg1),
            name              : 0x1::string::utf8(b"YOUSUI NFT"),
            mint_index        : 20230001,
            project_url       : 0x2::url::new_unsafe_from_bytes(b"https://yousui.io/"),
            description_og    : 0x1::string::utf8(b"OG NFTs can be issued with a very low probability. OG NFTs are NFTs that will have the right to participate in the IDO Launchpad of XUI Tokens. Be sure to hold it until the end of the IDO Launchpad. Confirmed XUI Allocation will be of great benefit to you."),
            description_pfp   : 0x1::string::utf8(b"Decorate your profile with pretty characters! Don't you know? Moderators passing by can see your pretty profile and give you XP points!"),
            description_tier1 : 0x1::string::utf8(b""),
            description_tier2 : 0x1::string::utf8(b""),
            description_tier3 : 0x1::string::utf8(b""),
            description_tier4 : 0x1::string::utf8(b""),
            description_tier5 : 0x1::string::utf8(b"Users generally need to stake 3000 XUI tokens to use IDO Launchpad or INO Launchpad. If you hold Tier 5 NFTs, you can participate in IDO Launchpad and INO Launchpad without needing to stake 3000 XUI."),
            creator           : 0x2::tx_context::sender(arg1),
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        let v5 = 0x2::package::claim<NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<YOUSUINFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<YOUSUINFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<YOUSUINFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Infomation>(v0);
    }

    public(friend) fun mint(arg0: vector<u8>, arg1: &mut Infomation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = b"";
        let v2 = 0x1::string::utf8(b"");
        if (arg0 == b"og") {
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_OGROLE.png";
            v2 = arg1.description_og;
        };
        if (arg0 == b"pfp") {
            v2 = arg1.description_pfp;
            if (arg1.mint_index % 4 == 0) {
                v1 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP4.png";
            };
            if (arg1.mint_index % 4 == 1) {
                v1 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP1.png";
            };
            if (arg1.mint_index % 4 == 2) {
                v1 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP2.png";
            };
            if (arg1.mint_index % 4 == 3) {
                v1 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP3.png";
            };
        };
        if (arg0 == b"1") {
            v2 = arg1.description_tier1;
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_TIER1.png";
        };
        if (arg0 == b"2") {
            v2 = arg1.description_tier2;
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_TIER2.png";
        };
        if (arg0 == b"3") {
            v2 = arg1.description_tier3;
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_TIER3.png";
        };
        if (arg0 == b"4") {
            v2 = arg1.description_tier4;
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_TIER4.png";
        };
        if (arg0 == b"5") {
            v2 = arg1.description_tier5;
            v1 = b"https://files.yousui.io/mint/YouSUI_NFT_TIER5.png";
        };
        let v3 = YOUSUINFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"YOUSUI"),
            description : v2,
            type        : arg0,
            image_url   : 0x2::url::new_unsafe_from_bytes(v1),
            project_url : arg1.project_url,
        };
        let v4 = NFTMinted{
            object_id : 0x2::object::id<YOUSUINFT>(&v3),
            creator   : v0,
            name      : v3.name,
        };
        0x2::event::emit<NFTMinted>(v4);
        arg1.mint_index = arg1.mint_index + 1;
        0x2::transfer::public_transfer<YOUSUINFT>(v3, v0);
    }

    public fun name(arg0: &YOUSUINFT) : &0x1::string::String {
        &arg0.name
    }

    public fun project_url(arg0: &YOUSUINFT) : &0x2::url::Url {
        &arg0.project_url
    }

    public fun type(arg0: &YOUSUINFT) : vector<u8> {
        arg0.type
    }

    public entry fun update_description_og(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_og = arg1;
    }

    public entry fun update_description_pfp(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_pfp = arg1;
    }

    public entry fun update_description_tier1(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_tier1 = arg1;
    }

    public entry fun update_description_tier2(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_tier2 = arg1;
    }

    public entry fun update_description_tier3(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_tier3 = arg1;
    }

    public entry fun update_description_tier4(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_tier4 = arg1;
    }

    public entry fun update_description_tier5(arg0: &mut Infomation, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description_tier5 = arg1;
    }

    // decompiled from Move bytecode v6
}

