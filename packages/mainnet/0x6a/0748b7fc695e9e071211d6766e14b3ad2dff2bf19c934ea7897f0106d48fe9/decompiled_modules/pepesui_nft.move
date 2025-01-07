module 0x6a0748b7fc695e9e071211d6766e14b3ad2dff2bf19c934ea7897f0106d48fe9::pepesui_nft {
    struct PepeSuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        nftID: u64,
        is_mint: bool,
    }

    struct SharePepeSUI has store, key {
        id: 0x2::object::UID,
        current_mint: u64,
        total_nfts: u64,
        admin: address,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        is_mint: bool,
    }

    struct PEPESUI_NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: PepeSuiNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PepeSuiNFT>(arg0, arg1);
    }

    public fun description(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.img_url
    }

    fun init(arg0: PEPESUI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PEPE.sui #"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The first collection of blue pepe in the world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PEPE.sui DEV"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.pepesui.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.pepesui.io/nfts/json/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.pepesui.io/nfts/images/"));
        let v4 = 0x2::package::claim<PEPESUI_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PepeSuiNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<PepeSuiNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PepeSuiNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SharePepeSUI{
            id           : 0x2::object::new(arg1),
            current_mint : 0,
            total_nfts   : 420,
            admin        : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SharePepeSUI>(v6);
    }

    public entry fun mint_to_sender(arg0: &mut SharePepeSUI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_with_type<address, UserInfo>(&arg0.id, 0x2::tx_context::sender(arg1)), 0);
        let v0 = arg0.current_mint;
        arg0.current_mint = v0 + 1;
        assert!(v0 <= 420, 0);
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = b"PEPE.sui #";
        0x1::vector::append<u8>(&mut v2, v1);
        let v3 = b"https://www.pepesui.io/nfts/json/";
        0x1::vector::append<u8>(&mut v3, v1);
        let v4 = b"https://www.pepesui.io/nfts/images/";
        0x1::vector::append<u8>(&mut v4, v1);
        let v5 = 0x1::string::utf8(v4);
        let v6 = PepeSuiNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(v2),
            img_url     : v5,
            description : 0x1::string::utf8(b"The first collection of blue pepe in the world"),
            creator     : 0x1::string::utf8(b"PEPE.sui DEV"),
            project_url : 0x1::string::utf8(v3),
            link        : 0x1::string::utf8(b"https://www.pepesui.io"),
            image_url   : v5,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        let v8 = MintNFTEvent{
            object_id : 0x2::object::id<PepeSuiNFT>(&v6),
            creator   : v7,
            name      : v6.name,
            nftID     : v0,
            is_mint   : true,
        };
        0x2::event::emit<MintNFTEvent>(v8);
        0x2::transfer::public_transfer<PepeSuiNFT>(v6, v7);
        let v9 = UserInfo{
            id      : 0x2::object::new(arg1),
            is_mint : true,
        };
        0x2::dynamic_object_field::add<address, UserInfo>(&mut arg0.id, 0x2::tx_context::sender(arg1), v9);
        0x2::dynamic_object_field::borrow_mut<address, UserInfo>(&mut arg0.id, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut PepeSuiNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

