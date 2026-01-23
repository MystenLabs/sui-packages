module 0xedf476331cb73cfc0d1133ad2f8856f1a06f88152bf8196fc52a9fb1ff524242::astros_box {
    struct ASTROS_BOX has drop {
        dummy_field: bool,
    }

    struct AstrosBoxConfig has store, key {
        id: 0x2::object::UID,
        box_id_count: u64,
    }

    struct AstrosBox has store, key {
        id: 0x2::object::UID,
        id_count: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        rarity: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct AstrosBoxMinted has copy, drop {
        nft_id: 0x2::object::ID,
        id_count: u64,
        recipient: address,
        user_uid: 0x1::string::String,
        rarity: u8,
        rarity_name: 0x1::string::String,
    }

    struct MintCapCreated has copy, drop {
        mint_cap_id: 0x2::object::ID,
        recipient: address,
    }

    public fun url(arg0: &AstrosBox) : 0x2::url::Url {
        arg0.url
    }

    public fun batch_mint(arg0: &mut AstrosBoxConfig, arg1: &MintCap, arg2: vector<address>, arg3: vector<0x1::string::String>, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 0);
        assert!(v0 == 0x1::vector::length<u8>(&arg4), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg5), 0);
        let v1 = 0;
        while (v1 < v0) {
            mint(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<u8>(&arg4, v1), arg6);
            v1 = v1 + 1;
        };
    }

    public fun box_id_count(arg0: &AstrosBoxConfig) : u64 {
        arg0.box_id_count
    }

    public fun create_mint_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg2)};
        let v1 = MintCapCreated{
            mint_cap_id : 0x2::object::id<MintCap>(&v0),
            recipient   : arg1,
        };
        0x2::event::emit<MintCapCreated>(v1);
        0x2::transfer::public_transfer<MintCap>(v0, arg1);
    }

    public fun description(arg0: &AstrosBox) : 0x1::string::String {
        arg0.description
    }

    public fun get_display_info(arg0: u64) : (0x1::string::String, 0x1::string::String, 0x2::url::Url) {
        let v0 = 0x1::string::utf8(b"Astros Box #");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        let v1 = 0x1::string::utf8(b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/perp/");
        0x1::string::append(&mut v1, u64_to_string(arg0));
        0x1::string::append(&mut v1, 0x1::string::utf8(b".jpg"));
        let v2 = 0x2::url::new_unsafe(0x1::string::to_ascii(v1));
        0x1::debug::print<0x2::url::Url>(&v2);
        (v0, 0x1::string::utf8(b"A unique Astros Box collectible NFT"), v2)
    }

    fun get_rarity_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Epic")
        } else {
            0x1::string::utf8(b"Legendary")
        }
    }

    public fun id_count(arg0: &AstrosBox) : u64 {
        arg0.id_count
    }

    fun init(arg0: ASTROS_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ASTROS_BOX>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AstrosBoxConfig{
            id           : 0x2::object::new(arg1),
            box_id_count : 0,
        };
        0x2::transfer::public_share_object<AstrosBoxConfig>(v1);
    }

    public fun mint(arg0: &mut AstrosBoxConfig, arg1: &MintCap, arg2: address, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 1 && arg4 <= 3, 0);
        let v0 = arg0.box_id_count;
        let (v1, v2, v3) = get_display_info(v0);
        let v4 = AstrosBox{
            id          : 0x2::object::new(arg5),
            id_count    : v0,
            name        : v1,
            description : v2,
            url         : v3,
            rarity      : arg4,
        };
        arg0.box_id_count = v0 + 1;
        let v5 = AstrosBoxMinted{
            nft_id      : 0x2::object::id<AstrosBox>(&v4),
            id_count    : v0,
            recipient   : arg2,
            user_uid    : arg3,
            rarity      : v4.rarity,
            rarity_name : get_rarity_name(arg4),
        };
        0x2::event::emit<AstrosBoxMinted>(v5);
        0x2::transfer::public_transfer<AstrosBox>(v4, arg2);
    }

    public fun name(arg0: &AstrosBox) : 0x1::string::String {
        arg0.name
    }

    public fun rarity(arg0: &AstrosBox) : u8 {
        arg0.rarity
    }

    public fun rarity_epic() : u8 {
        2
    }

    public fun rarity_legendary() : u8 {
        3
    }

    public fun rarity_rare() : u8 {
        1
    }

    public fun set_display(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<AstrosBox>(arg1), 1);
        let v0 = 0x2::display::new<AstrosBox>(arg1, arg2);
        0x2::display::add<AstrosBox>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AstrosBox>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AstrosBox>(&mut v0, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<AstrosBox>(&mut v0, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity_name}"));
        0x2::display::update_version<AstrosBox>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<AstrosBox>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            let v1 = 0x1::vector::empty<u8>();
            while (!0x1::vector::is_empty<u8>(&v0)) {
                0x1::vector::push_back<u8>(&mut v1, 0x1::vector::pop_back<u8>(&mut v0));
            };
            v0 = v1;
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

