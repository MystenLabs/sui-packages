module 0xc2934a547584daa04cfd850d861b50c2c14e3fb6aa6970f4d5fb489102b4e5f0::steve_wall {
    struct STEVE_WALL has drop {
        dummy_field: bool,
    }

    struct Coordinate has copy, drop, store {
        x: u16,
        y: u16,
    }

    struct PixelNFT has store, key {
        id: 0x2::object::UID,
        coordinates: vector<Coordinate>,
        pixel_count: u64,
        purchase_price: u64,
        purchase_epoch: u64,
    }

    struct PixelMetadata has drop, store {
        image_url: 0x1::string::String,
        link_url: 0x1::string::String,
        title: 0x1::string::String,
        last_updated: u64,
    }

    struct SteveWall has key {
        id: 0x2::object::UID,
        ownership: 0x2::table::Table<u32, 0x2::object::ID>,
        user_pixel_counts: 0x2::table::Table<address, u64>,
        total_pixels: u64,
        pixels_sold: u64,
        total_sales: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        price_per_pixel: u64,
        max_pixels_per_wallet: u64,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PixelsPurchased has copy, drop {
        buyer: address,
        nft_id: 0x2::object::ID,
        coordinates: vector<Coordinate>,
        pixel_count: u64,
        total_cost: u64,
        epoch: u64,
    }

    struct MetadataUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        updater: address,
        image_url: 0x1::string::String,
        link_url: 0x1::string::String,
        title: 0x1::string::String,
        epoch: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        recipient: address,
        epoch: u64,
    }

    struct PriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        epoch: u64,
    }

    struct MaxPixelsUpdated has copy, drop {
        old_max: u64,
        new_max: u64,
        epoch: u64,
    }

    public fun coord_to_key(arg0: &Coordinate) : u32 {
        (arg0.x as u32) + (arg0.y as u32) * (1000 as u32)
    }

    public fun get_metadata(arg0: &PixelNFT) : &PixelMetadata {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 8);
        0x2::dynamic_field::borrow<vector<u8>, PixelMetadata>(&arg0.id, b"metadata")
    }

    public fun get_nft_coordinates(arg0: &PixelNFT) : &vector<Coordinate> {
        &arg0.coordinates
    }

    public fun get_nft_info(arg0: &PixelNFT) : (u64, u64, u64) {
        (arg0.pixel_count, arg0.purchase_price, arg0.purchase_epoch)
    }

    public fun get_pixel_owner(arg0: &SteveWall, arg1: &Coordinate) : 0x2::object::ID {
        *0x2::table::borrow<u32, 0x2::object::ID>(&arg0.ownership, coord_to_key(arg1))
    }

    public fun get_stats(arg0: &SteveWall) : (u64, u64, u64, u64, u64) {
        (arg0.pixels_sold, arg0.total_pixels, arg0.total_sales, arg0.price_per_pixel, arg0.max_pixels_per_wallet)
    }

    public fun get_treasury_balance(arg0: &SteveWall) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun get_user_pixel_count(arg0: &SteveWall, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_pixel_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_pixel_counts, arg1)
        } else {
            0
        }
    }

    fun init(arg0: STEVE_WALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<STEVE_WALL>(arg0, arg1);
        let v2 = 0x2::display::new<PixelNFT>(&v1, arg1);
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Steve Wall - {pixel_count} Pixels"));
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Own a piece of the million pixel wall. Adjacent pixels form a tradeable NFT with editable display."));
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{link_url}"));
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://stevewall.io"));
        0x2::display::add<PixelNFT>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Steve Wall Team"));
        0x2::display::update_version<PixelNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<PixelNFT>>(v2, v0);
        let (v3, v4) = 0x2::transfer_policy::new<PixelNFT>(&v1, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PixelNFT>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PixelNFT>>(v4, v0);
        let v5 = SteveWall{
            id                    : 0x2::object::new(arg1),
            ownership             : 0x2::table::new<u32, 0x2::object::ID>(arg1),
            user_pixel_counts     : 0x2::table::new<address, u64>(arg1),
            total_pixels          : (1000 as u64) * (1000 as u64),
            pixels_sold           : 0,
            total_sales           : 0,
            treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                 : v0,
            price_per_pixel       : 100000000,
            max_pixels_per_wallet : 1000,
            paused                : false,
        };
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<SteveWall>(v5);
        0x2::transfer::transfer<AdminCap>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun is_pixel_owned(arg0: &SteveWall, arg1: &Coordinate) : bool {
        0x2::table::contains<u32, 0x2::object::ID>(&arg0.ownership, coord_to_key(arg1))
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun purchase_rectangle(arg0: &mut SteveWall, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch(arg6);
        let v2 = (arg3 as u64) * (arg4 as u64);
        let v3 = v2 * arg0.price_per_pixel;
        assert!(v2 > 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 0);
        assert!(arg1 + arg3 <= 1000 && arg2 + arg4 <= 1000, 3);
        let v4 = if (0x2::table::contains<address, u64>(&arg0.user_pixel_counts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_pixel_counts, v0)
        } else {
            0
        };
        assert!(v4 + v2 <= arg0.max_pixels_per_wallet, 7);
        let v5 = 0x1::vector::empty<Coordinate>();
        let v6 = 0;
        while (v6 < arg4) {
            let v7 = 0;
            while (v7 < arg3) {
                let v8 = Coordinate{
                    x : arg1 + v7,
                    y : arg2 + v6,
                };
                0x1::vector::push_back<Coordinate>(&mut v5, v8);
                v7 = v7 + 1;
            };
            v6 = v6 + 1;
        };
        let v9 = 0;
        while (v9 < v2) {
            let v10 = 0x1::vector::borrow<Coordinate>(&v5, v9);
            assert!(v10.x < 1000 && v10.y < 1000, 3);
            assert!(!0x2::table::contains<u32, 0x2::object::ID>(&arg0.ownership, coord_to_key(v10)), 1);
            v9 = v9 + 1;
        };
        let v11 = PixelNFT{
            id             : 0x2::object::new(arg6),
            coordinates    : v5,
            pixel_count    : v2,
            purchase_price : v3,
            purchase_epoch : v1,
        };
        let v12 = 0x2::object::id<PixelNFT>(&v11);
        let v13 = PixelMetadata{
            image_url    : 0x1::string::utf8(b""),
            link_url     : 0x1::string::utf8(b""),
            title        : 0x1::string::utf8(b""),
            last_updated : v1,
        };
        0x2::dynamic_field::add<vector<u8>, PixelMetadata>(&mut v11.id, b"metadata", v13);
        v9 = 0;
        while (v9 < v2) {
            0x2::table::add<u32, 0x2::object::ID>(&mut arg0.ownership, coord_to_key(0x1::vector::borrow<Coordinate>(&v11.coordinates, v9)), v12);
            v9 = v9 + 1;
        };
        if (0x2::table::contains<address, u64>(&arg0.user_pixel_counts, v0)) {
            let v14 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_pixel_counts, v0);
            *v14 = *v14 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_pixel_counts, v0, v2);
        };
        arg0.pixels_sold = arg0.pixels_sold + v2;
        arg0.total_sales = arg0.total_sales + v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v15 = PixelsPurchased{
            buyer       : v0,
            nft_id      : v12,
            coordinates : v11.coordinates,
            pixel_count : v2,
            total_cost  : v3,
            epoch       : v1,
        };
        0x2::event::emit<PixelsPurchased>(v15);
        0x2::transfer::transfer<PixelNFT>(v11, v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut SteveWall, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public fun update_max_pixels_per_wallet(arg0: &AdminCap, arg1: &mut SteveWall, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_pixels_per_wallet = arg2;
        let v0 = MaxPixelsUpdated{
            old_max : arg1.max_pixels_per_wallet,
            new_max : arg2,
            epoch   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MaxPixelsUpdated>(v0);
    }

    public fun update_metadata(arg0: &mut PixelNFT, arg1: &SteveWall, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        let v0 = 0x2::object::id<PixelNFT>(arg0);
        let v1 = 0x2::tx_context::epoch(arg5);
        let v2 = coord_to_key(0x1::vector::borrow<Coordinate>(&arg0.coordinates, 0));
        assert!(0x2::table::contains<u32, 0x2::object::ID>(&arg1.ownership, v2), 2);
        assert!(*0x2::table::borrow<u32, 0x2::object::ID>(&arg1.ownership, v2) == v0, 2);
        validate_metadata_url(&arg2);
        validate_metadata_url(&arg3);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            0x2::dynamic_field::remove<vector<u8>, PixelMetadata>(&mut arg0.id, b"metadata");
        };
        let v3 = PixelMetadata{
            image_url    : arg2,
            link_url     : arg3,
            title        : arg4,
            last_updated : v1,
        };
        0x2::dynamic_field::add<vector<u8>, PixelMetadata>(&mut arg0.id, b"metadata", v3);
        let v4 = MetadataUpdated{
            nft_id    : v0,
            updater   : 0x2::tx_context::sender(arg5),
            image_url : arg2,
            link_url  : arg3,
            title     : arg4,
            epoch     : v1,
        };
        0x2::event::emit<MetadataUpdated>(v4);
    }

    public fun update_price(arg0: &AdminCap, arg1: &mut SteveWall, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1000000, 4);
        arg1.price_per_pixel = arg2;
        let v0 = PriceUpdated{
            old_price : arg1.price_per_pixel,
            new_price : arg2,
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    fun validate_metadata_url(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return
        };
        assert!(v1 >= 10, 6);
        let v2 = false;
        if (v1 > 9) {
            let v3 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v3, b"walrus://");
            if (is_prefix(v0, &v3)) {
                v2 = true;
            };
        };
        if (!v2 && v1 > 7) {
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v4, b"ipfs://");
            if (is_prefix(v0, &v4)) {
                v2 = true;
            };
        };
        if (!v2 && v1 > 8) {
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v5, b"https://");
            if (is_prefix(v0, &v5)) {
                v2 = true;
            };
        };
        assert!(v2, 6);
    }

    public fun withdraw_treasury(arg0: &AdminCap, arg1: &mut SteveWall, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg4), arg3);
        let v0 = TreasuryWithdrawal{
            amount    : arg2,
            recipient : arg3,
            epoch     : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

