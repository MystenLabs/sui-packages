module 0xf4f25b35164a9cfaaec7a0313f873810160f4a713d511708569adcdd31ab8216::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        mint_price: u64,
        royalty_bps: u16,
        is_minting_enabled: bool,
        comic_count: u64,
        comics_minted: u64,
        comics: 0x2::table::Table<u64, ComicStrip>,
    }

    struct ComicStrip has store {
        title: 0x1::string::String,
        description: 0x1::string::String,
        strip_number: u64,
        content_url: 0x1::string::String,
        release_date: 0x1::string::String,
        is_available: bool,
    }

    struct ComicNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        collection_id: 0x2::object::ID,
        strip_number: u64,
        content_url: 0x2::url::Url,
        release_date: 0x1::string::String,
        mint_timestamp: u64,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct ComicStripAdded has copy, drop {
        collection_id: 0x2::object::ID,
        strip_number: u64,
        title: 0x1::string::String,
    }

    struct ComicNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        strip_number: u64,
        recipient: address,
    }

    struct TransferPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct RoyaltyRule has drop, store {
        rate_bps: u16,
    }

    public entry fun add_comic_strip(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 1);
        arg1.comic_count = arg1.comic_count + 1;
        let v0 = arg1.comic_count;
        let v1 = ComicStrip{
            title        : 0x1::string::utf8(arg2),
            description  : 0x1::string::utf8(arg3),
            strip_number : v0,
            content_url  : 0x1::string::utf8(arg4),
            release_date : 0x1::string::utf8(arg5),
            is_available : true,
        };
        0x2::table::add<u64, ComicStrip>(&mut arg1.comics, v0, v1);
        let v2 = ComicStripAdded{
            collection_id : 0x2::object::id<Collection>(arg1),
            strip_number  : v0,
            title         : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<ComicStripAdded>(v2);
    }

    public entry fun configure_royalty(arg0: &0x2::transfer_policy::TransferPolicyCap<ComicNFT>, arg1: &mut 0x2::transfer_policy::TransferPolicy<ComicNFT>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2500, 6);
        let v0 = RoyaltyRule{rate_bps: arg2};
        0x2::transfer_policy::add_rule<ComicNFT, RoyaltyRule, u16>(v0, arg1, arg0, arg2);
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 2500, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Collection{
            id                 : 0x2::object::new(arg4),
            name               : 0x1::string::utf8(arg0),
            description        : 0x1::string::utf8(arg1),
            creator            : v0,
            mint_price         : arg2,
            royalty_bps        : arg3,
            is_minting_enabled : false,
            comic_count        : 0,
            comics_minted      : 0,
            comics             : 0x2::table::new<u64, ComicStrip>(arg4),
        };
        let v2 = 0x2::object::id<Collection>(&v1);
        let v3 = AdminCap{
            id            : 0x2::object::new(arg4),
            collection_id : v2,
        };
        let v4 = CollectionCreated{
            collection_id : v2,
            name          : 0x1::string::utf8(arg0),
            creator       : v0,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::transfer<AdminCap>(v3, v0);
        0x2::transfer::share_object<Collection>(v1);
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
    }

    public fun get_collection_info(arg0: &Collection) : (0x1::string::String, 0x1::string::String, u64, u16, u64, u64, bool) {
        (arg0.name, arg0.description, arg0.mint_price, arg0.royalty_bps, arg0.comic_count, arg0.comics_minted, arg0.is_minting_enabled)
    }

    public fun get_comic_info(arg0: &Collection, arg1: u64) : (bool, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, bool) {
        if (0x2::table::contains<u64, ComicStrip>(&arg0.comics, arg1)) {
            let v6 = 0x2::table::borrow<u64, ComicStrip>(&arg0.comics, arg1);
            (true, v6.title, v6.description, v6.content_url, v6.release_date, v6.is_available)
        } else {
            (false, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), false)
        }
    }

    public fun get_comic_nft_info(arg0: &ComicNFT) : (0x2::object::ID, 0x1::string::String, 0x1::string::String, 0x2::object::ID, u64, 0x2::url::Url, 0x1::string::String) {
        (0x2::object::id<ComicNFT>(arg0), arg0.title, arg0.description, arg0.collection_id, arg0.strip_number, arg0.content_url, arg0.release_date)
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<ComicNFT>(&v0, arg1);
        0x2::display::add<ComicNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<ComicNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ComicNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{content_url}"));
        0x2::display::add<ComicNFT>(&mut v1, 0x1::string::utf8(b"strip_number"), 0x1::string::utf8(b"{strip_number}"));
        0x2::display::add<ComicNFT>(&mut v1, 0x1::string::utf8(b"release_date"), 0x1::string::utf8(b"{release_date}"));
        0x2::display::update_version<ComicNFT>(&mut v1);
        let v2 = 0x2::display::new<Collection>(&v0, arg1);
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::update_version<Collection>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<ComicNFT>(&v0, arg1);
        let v5 = v3;
        let v6 = TransferPolicyCreated{policy_id: 0x2::object::id<0x2::transfer_policy::TransferPolicy<ComicNFT>>(&v5)};
        0x2::event::emit<TransferPolicyCreated>(v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ComicNFT>>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ComicNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ComicNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_comic(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting_enabled, 4);
        assert!(0x2::table::contains<u64, ComicStrip>(&arg0.comics, arg1), 2);
        let v0 = 0x2::object::id<Collection>(arg0);
        let v1 = 0x2::table::borrow_mut<u64, ComicStrip>(&mut arg0.comics, arg1);
        assert!(v1.is_available, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.mint_price, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg0.mint_price, arg3), arg0.creator);
        let v2 = ComicNFT{
            id             : 0x2::object::new(arg3),
            title          : v1.title,
            description    : v1.description,
            collection_id  : v0,
            strip_number   : v1.strip_number,
            content_url    : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v1.content_url)),
            release_date   : v1.release_date,
            mint_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        v1.is_available = false;
        arg0.comics_minted = arg0.comics_minted + 1;
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = ComicNFTMinted{
            nft_id        : 0x2::object::id<ComicNFT>(&v2),
            collection_id : v0,
            strip_number  : arg1,
            recipient     : v3,
        };
        0x2::event::emit<ComicNFTMinted>(v4);
        0x2::transfer::transfer<ComicNFT>(v2, v3);
    }

    public entry fun mint_comic_to_kiosk(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting_enabled, 4);
        assert!(0x2::table::contains<u64, ComicStrip>(&arg0.comics, arg1), 2);
        let v0 = 0x2::object::id<Collection>(arg0);
        let v1 = 0x2::table::borrow_mut<u64, ComicStrip>(&mut arg0.comics, arg1);
        assert!(v1.is_available, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.mint_price, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg0.mint_price, arg5), arg0.creator);
        let v2 = ComicNFT{
            id             : 0x2::object::new(arg5),
            title          : v1.title,
            description    : v1.description,
            collection_id  : v0,
            strip_number   : v1.strip_number,
            content_url    : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v1.content_url)),
            release_date   : v1.release_date,
            mint_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        v1.is_available = false;
        arg0.comics_minted = arg0.comics_minted + 1;
        let v3 = ComicNFTMinted{
            nft_id        : 0x2::object::id<ComicNFT>(&v2),
            collection_id : v0,
            strip_number  : arg1,
            recipient     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ComicNFTMinted>(v3);
        0x2::kiosk::place<ComicNFT>(arg3, arg4, v2);
    }

    public entry fun set_comic_availability(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: bool) {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 1);
        assert!(0x2::table::contains<u64, ComicStrip>(&arg1.comics, arg2), 2);
        0x2::table::borrow_mut<u64, ComicStrip>(&mut arg1.comics, arg2).is_available = arg3;
    }

    public entry fun set_mint_price(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 1);
        arg1.mint_price = arg2;
    }

    public entry fun set_minting_status(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 1);
        arg1.is_minting_enabled = arg2;
    }

    public entry fun set_royalty_bps(arg0: &AdminCap, arg1: &mut Collection, arg2: u16) {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 1);
        assert!(arg2 <= 2500, 6);
        arg1.royalty_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

