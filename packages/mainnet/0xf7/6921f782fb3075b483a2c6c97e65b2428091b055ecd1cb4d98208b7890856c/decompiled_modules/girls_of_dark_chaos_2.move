module 0xf76921f782fb3075b483a2c6c97e65b2428091b055ecd1cb4d98208b7890856c::girls_of_dark_chaos_2 {
    struct GIRLS_OF_DARK_CHAOS_2 has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        address_minted: 0x2::table::Table<address, u64>,
        is_minting_paused: bool,
        mint_price: u64,
        is_transfer_paused: bool,
        collection_name: 0x1::string::String,
    }

    struct GirlsOfDarkChaos2NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        token_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        token_id: u64,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTBurned has copy, drop {
        token_id: u64,
    }

    struct MintingPaused has copy, drop {
        dummy_field: bool,
    }

    struct MintingResumed has copy, drop {
        dummy_field: bool,
    }

    struct TransfersPaused has copy, drop {
        dummy_field: bool,
    }

    struct TransfersResumed has copy, drop {
        dummy_field: bool,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct RoyaltiesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct MetadataUpdated has copy, drop {
        token_id: u64,
    }

    struct MintPriceUpdated has copy, drop {
        new_mint_price: u64,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        owner: address,
    }

    public entry fun batch_mint(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: &mut Collection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_minting_paused, 0);
        let v0 = 0x1::vector::length<vector<u8>>(&arg0);
        assert!(0x1::vector::length<vector<u8>>(&arg1) == v0 && 0x1::vector::length<vector<u8>>(&arg2) == v0, 1);
        assert!(arg3.minted_count + v0 <= 10, 1);
        assert!(0x2::kiosk::owner(arg4) == 0x2::tx_context::sender(arg7), 5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = if (0x2::table::contains<address, u64>(&arg3.address_minted, v1)) {
            *0x2::table::borrow<address, u64>(&arg3.address_minted, v1)
        } else {
            0
        };
        assert!(v2 + v0 <= 5, 3);
        if (0x2::table::contains<address, u64>(&arg3.address_minted, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg3.address_minted, v1) = v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg3.address_minted, v1, v0);
        };
        let v3 = 0;
        while (v3 < v0) {
            arg3.minted_count = arg3.minted_count + 1;
            let v4 = arg3.minted_count;
            let v5 = pseudo_random(arg7);
            let v6 = if (v5 % 100 < 10) {
                0x1::string::utf8(b"Legendary")
            } else if (v5 % 100 < 30) {
                0x1::string::utf8(b"Rare")
            } else {
                0x1::string::utf8(b"Common")
            };
            let v7 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Rarity"), v6);
            let v8 = GirlsOfDarkChaos2NFT{
                id          : 0x2::object::new(arg7),
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, v3)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v3)),
                image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg2, v3)),
                token_id    : v4,
                attributes  : v7,
            };
            let v9 = NFTMinted{
                token_id   : v4,
                owner      : v1,
                name       : v8.name,
                image_url  : v8.image_url,
                attributes : v8.attributes,
            };
            0x2::event::emit<NFTMinted>(v9);
            0x2::kiosk::lock<GirlsOfDarkChaos2NFT>(arg4, arg5, arg6, v8);
            v3 = v3 + 1;
        };
    }

    public entry fun burn(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg0), 7);
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg4), 5);
        let GirlsOfDarkChaos2NFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            token_id    : v4,
            attributes  : _,
        } = 0x2::kiosk::take<GirlsOfDarkChaos2NFT>(arg1, arg2, arg0);
        let v6 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<GirlsOfDarkChaos2NFT>(arg3, 0x2::transfer_policy::new_request<GirlsOfDarkChaos2NFT>(0x2::object::uid_to_inner(&v6), 0, 0x2::object::id_from_address(0x2::tx_context::sender(arg4))));
        let v10 = NFTBurned{token_id: v4};
        0x2::event::emit<NFTBurned>(v10);
        0x2::object::delete(v6);
    }

    public entry fun delist_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 5);
        0x2::kiosk::delist<GirlsOfDarkChaos2NFT>(arg0, arg1, arg2);
    }

    public entry fun ensure_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        let v4 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<KioskCreated>(v4);
    }

    public fun get_collection_name(arg0: &Collection) : &0x1::string::String {
        &arg0.collection_name
    }

    public fun get_metadata(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : (&0x1::string::String, &0x1::string::String, &0x2::url::Url, &u64, &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert!(0x2::kiosk::has_item(arg0, arg2), 7);
        let v0 = 0x2::kiosk::borrow<GirlsOfDarkChaos2NFT>(arg0, arg1, arg2);
        (&v0.name, &v0.description, &v0.image_url, &v0.token_id, &v0.attributes)
    }

    public fun get_mint_price(arg0: &Collection) : u64 {
        arg0.mint_price
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted_count
    }

    fun init(arg0: GIRLS_OF_DARK_CHAOS_2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<GIRLS_OF_DARK_CHAOS_2>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<GirlsOfDarkChaos2NFT>(&v1, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<GirlsOfDarkChaos2NFT>(&mut v5, &v4, 2000, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<GirlsOfDarkChaos2NFT>(&mut v5, &v4);
        let v6 = Collection{
            id                 : 0x2::object::new(arg1),
            minted_count       : 0,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            address_minted     : 0x2::table::new<address, u64>(arg1),
            is_minting_paused  : false,
            mint_price         : 0,
            is_transfer_paused : false,
            collection_name    : 0x1::string::utf8(b"Girls of Dark Chaos 2"),
        };
        0x2::transfer::share_object<Collection>(v6);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"token_id"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{token_id}"));
        let v11 = 0x2::display::new_with_fields<GirlsOfDarkChaos2NFT>(&v1, v7, v9, arg1);
        0x2::display::update_version<GirlsOfDarkChaos2NFT>(&mut v11);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GirlsOfDarkChaos2NFT>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GirlsOfDarkChaos2NFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>>(v5);
    }

    public fun is_minting_paused(arg0: &Collection) : bool {
        arg0.is_minting_paused
    }

    public fun is_transfer_paused(arg0: &Collection) : bool {
        arg0.is_transfer_paused
    }

    public entry fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 5);
        0x2::kiosk::list<GirlsOfDarkChaos2NFT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Collection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_minting_paused, 0);
        assert!(arg3.minted_count < 10, 1);
        assert!(0x2::kiosk::owner(arg4) == 0x2::tx_context::sender(arg7), 5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = if (0x2::table::contains<address, u64>(&arg3.address_minted, v0)) {
            *0x2::table::borrow<address, u64>(&arg3.address_minted, v0)
        } else {
            0
        };
        assert!(v1 < 5, 3);
        if (0x2::table::contains<address, u64>(&arg3.address_minted, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg3.address_minted, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg3.address_minted, v0, 1);
        };
        arg3.minted_count = arg3.minted_count + 1;
        let v2 = arg3.minted_count;
        let v3 = pseudo_random(arg7);
        let v4 = if (v3 % 100 < 10) {
            0x1::string::utf8(b"Legendary")
        } else if (v3 % 100 < 30) {
            0x1::string::utf8(b"Rare")
        } else {
            0x1::string::utf8(b"Common")
        };
        let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Rarity"), v4);
        let v6 = GirlsOfDarkChaos2NFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            token_id    : v2,
            attributes  : v5,
        };
        let v7 = NFTMinted{
            token_id   : v2,
            owner      : v0,
            name       : v6.name,
            image_url  : v6.image_url,
            attributes : v6.attributes,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::kiosk::lock<GirlsOfDarkChaos2NFT>(arg4, arg5, arg6, v6);
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_minting_paused = true;
        let v0 = MintingPaused{dummy_field: false};
        0x2::event::emit<MintingPaused>(v0);
    }

    public entry fun pause_transfers(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_transfer_paused = true;
        let v0 = TransfersPaused{dummy_field: false};
        0x2::event::emit<TransfersPaused>(v0);
    }

    fun pseudo_random(arg0: &0x2::tx_context::TxContext) : u64 {
        let v0 = *0x2::tx_context::digest(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            v1 = v1 + (*0x1::vector::borrow<u8>(&v0, v2) as u64);
            v2 = v2 + 1;
        };
        v1
    }

    public entry fun purchase_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * (2000 as u64) / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3 + v0, 8);
        let (v1, v2) = 0x2::kiosk::purchase<GirlsOfDarkChaos2NFT>(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg5));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<GirlsOfDarkChaos2NFT>(&mut v3, arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<GirlsOfDarkChaos2NFT>(arg4, &mut v3, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<GirlsOfDarkChaos2NFT>(arg4, v3);
        0x2::transfer::public_transfer<GirlsOfDarkChaos2NFT>(v1, 0x2::tx_context::sender(arg5));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_minting_paused = false;
        let v0 = MintingResumed{dummy_field: false};
        0x2::event::emit<MintingResumed>(v0);
    }

    public entry fun resume_transfers(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.is_transfer_paused = false;
        let v0 = TransfersResumed{dummy_field: false};
        0x2::event::emit<TransfersResumed>(v0);
    }

    public fun total_supply() : u64 {
        10
    }

    public entry fun update_metadata(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg2, arg1), 7);
        assert!(0x2::kiosk::owner(arg2) == 0x2::tx_context::sender(arg8), 5);
        let v0 = 0x2::kiosk::borrow_mut<GirlsOfDarkChaos2NFT>(arg2, arg3, arg1);
        v0.name = 0x1::string::utf8(arg4);
        v0.description = 0x1::string::utf8(arg5);
        v0.image_url = 0x2::url::new_unsafe_from_bytes(arg6);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(arg7));
        v0.attributes = v1;
        let v2 = MetadataUpdated{token_id: v0.token_id};
        0x2::event::emit<MetadataUpdated>(v2);
    }

    public entry fun update_mint_price(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        arg1.mint_price = arg2;
        let v0 = MintPriceUpdated{new_mint_price: arg2};
        0x2::event::emit<MintPriceUpdated>(v0);
    }

    public entry fun withdraw_royalties(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<GirlsOfDarkChaos2NFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<GirlsOfDarkChaos2NFT>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<GirlsOfDarkChaos2NFT>(arg1, arg2, 0x1::option::none<u64>(), arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = RoyaltiesWithdrawn{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&v0),
            recipient : v1,
        };
        0x2::event::emit<RoyaltiesWithdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v1);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 4);
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

