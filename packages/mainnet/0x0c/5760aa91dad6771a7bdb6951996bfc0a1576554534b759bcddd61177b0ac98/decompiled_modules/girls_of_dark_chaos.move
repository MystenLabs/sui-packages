module 0xc5760aa91dad6771a7bdb6951996bfc0a1576554534b759bcddd61177b0ac98::girls_of_dark_chaos {
    struct GIRLS_OF_DARK_CHAOS has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GirlsOfDarkChaosNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        token_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        address_minted: 0x2::table::Table<address, u64>,
        blob_ids: 0x2::table::Table<u64, 0x1::string::String>,
        is_minting_paused: bool,
        aggregator_url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        token_id: u64,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct NFTBurned has copy, drop {
        token_id: u64,
        owner: address,
    }

    struct MetadataUpdated has copy, drop {
        token_id: u64,
    }

    struct MintingPaused has copy, drop {
        dummy_field: bool,
    }

    struct MintingResumed has copy, drop {
        dummy_field: bool,
    }

    struct BlobIdUpdated has copy, drop {
        token_id: u64,
        new_blob_id: 0x1::string::String,
    }

    struct AggregatorUrlUpdated has copy, drop {
        new_url: 0x1::string::String,
    }

    public entry fun burn(arg0: GirlsOfDarkChaosNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTBurned{
            token_id : arg0.token_id,
            owner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTBurned>(v0);
        let GirlsOfDarkChaosNFT {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            token_id    : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_metadata(arg0: &GirlsOfDarkChaosNFT) : (&0x1::string::String, &0x1::string::String, &0x2::url::Url, &u64, &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        (&arg0.name, &arg0.description, &arg0.image_url, &arg0.token_id, &arg0.attributes)
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted_count
    }

    public fun get_treasury_balance(arg0: &Collection) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: GIRLS_OF_DARK_CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Collection{
            id                : 0x2::object::new(arg1),
            minted_count      : 0,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            address_minted    : 0x2::table::new<address, u64>(arg1),
            blob_ids          : 0x2::table::new<u64, 0x1::string::String>(arg1),
            is_minting_paused : false,
            aggregator_url    : 0x1::string::utf8(b"https://walrus.tusky.io/"),
        };
        0x2::transfer::share_object<Collection>(v1);
        let v2 = 0x2::package::claim<GIRLS_OF_DARK_CHAOS>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"token_id"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{token_id}"));
        let v7 = 0x2::display::new_with_fields<GirlsOfDarkChaosNFT>(&v2, v3, v5, arg1);
        0x2::display::update_version<GirlsOfDarkChaosNFT>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<GirlsOfDarkChaosNFT>(&v2, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GirlsOfDarkChaosNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GirlsOfDarkChaosNFT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaosNFT>>(v8);
    }

    public entry fun initialize_blob_ids(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        while (v0 <= 10) {
            0x2::table::add<u64, 0x1::string::String>(&mut arg1.blob_ids, v0, *0x1::vector::borrow<0x1::string::String>(&arg2, v0 - 1));
            v0 = v0 + 1;
        };
    }

    fun int_to_string(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
            return v0
        };
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 48 + ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut Collection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_minting_paused, 6);
        assert!(arg2.minted_count < 10, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 10000000, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (0x2::table::contains<address, u64>(&arg2.address_minted, v0)) {
            *0x2::table::borrow<address, u64>(&arg2.address_minted, v0)
        } else {
            0
        };
        assert!(v1 < 5, 7);
        if (0x2::table::contains<address, u64>(&arg2.address_minted, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg2.address_minted, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg2.address_minted, v0, 1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg2.minted_count = arg2.minted_count + 1;
        let v2 = arg2.minted_count;
        let v3 = pseudo_random(arg4);
        let v4 = if (v3 % 100 < 10) {
            0x1::string::utf8(b"Legendary")
        } else if (v3 % 100 < 30) {
            0x1::string::utf8(b"Rare")
        } else {
            0x1::string::utf8(b"Common")
        };
        let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(b"GirlsOfDarkChaos"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"TokenID"), 0x1::string::utf8(int_to_string(v2)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Rarity"), v4);
        assert!(0x2::table::contains<u64, 0x1::string::String>(&arg2.blob_ids, v2), 3);
        let v6 = 0x1::ascii::into_bytes(0x1::string::to_ascii(arg2.aggregator_url));
        0x1::vector::append<u8>(&mut v6, 0x1::ascii::into_bytes(0x1::string::to_ascii(*0x2::table::borrow<u64, 0x1::string::String>(&arg2.blob_ids, v2))));
        let v7 = GirlsOfDarkChaosNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(v6),
            token_id    : v2,
            attributes  : v5,
        };
        let v8 = NFTMinted{
            token_id   : v2,
            owner      : v0,
            name       : v7.name,
            image_url  : v7.image_url,
            attributes : v7.attributes,
        };
        0x2::event::emit<NFTMinted>(v8);
        0x2::transfer::public_transfer<GirlsOfDarkChaosNFT>(v7, v0);
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_minting_paused = true;
        let v0 = MintingPaused{dummy_field: false};
        0x2::event::emit<MintingPaused>(v0);
    }

    public entry fun pay_royalty(arg0: &mut Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg2 * 300 / 10000, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun pseudo_random(arg0: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::digest(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            v1 = v1 + (*0x1::vector::borrow<u8>(v0, v2) as u64);
            v2 = v2 + 1;
        };
        v1
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_minting_paused = false;
        let v0 = MintingResumed{dummy_field: false};
        0x2::event::emit<MintingResumed>(v0);
    }

    public entry fun update_aggregator_url(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.aggregator_url = 0x1::string::utf8(arg2);
        let v0 = AggregatorUrlUpdated{new_url: arg1.aggregator_url};
        0x2::event::emit<AggregatorUrlUpdated>(v0);
    }

    public entry fun update_blob_id(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, 0x1::string::String>(&arg1.blob_ids, arg2), 3);
        *0x2::table::borrow_mut<u64, 0x1::string::String>(&mut arg1.blob_ids, arg2) = arg3;
        let v0 = BlobIdUpdated{
            token_id    : arg2,
            new_blob_id : arg3,
        };
        0x2::event::emit<BlobIdUpdated>(v0);
    }

    public entry fun update_metadata(arg0: &AdminCap, arg1: &mut GirlsOfDarkChaosNFT, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.name = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        let v0 = MetadataUpdated{token_id: arg1.token_id};
        0x2::event::emit<MetadataUpdated>(v0);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = TreasuryWithdrawn{
            amount    : arg2,
            recipient : v0,
        };
        0x2::event::emit<TreasuryWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

