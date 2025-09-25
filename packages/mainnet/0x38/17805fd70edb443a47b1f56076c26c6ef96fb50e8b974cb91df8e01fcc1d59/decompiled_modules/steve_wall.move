module 0x3817805fd70edb443a47b1f56076c26c6ef96fb50e8b974cb91df8e01fcc1d59::steve_wall {
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
        metadata_url: 0x1::string::String,
        last_updated: u64,
    }

    struct MetadataRegistry has key {
        id: 0x2::object::UID,
        metadata: 0x2::table::Table<u32, PixelMetadata>,
    }

    struct SteveWall has key {
        id: 0x2::object::UID,
        ownership: 0x2::table::Table<u32, 0x2::object::ID>,
        total_pixels: u64,
        pixels_sold: u64,
        total_sales: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        price_per_pixel: u64,
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
        coordinates: vector<Coordinate>,
        metadata_url: 0x1::string::String,
        epoch: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        recipient: address,
        epoch: u64,
    }

    public fun coord_to_key(arg0: &Coordinate) : u32 {
        (arg0.x as u32) + (arg0.y as u32) * (1000 as u32)
    }

    public fun get_nft_info(arg0: &PixelNFT) : (u64, u64, u64) {
        (arg0.pixel_count, arg0.purchase_price, arg0.purchase_epoch)
    }

    public fun get_pixel_metadata(arg0: &MetadataRegistry, arg1: &Coordinate) : &PixelMetadata {
        0x2::table::borrow<u32, PixelMetadata>(&arg0.metadata, coord_to_key(arg1))
    }

    public fun get_pixel_owner(arg0: &SteveWall, arg1: &Coordinate) : 0x2::object::ID {
        *0x2::table::borrow<u32, 0x2::object::ID>(&arg0.ownership, coord_to_key(arg1))
    }

    public fun get_stats(arg0: &SteveWall) : (u64, u64, u64, u64) {
        (arg0.pixels_sold, arg0.total_pixels, arg0.total_sales, arg0.price_per_pixel)
    }

    public fun get_treasury_balance(arg0: &SteveWall) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SteveWall{
            id              : 0x2::object::new(arg0),
            ownership       : 0x2::table::new<u32, 0x2::object::ID>(arg0),
            total_pixels    : (1000 as u64) * (1000 as u64),
            pixels_sold     : 0,
            total_sales     : 0,
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            admin           : v0,
            price_per_pixel : 10000000,
            paused          : false,
        };
        let v2 = MetadataRegistry{
            id       : 0x2::object::new(arg0),
            metadata : 0x2::table::new<u32, PixelMetadata>(arg0),
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SteveWall>(v1);
        0x2::transfer::share_object<MetadataRegistry>(v2);
        0x2::transfer::transfer<AdminCap>(v3, v0);
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

    public entry fun purchase_rectangle(arg0: &mut SteveWall, arg1: &mut MetadataRegistry, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 5);
        let v0 = (arg4 as u64) * (arg5 as u64);
        let v1 = v0 * arg0.price_per_pixel;
        assert!(v0 > 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v1, 0);
        assert!(arg2 + arg4 <= 1000 && arg3 + arg5 <= 1000, 3);
        let v2 = 0x1::vector::empty<Coordinate>();
        let v3 = 0;
        while (v3 < arg5) {
            let v4 = 0;
            while (v4 < arg4) {
                let v5 = Coordinate{
                    x : arg2 + v4,
                    y : arg3 + v3,
                };
                0x1::vector::push_back<Coordinate>(&mut v2, v5);
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        let v6 = 0x2::tx_context::epoch(arg7);
        let v7 = PixelNFT{
            id             : 0x2::object::new(arg7),
            coordinates    : v2,
            pixel_count    : v0,
            purchase_price : v1,
            purchase_epoch : v6,
        };
        let v8 = 0x2::object::id<PixelNFT>(&v7);
        let v9 = 0x2::tx_context::sender(arg7);
        let v10 = 0;
        while (v10 < v0) {
            let v11 = 0x1::vector::borrow<Coordinate>(&v7.coordinates, v10);
            assert!(v11.x < 1000 && v11.y < 1000, 3);
            assert!(!0x2::table::contains<u32, 0x2::object::ID>(&arg0.ownership, coord_to_key(v11)), 1);
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < v0) {
            let v12 = coord_to_key(0x1::vector::borrow<Coordinate>(&v7.coordinates, v10));
            0x2::table::add<u32, 0x2::object::ID>(&mut arg0.ownership, v12, v8);
            let v13 = PixelMetadata{
                metadata_url : 0x1::string::utf8(b""),
                last_updated : v6,
            };
            0x2::table::add<u32, PixelMetadata>(&mut arg1.metadata, v12, v13);
            v10 = v10 + 1;
        };
        arg0.pixels_sold = arg0.pixels_sold + v0;
        arg0.total_sales = arg0.total_sales + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v14 = PixelsPurchased{
            buyer       : v9,
            nft_id      : v8,
            coordinates : v7.coordinates,
            pixel_count : v0,
            total_cost  : v1,
            epoch       : v6,
        };
        0x2::event::emit<PixelsPurchased>(v14);
        0x2::transfer::transfer<PixelNFT>(v7, v9);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut SteveWall, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun update_metadata(arg0: &PixelNFT, arg1: &SteveWall, arg2: &mut MetadataRegistry, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        let v0 = 0x2::object::id<PixelNFT>(arg0);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = &arg0.coordinates;
        validate_metadata_url(&arg3);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Coordinate>(v2)) {
            let v4 = coord_to_key(0x1::vector::borrow<Coordinate>(v2, v3));
            assert!(0x2::table::contains<u32, 0x2::object::ID>(&arg1.ownership, v4), 1);
            assert!(*0x2::table::borrow<u32, 0x2::object::ID>(&arg1.ownership, v4) == v0, 2);
            let v5 = 0x2::table::borrow_mut<u32, PixelMetadata>(&mut arg2.metadata, v4);
            v5.metadata_url = arg3;
            v5.last_updated = v1;
            v3 = v3 + 1;
        };
        let v6 = MetadataUpdated{
            nft_id       : v0,
            updater      : 0x2::tx_context::sender(arg4),
            coordinates  : *v2,
            metadata_url : arg3,
            epoch        : v1,
        };
        0x2::event::emit<MetadataUpdated>(v6);
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut SteveWall, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price_per_pixel = arg2;
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

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut SteveWall, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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

