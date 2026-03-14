module 0x7f9b7aee2cdec0b507d51aa5a82b800bff8307402142f39402aa61bd4e7d2166::nft_storefront {
    struct NFT_STOREFRONT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ArtNFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        collection: vector<u8>,
        image_url: vector<u8>,
        image_blob_id: vector<u8>,
        edition: u64,
        total_editions: u64,
        artist: vector<u8>,
        royalty_bps: u64,
    }

    struct Listing has drop, store {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        admin: address,
        nfts: 0x2::object_table::ObjectTable<0x2::object::ID, ArtNFT>,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        total_sales: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: vector<u8>,
        collection: vector<u8>,
    }

    struct NFTListed has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
    }

    struct NFTPurchased has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct NFTDelisted has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct PriceUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    public fun delist(arg0: &AdminCap, arg1: &mut Marketplace, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg1.listings, arg2), 1);
        assert!(0x2::object_table::contains<0x2::object::ID, ArtNFT>(&arg1.nfts, arg2), 2);
        0x2::table::remove<0x2::object::ID, Listing>(&mut arg1.listings, arg2);
        let v0 = NFTDelisted{nft_id: arg2};
        0x2::event::emit<NFTDelisted>(v0);
        0x2::transfer::public_transfer<ArtNFT>(0x2::object_table::remove<0x2::object::ID, ArtNFT>(&mut arg1.nfts, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun get_price(arg0: &Marketplace, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 1);
        0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).price
    }

    fun init(arg0: NFT_STOREFRONT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Marketplace{
            id          : 0x2::object::new(arg1),
            admin       : 0x2::tx_context::sender(arg1),
            nfts        : 0x2::object_table::new<0x2::object::ID, ArtNFT>(arg1),
            listings    : 0x2::table::new<0x2::object::ID, Listing>(arg1),
            total_sales : 0,
        };
        0x2::transfer::share_object<Marketplace>(v1);
        let v2 = 0x2::package::claim<NFT_STOREFRONT>(arg0, arg1);
        let v3 = 0x2::display::new<ArtNFT>(&v2, arg1);
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"{collection}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"artist"), 0x1::string::utf8(b"{artist}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display::add<ArtNFT>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://alekblom.com/art"));
        0x2::display::update_version<ArtNFT>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<ArtNFT>(&v2, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ArtNFT>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ArtNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ArtNFT>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_listed(arg0: &Marketplace, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)
    }

    public fun mint_and_list(arg0: &AdminCap, arg1: &mut Marketplace, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ArtNFT{
            id             : 0x2::object::new(arg12),
            name           : arg2,
            description    : arg3,
            collection     : arg4,
            image_url      : arg5,
            image_blob_id  : arg6,
            edition        : arg7,
            total_editions : arg8,
            artist         : arg9,
            royalty_bps    : arg10,
        };
        let v1 = 0x2::object::id<ArtNFT>(&v0);
        let v2 = NFTMinted{
            nft_id     : v1,
            name       : v0.name,
            collection : v0.collection,
        };
        0x2::event::emit<NFTMinted>(v2);
        let v3 = Listing{
            nft_id : v1,
            price  : arg11,
            seller : 0x2::tx_context::sender(arg12),
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg1.listings, v1, v3);
        0x2::object_table::add<0x2::object::ID, ArtNFT>(&mut arg1.nfts, v1, v0);
        let v4 = NFTListed{
            nft_id : v1,
            price  : arg11,
        };
        0x2::event::emit<NFTListed>(v4);
        v1
    }

    public fun purchase<T0>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 1);
        assert!(0x2::object_table::contains<0x2::object::ID, ArtNFT>(&arg0.nfts, arg1), 2);
        let Listing {
            nft_id : _,
            price  : v1,
            seller : v2,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v2);
        let v3 = NFTPurchased{
            nft_id : arg1,
            buyer  : 0x2::tx_context::sender(arg3),
            price  : v1,
        };
        0x2::event::emit<NFTPurchased>(v3);
        arg0.total_sales = arg0.total_sales + 1;
        0x2::transfer::public_transfer<ArtNFT>(0x2::object_table::remove<0x2::object::ID, ArtNFT>(&mut arg0.nfts, arg1), 0x2::tx_context::sender(arg3));
    }

    public fun royalty_bps(arg0: &ArtNFT) : u64 {
        arg0.royalty_bps
    }

    public fun total_sales(arg0: &Marketplace) : u64 {
        arg0.total_sales
    }

    public fun update_price(arg0: &AdminCap, arg1: &mut Marketplace, arg2: 0x2::object::ID, arg3: u64) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg1.listings, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg1.listings, arg2);
        v0.price = arg3;
        let v1 = PriceUpdated{
            nft_id    : arg2,
            old_price : v0.price,
            new_price : arg3,
        };
        0x2::event::emit<PriceUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

