module 0xcba21ec3a196938f6a39b483ca786e62a18481e6a42330da2683850d3dd15c2a::pepesui_nft {
    struct Ownership has key {
        id: 0x2::object::UID,
    }

    struct PepeSuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
        json: 0x1::string::String,
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
        mintingEnabled: bool,
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

    public entry fun burn(arg0: PepeSuiNFT, arg1: &mut SharePepeSUI, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 0);
        let PepeSuiNFT {
            id          : v0,
            name        : _,
            img_url     : _,
            description : _,
            json        : _,
            link        : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun changeMintingStatus(arg0: bool, arg1: &mut SharePepeSUI, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 0);
        arg1.mintingEnabled = arg0;
    }

    public fun description(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: PEPESUI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Ownership{id: 0x2::object::new(arg1)};
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"json"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"img_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The king of the memes, now in its blue version. Pump it the PEPE SUI CEO!"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.pepesui.ceo"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{json}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        let v5 = 0x2::package::claim<PEPESUI_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<PepeSuiNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<PepeSuiNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<PepeSuiNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        let v7 = SharePepeSUI{
            id             : 0x2::object::new(arg1),
            current_mint   : 0,
            total_nfts     : 420,
            admin          : 0x2::tx_context::sender(arg1),
            mintingEnabled : true,
        };
        0x2::transfer::share_object<SharePepeSUI>(v7);
        0x2::transfer::transfer<Ownership>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun ipfs(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.img_url
    }

    public fun json(arg0: &PepeSuiNFT) : &0x1::string::String {
        &arg0.json
    }

    public entry fun mint_to_sender(arg0: &mut SharePepeSUI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_with_type<address, UserInfo>(&arg0.id, 0x2::tx_context::sender(arg1)), 0);
        let v0 = arg0.current_mint;
        arg0.current_mint = v0 + 1;
        assert!(v0 <= 420, 0);
        let v1 = num_str(arg0.current_mint);
        let v2 = 0x1::string::utf8(b"PEPE SUI CEO #");
        0x1::string::append_utf8(&mut v2, v1);
        let v3 = 0x1::string::utf8(b"https://bafybeidgpxgxzxpqgmrwpftnklf6djm4ehtkihdpwkzkwe4tq56xpb3gy4.ipfs.dweb.link/json/");
        0x1::string::append_utf8(&mut v3, v1);
        0x1::string::append(&mut v3, 0x1::string::utf8(b".json"));
        let v4 = 0x1::string::utf8(b"https://bafybeidgpxgxzxpqgmrwpftnklf6djm4ehtkihdpwkzkwe4tq56xpb3gy4.ipfs.dweb.link/images/");
        0x1::string::append_utf8(&mut v4, v1);
        0x1::string::append(&mut v4, 0x1::string::utf8(b".png"));
        let v5 = 0x1::string::utf8(b"ipfs://QmWxGaToYDNdUgaftoqn5YC7S4JHpBaFPgvMzpDudCe398/");
        0x1::string::append_utf8(&mut v5, v1);
        0x1::string::append(&mut v5, 0x1::string::utf8(b".png"));
        let v6 = PepeSuiNFT{
            id          : 0x2::object::new(arg1),
            name        : v2,
            img_url     : v5,
            description : 0x1::string::utf8(b"The king of the memes, now in its blue version. Pump it the PEPE SUI CEO!"),
            json        : v3,
            link        : 0x1::string::utf8(b"https://www.pepesui.ceo"),
            image_url   : v4,
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

    fun num_str(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun update_description(arg0: &mut PepeSuiNFT, arg1: vector<u8>, arg2: &mut SharePepeSUI, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg3), 0);
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

