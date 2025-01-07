module 0x8080ec446284b2e129b116843dc4b0dced9f98eb1805c11585a9b4c601fc5e2::normie {
    struct NormieConfig has key {
        id: 0x2::object::UID,
        main_url: vector<u8>,
        image_url: vector<u8>,
        extension: vector<u8>,
    }

    struct UpdateRequest has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        new_xp: 0x1::option::Option<u128>,
        new_point_multiplier: 0x1::option::Option<u16>,
        new_level: 0x1::option::Option<u8>,
        new_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct NormieAdminCap has key {
        id: 0x2::object::UID,
        normies_minted: u64,
    }

    struct NormieNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        xp: u128,
        point_multiplier: u16,
        level: u8,
        item_count: u16,
        url: 0x2::url::Url,
    }

    struct NORMIE has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
    }

    struct NFTTransfer has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        sender: address,
    }

    struct ItemAdded<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemRemoved<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: NormieNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NormieNFT>(arg0, arg1);
        let v0 = NFTTransfer{
            nft_id    : 0x2::object::id<NormieNFT>(&arg0),
            recipient : arg1,
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NFTTransfer>(v0);
    }

    public fun url(arg0: &NormieNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun add_item<T0: store + key>(arg0: &mut NormieNFT, arg1: T0, arg2: u8) {
        let v0 = ItemAdded<T0>{
            nft_id  : 0x2::object::id<NormieNFT>(arg0),
            item_id : 0x2::object::id<T0>(&arg1),
        };
        0x2::event::emit<ItemAdded<T0>>(v0);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg0.id, slot_to_name(arg2), arg1);
    }

    public entry fun apply_update_request(arg0: &mut NormieNFT, arg1: UpdateRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let UpdateRequest {
            id                   : v0,
            nft_id               : v1,
            new_xp               : v2,
            new_point_multiplier : v3,
            new_level            : v4,
            new_url              : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        assert!(v1 == 0x2::object::id<NormieNFT>(arg0), 404);
        if (0x1::option::is_some<0x2::url::Url>(&v6)) {
            arg0.url = *0x1::option::borrow<0x2::url::Url>(&v6);
        };
        if (0x1::option::is_some<u128>(&v9)) {
            arg0.xp = *0x1::option::borrow<u128>(&v9);
        };
        if (0x1::option::is_some<u16>(&v8)) {
            arg0.point_multiplier = *0x1::option::borrow<u16>(&v8);
        };
        if (0x1::option::is_some<u8>(&v7)) {
            arg0.level = *0x1::option::borrow<u8>(&v7);
        };
        0x2::object::delete(v0);
    }

    public entry fun burn(arg0: NormieNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NormieNFT {
            id               : v0,
            name             : _,
            description      : _,
            xp               : _,
            point_multiplier : _,
            level            : _,
            item_count       : _,
            url              : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_update_request(arg0: &NormieAdminCap, arg1: &NormieConfig, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::option::Option<u128>, arg5: 0x1::option::Option<u16>, arg6: 0x1::option::Option<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRequest{
            id                   : 0x2::object::new(arg7),
            nft_id               : arg3,
            new_xp               : arg4,
            new_point_multiplier : arg5,
            new_level            : arg6,
            new_url              : 0x1::option::some<0x2::url::Url>(img_url(arg1.image_url, arg1.extension, &arg3)),
        };
        0x2::transfer::transfer<UpdateRequest>(v0, arg2);
    }

    public fun description(arg0: &NormieNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_game_stats(arg0: &NormieNFT) : (u128, u8, u16) {
        (arg0.xp, arg0.level, arg0.point_multiplier)
    }

    fun img_url(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::object::ID) : 0x2::url::Url {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"0x");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::object::id_to_bytes(arg2)));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::url::new_unsafe_from_bytes(v0)
    }

    fun init(arg0: NORMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NormieAdminCap{
            id             : 0x2::object::new(arg1),
            normies_minted : 0,
        };
        0x2::transfer::transfer<NormieAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = NormieConfig{
            id        : 0x2::object::new(arg1),
            main_url  : b"https://swaye.me/",
            image_url : b"https://normies.swaye.me/",
            extension : b".png",
        };
        0x2::transfer::share_object<NormieConfig>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swaye.me/OGCollectibles"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"SWAYE"));
        let v6 = 0x2::package::claim<NORMIE>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<NormieNFT>(&v6, v2, v4, arg1);
        0x2::display::update_version<NormieNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NormieNFT>>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun item_count(arg0: &NormieNFT) : &u16 {
        &arg0.item_count
    }

    public fun level(arg0: &NormieNFT) : &u8 {
        &arg0.level
    }

    public entry fun mint_to_recipient(arg0: &mut NormieAdminCap, arg1: &NormieConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        arg0.normies_minted = arg0.normies_minted + 1;
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, b"Normie #");
        let v2 = u64_to_string(arg0.normies_minted);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = NormieNFT{
            id               : v0,
            name             : 0x1::string::utf8(v1),
            description      : 0x1::string::utf8(b"Dynamic OG [DOG] Collectible NFT"),
            xp               : 0,
            point_multiplier : 1,
            level            : 1,
            item_count       : 0,
            url              : img_url(arg1.image_url, arg1.extension, 0x2::object::uid_as_inner(&v0)),
        };
        0x2::transfer::transfer<NormieNFT>(v3, arg2);
        let v4 = NFTMinted{
            nft_id    : 0x2::object::id<NormieNFT>(&v3),
            recipient : arg2,
        };
        0x2::event::emit<NFTMinted>(v4);
    }

    public fun name(arg0: &NormieNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun point_multiplier(arg0: &NormieNFT) : &u16 {
        &arg0.point_multiplier
    }

    public entry fun remove_item<T0: store + key>(arg0: &mut NormieNFT, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, slot_to_name(arg1));
        let v1 = ItemRemoved<T0>{
            nft_id  : 0x2::object::id<NormieNFT>(arg0),
            item_id : 0x2::object::id<T0>(&v0),
        };
        0x2::event::emit<ItemRemoved<T0>>(v1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    fun slot_to_name(arg0: u8) : vector<u8> {
        if (arg0 == 1) {
            b"head"
        } else if (arg0 == 2) {
            b"body"
        } else if (arg0 == 3) {
            b"arms"
        } else if (arg0 == 4) {
            b"eyes"
        } else if (arg0 == 5) {
            b"mouth"
        } else {
            b"head"
        }
    }

    public fun u64_to_string(arg0: u64) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    public fun update_config_extension(arg0: &NormieAdminCap, arg1: &mut NormieConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.extension = arg2;
    }

    public fun update_config_image_url(arg0: &NormieAdminCap, arg1: &mut NormieConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = arg2;
    }

    public fun update_config_main_url(arg0: &NormieAdminCap, arg1: &mut NormieConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.main_url = arg2;
    }

    public fun update_display_field(arg0: &NormieAdminCap, arg1: &mut 0x2::display::Display<NormieNFT>, arg2: vector<u8>, arg3: vector<u8>) {
        0x2::display::edit<NormieNFT>(arg1, 0x1::string::utf8(arg2), 0x1::string::utf8(arg3));
        0x2::display::update_version<NormieNFT>(arg1);
    }

    public fun xp(arg0: &NormieNFT) : &u128 {
        &arg0.xp
    }

    // decompiled from Move bytecode v6
}

