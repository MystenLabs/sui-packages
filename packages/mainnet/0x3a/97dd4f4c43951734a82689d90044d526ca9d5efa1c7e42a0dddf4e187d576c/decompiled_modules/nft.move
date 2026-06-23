module 0x3a97dd4f4c43951734a82689d90044d526ca9d5efa1c7e42a0dddf4e187d576c::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct SuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        blob_id: 0x1::string::String,
        number: u64,
        design: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        supply: u64,
        minted: u64,
        mint_price: u64,
        treasury: address,
        is_active: bool,
        walrus_aggregator: 0x1::string::String,
        design_blob_ids: vector<0x1::string::String>,
        design_names: vector<0x1::string::String>,
        design_rarities: vector<0x1::string::String>,
        design_queue: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        number: u64,
        design: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    public fun designs_loaded(arg0: &Collection) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.design_blob_ids)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::display::new<SuiNFT>(&v0, arg1);
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"design"), 0x1::string::utf8(b"{design}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"blob_id"), 0x1::string::utf8(b"{blob_id}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://yourwebsite.com"));
        0x2::display::update_version<SuiNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<SuiNFT>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0x3a97dd4f4c43951734a82689d90044d526ca9d5efa1c7e42a0dddf4e187d576c::royalty_rule::add<SuiNFT>(&mut v6, &v5, 200, 0);
        let v7 = Collection{
            id                : 0x2::object::new(arg1),
            name              : 0x1::string::utf8(b"Space Mouse"),
            supply            : 3000,
            minted            : 0,
            mint_price        : 50000000,
            treasury          : @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5,
            is_active         : false,
            walrus_aggregator : 0x1::string::utf8(b"https://aggregator.walrus.space/v1"),
            design_blob_ids   : 0x1::vector::empty<0x1::string::String>(),
            design_names      : 0x1::vector::empty<0x1::string::String>(),
            design_rarities   : 0x1::vector::empty<0x1::string::String>(),
            design_queue      : b"",
        };
        0x2::transfer::share_object<Collection>(v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiNFT>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiNFT>>(v5, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<SuiNFT>>(v2, v1);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, v1);
    }

    public fun is_active(arg0: &Collection) : bool {
        arg0.is_active
    }

    public fun load_design_queue(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1.design_queue) + 0x1::vector::length<u8>(&arg2) <= 3000, 4);
        0x1::vector::append<u8>(&mut arg1.design_queue, arg2);
    }

    public fun load_designs(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        arg1.design_blob_ids = arg2;
        arg1.design_names = arg3;
        arg1.design_rarities = arg4;
    }

    public fun mint(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(arg0.minted < arg0.supply, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg0.design_queue), 3);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg0.design_blob_ids), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.mint_price, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (v0 > arg0.mint_price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0 - arg0.mint_price, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = (0x1::vector::pop_back<u8>(&mut arg0.design_queue) as u64);
        assert!(v2 < 0x1::vector::length<0x1::string::String>(&arg0.design_blob_ids), 6);
        let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0.design_blob_ids, v2);
        let v4 = *0x1::vector::borrow<0x1::string::String>(&arg0.design_names, v2);
        let v5 = *0x1::vector::borrow<0x1::string::String>(&arg0.design_rarities, v2);
        let v6 = arg0.walrus_aggregator;
        0x1::string::append(&mut v6, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v6, v3);
        let v7 = arg0.name;
        0x1::string::append(&mut v7, 0x1::string::utf8(b" #"));
        0x1::string::append_utf8(&mut v7, u64_to_bytes(v1));
        let v8 = SuiNFT{
            id          : 0x2::object::new(arg4),
            name        : v7,
            description : 0x1::string::utf8(b"Space Mouse is a collection of 3,000 mice exploring the Sui ecosystem."),
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v6)),
            blob_id     : v3,
            number      : v1,
            design      : v4,
            rarity      : v5,
        };
        let v9 = MintEvent{
            nft_id : 0x2::object::id<SuiNFT>(&v8),
            minter : 0x2::tx_context::sender(arg4),
            number : v1,
            design : v4,
            rarity : v5,
        };
        0x2::event::emit<MintEvent>(v9);
        0x2::kiosk::place<SuiNFT>(arg1, arg2, v8);
    }

    public fun mint_price(arg0: &Collection) : u64 {
        arg0.mint_price
    }

    public fun mint_with_new_kiosk(arg0: &mut Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint(arg0, v4, &v2, arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun queue_remaining(arg0: &Collection) : u64 {
        0x1::vector::length<u8>(&arg0.design_queue)
    }

    public fun set_active(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun set_name(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun set_walrus_aggregator(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String) {
        arg1.walrus_aggregator = arg2;
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun withdraw_royalties(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<SuiNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<SuiNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3a97dd4f4c43951734a82689d90044d526ca9d5efa1c7e42a0dddf4e187d576c::royalty_rule::withdraw_royalties<SuiNFT>(arg1, arg2, @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5, arg3);
    }

    // decompiled from Move bytecode v7
}

