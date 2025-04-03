module 0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui {
    struct PIXSUI has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct TileManager has store, key {
        id: 0x2::object::UID,
        admin: address,
        next_tile_id: u64,
        tile_positions: 0x2::table::Table<TilePosition, 0x2::object::ID>,
        prices: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        default_token: 0x1::string::String,
        default_price: u64,
        paused: bool,
    }

    struct TilePosition has copy, drop, store {
        x: u64,
        y: u64,
    }

    struct TileMetadata has copy, drop, store {
        description: 0x1::string::String,
        twitter_url: 0x1::string::String,
        telegram_url: 0x1::string::String,
        discord_url: 0x1::string::String,
        website_url: 0x1::string::String,
    }

    struct Tile has store, key {
        id: 0x2::object::UID,
        position: TilePosition,
        owner: address,
        image_data: vector<u8>,
        metadata: TileMetadata,
        for_sale: bool,
        sale_price: u64,
    }

    struct TileCreated has copy, drop {
        tile_id: 0x2::object::ID,
        position: TilePosition,
        creator: address,
    }

    struct TileBought has copy, drop {
        tile_id: 0x2::object::ID,
        position: TilePosition,
        price: u64,
        buyer: address,
        seller: address,
    }

    struct TileUpdated has copy, drop {
        tile_id: 0x2::object::ID,
        position: TilePosition,
        owner: address,
    }

    struct TileListedForSale has copy, drop {
        tile_id: 0x2::object::ID,
        position: TilePosition,
        price: u64,
        owner: address,
    }

    public entry fun buy_tile(arg0: &mut Tile, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        buy_tile_generic<0x2::sui::SUI>(arg0, arg1, arg2);
    }

    public entry fun buy_tile_generic<T0>(arg0: &mut Tile, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.for_sale, 9);
        assert!(get_coin_symbol<T0>() == 0x1::string::utf8(b"SUI"), 10);
        let v0 = arg0.sale_price;
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 7);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = arg0.owner;
        assert!(v1 != v2, 1);
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        if (v3 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v3 - v0), arg2), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg2), v2);
        arg0.owner = v1;
        arg0.for_sale = false;
        arg0.sale_price = 0;
        let v5 = TileBought{
            tile_id  : 0x2::object::id<Tile>(arg0),
            position : arg0.position,
            price    : v0,
            buyer    : v1,
            seller   : v2,
        };
        0x2::event::emit<TileBought>(v5);
    }

    public entry fun cancel_sale(arg0: &mut Tile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.for_sale = false;
        arg0.sale_price = 0;
    }

    public entry fun create_transfer_policy(arg0: &TileManager, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let (v0, v1) = 0x2::transfer_policy::new<Tile>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tile>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tile>>(v1, arg0.admin);
    }

    public fun get_admin(arg0: &TileManager) : address {
        arg0.admin
    }

    fun get_coin_symbol<T0>() : 0x1::string::String {
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            return 0x1::string::utf8(b"SUI")
        };
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_default_price(arg0: &TileManager) : u64 {
        arg0.default_price
    }

    public fun get_default_token(arg0: &TileManager) : 0x1::string::String {
        arg0.default_token
    }

    public fun get_image_data(arg0: &Tile) : vector<u8> {
        arg0.image_data
    }

    public fun get_position(arg0: &Tile) : TilePosition {
        arg0.position
    }

    public fun get_sale_price(arg0: &Tile) : u64 {
        arg0.sale_price
    }

    public fun get_tile_metadata(arg0: &Tile) : TileMetadata {
        arg0.metadata
    }

    public fun get_tile_owner(arg0: &Tile) : address {
        arg0.owner
    }

    public fun get_token_price(arg0: &TileManager, arg1: &0x1::string::String) : u64 {
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&arg0.prices, arg1), 10);
        *0x2::vec_map::get<0x1::string::String, u64>(&arg0.prices, arg1)
    }

    public fun get_token_prices(arg0: &TileManager) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.prices
    }

    fun init(arg0: PIXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"SUI"), 5000000000);
        let v2 = TileManager{
            id             : 0x2::object::new(arg1),
            admin          : v0,
            next_tile_id   : 0,
            tile_positions : 0x2::table::new<TilePosition, 0x2::object::ID>(arg1),
            prices         : v1,
            default_token  : 0x1::string::utf8(b"SUI"),
            default_price  : 5000000000,
            paused         : false,
        };
        let v3 = 0x2::package::claim<PIXSUI>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"collection_image_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Sui Pixel Map Tile #{position_x}_{position_y}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"data:image/png;base64,{image_data}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://pixsui.online"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Sui Pixel Map"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Sui Pixel Map"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Unleash your creativity in the vibrant, decentralized world of PIXSUI, the ultimate pixel art universe built on the lightning-fast Sui Network. Sui Pixel Map is a groundbreaking platform where every pixel tells a story, and every creator owns a piece of the digital canvas."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafkreibxhmujqomldvv3hbpoog7bisemrzphl54wjaitpf5k6luwjpraie"));
        let v8 = 0x2::display::new_with_fields<Tile>(&v3, v4, v6, arg1);
        0x2::display::update_version<Tile>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Tile>>(v8, v0);
        0x2::transfer::public_share_object<TileManager>(v2);
    }

    public fun is_for_sale(arg0: &Tile) : bool {
        arg0.for_sale
    }

    public fun is_token_supported(arg0: &TileManager, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.prices, arg1)
    }

    public entry fun list_for_sale(arg0: &mut Tile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 > 0, 2);
        arg0.for_sale = true;
        arg0.sale_price = arg1;
        let v0 = TileListedForSale{
            tile_id  : 0x2::object::id<Tile>(arg0),
            position : arg0.position,
            price    : arg1,
            owner    : arg0.owner,
        };
        0x2::event::emit<TileListedForSale>(v0);
    }

    public entry fun mint_tile(arg0: &mut TileManager, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        mint_tile_generic<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun mint_tile_generic<T0>(arg0: &mut TileManager, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = TilePosition{
            x : arg1,
            y : arg2,
        };
        assert!(!0x2::table::contains<TilePosition, 0x2::object::ID>(&arg0.tile_positions, v0), 5);
        assert!(0x1::vector::length<u8>(&arg3) <= 32768, 8);
        assert!(0x1::vector::length<u8>(&arg4) <= 500, 8);
        if (0x1::vector::length<u8>(&arg5) > 0) {
            assert!(0x1::vector::length<u8>(&arg5) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg6) > 0) {
            assert!(0x1::vector::length<u8>(&arg6) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg7) > 0) {
            assert!(0x1::vector::length<u8>(&arg7) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg8) > 0) {
            assert!(0x1::vector::length<u8>(&arg8) <= 200, 8);
        };
        let v1 = get_coin_symbol<T0>();
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&arg0.prices, &v1), 10);
        let v2 = *0x2::vec_map::get<0x1::string::String, u64>(&arg0.prices, &v1);
        assert!(0x2::coin::value<T0>(&arg9) >= v2, 7);
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = 0x2::coin::value<T0>(&arg9);
        if (v4 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg9, v4 - v2, arg10), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, arg0.admin);
        let v5 = TileMetadata{
            description  : 0x1::string::utf8(arg4),
            twitter_url  : 0x1::string::utf8(arg5),
            telegram_url : 0x1::string::utf8(arg6),
            discord_url  : 0x1::string::utf8(arg7),
            website_url  : 0x1::string::utf8(arg8),
        };
        let v6 = 0x2::object::new(arg10);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = Tile{
            id         : v6,
            position   : v0,
            owner      : v3,
            image_data : arg3,
            metadata   : v5,
            for_sale   : false,
            sale_price : 0,
        };
        0x2::table::add<TilePosition, 0x2::object::ID>(&mut arg0.tile_positions, v0, v7);
        arg0.next_tile_id = arg0.next_tile_id + 1;
        let v9 = TileCreated{
            tile_id  : v7,
            position : v0,
            creator  : v3,
        };
        0x2::event::emit<TileCreated>(v9);
        0x2::transfer::transfer<Tile>(v8, v3);
    }

    public entry fun set_default_token(arg0: &mut TileManager, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&arg0.prices, &v0), 2);
        arg0.default_token = v0;
        arg0.default_price = *0x2::vec_map::get<0x1::string::String, u64>(&arg0.prices, &arg0.default_token);
    }

    public fun tile_exists(arg0: &TileManager, arg1: u64, arg2: u64) : bool {
        let v0 = TilePosition{
            x : arg1,
            y : arg2,
        };
        0x2::table::contains<TilePosition, 0x2::object::ID>(&arg0.tile_positions, v0)
    }

    public entry fun toggle_pause(arg0: &mut TileManager, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.paused = !arg0.paused;
    }

    public entry fun update_price(arg0: &mut TileManager, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.prices, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.prices, &v0);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.prices, v0, arg2);
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.prices, v0, arg2);
        };
    }

    public entry fun update_tile(arg0: &mut Tile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(0x1::vector::length<u8>(&arg1) <= 32768, 8);
        assert!(0x1::vector::length<u8>(&arg2) <= 500, 8);
        if (0x1::vector::length<u8>(&arg3) > 0) {
            assert!(0x1::vector::length<u8>(&arg3) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg4) > 0) {
            assert!(0x1::vector::length<u8>(&arg4) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg5) > 0) {
            assert!(0x1::vector::length<u8>(&arg5) <= 200, 8);
        };
        if (0x1::vector::length<u8>(&arg6) > 0) {
            assert!(0x1::vector::length<u8>(&arg6) <= 200, 8);
        };
        arg0.image_data = arg1;
        let v0 = TileMetadata{
            description  : 0x1::string::utf8(arg2),
            twitter_url  : 0x1::string::utf8(arg3),
            telegram_url : 0x1::string::utf8(arg4),
            discord_url  : 0x1::string::utf8(arg5),
            website_url  : 0x1::string::utf8(arg6),
        };
        arg0.metadata = v0;
        let v1 = TileUpdated{
            tile_id  : 0x2::object::id<Tile>(arg0),
            position : arg0.position,
            owner    : arg0.owner,
        };
        0x2::event::emit<TileUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

