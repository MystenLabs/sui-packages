module 0x1a250c90033b19a27a60c04193e4b04a88d3141166e0f8dc286e7b79a40b72ed::nordicLegends {
    struct MintConfig has key {
        id: 0x2::object::UID,
        owner: address,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<NordicLegends>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelist: 0x2::table::Table<address, u64>,
        public_list: 0x2::table::Table<address, u64>,
        whitelist_price: u64,
        public_price: u64,
        max_mint_public: u64,
        minted: u64,
        supply: u64,
        nordic_legends_wl_nft_type: 0x1::string::String,
        rarities: vector<0x1::string::String>,
        tokens_names: vector<0x1::string::String>,
        images_urls: vector<0x1::string::String>,
    }

    struct NordicLegends has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NORDICLEGENDS has drop {
        dummy_field: bool,
    }

    public entry fun withdraw(arg0: &mut MintConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let v0 = 1700000000000;
        let v1 = 1700000000000;
        let v2 = 571000000000;
        let v3 = 285000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v0, arg1), @0x5c82a1d47bf86befc93b57a760994fe8bf82129b669e4f14f0ac5e6fd5c4ecda);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v1, arg1), @0x8206bfcaeabf3e87138d4548a2cf1dab89874f214274211abbb649ad6aa56d5e);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v2, arg1), @0x8532a0efda8f92811c1cc31044dbd9b25e85283ab56ba23a7d622141bdc1d2f);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v3, arg1), @0x7551731e56f8e75f41c08da7431109e126e3ad3844f1113594b78d2f59e5fdc5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds) - v0 + v1 + v2 + v3, arg1), @0xf22213077a4e8e2894e349c5a68aa88dcc39e18d5aeb53b32f9d096d916a0b8d);
    }

    public entry fun deploy_image_url(arg0: &mut MintConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.images_urls, 0x1::string::utf8(arg1));
    }

    public entry fun deploy_rarity(arg0: &mut MintConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.rarities, 0x1::string::utf8(arg1));
    }

    public entry fun deploy_token_name(arg0: &mut MintConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tokens_names, 0x1::string::utf8(arg1));
    }

    fun init(arg0: NORDICLEGENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NORDICLEGENDS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Nordic Legends is a Viking-themed, community-driven ecosystem anchored by The Nordic Legends Genesis Collection, a limited set of 300 hand-crafted NFTs on the Sui network. These NFTs featuring Warriors and Shieldmaidens offer rarity-based rewards, staking opportunities, and future ecosystem perks."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.nordiclegends.xyz/nft/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://jade-peaceful-firefly-694.mypinata.cloud/ipfs/QmaMFJKSDvSrozmgejpGfCwfLh8M5CsKCx8SzcUvSsLX5J/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://jade-peaceful-firefly-694.mypinata.cloud/ipfs/QmaMFJKSDvSrozmgejpGfCwfLh8M5CsKCx8SzcUvSsLX5J/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.nordiclegends.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Nordic Legends"));
        let v5 = 0x2::display::new_with_fields<NordicLegends>(&v0, v1, v3, arg1);
        0x2::display::update_version<NordicLegends>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<NordicLegends>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<NordicLegends>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<NordicLegends>(&mut v9, &v8, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NordicLegends>>(v9);
        0x2::transfer::public_transfer<0x2::display::Display<NordicLegends>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v10 = MintConfig{
            id                         : 0x2::object::new(arg1),
            owner                      : 0x2::tx_context::sender(arg1),
            transfer_policy_cap        : v8,
            funds                      : 0x2::balance::zero<0x2::sui::SUI>(),
            whitelist                  : 0x2::table::new<address, u64>(arg1),
            public_list                : 0x2::table::new<address, u64>(arg1),
            whitelist_price            : 15000000000,
            public_price               : 25000000000,
            max_mint_public            : 0,
            minted                     : 0,
            supply                     : 300,
            nordic_legends_wl_nft_type : 0x1::string::utf8(b"cdbec1c422f0a56afc0515e4458f6e994d2fa9a660513e03014e90eb7af2165a::nordic_legends::Nft"),
            rarities                   : 0x1::vector::empty<0x1::string::String>(),
            tokens_names               : 0x1::vector::empty<0x1::string::String>(),
            images_urls                : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<MintConfig>(v10);
    }

    fun internal_mint(arg0: &mut MintConfig, arg1: address, arg2: &0x2::transfer_policy::TransferPolicy<NordicLegends>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minted;
        let v1 = *0x1::vector::borrow<0x1::string::String>(&arg0.tokens_names, v0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.rarities, v0);
        let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"rarity"), v2);
        let v4 = NordicLegends{
            id         : 0x2::object::new(arg3),
            name       : v1,
            image_url  : *0x1::vector::borrow<0x1::string::String>(&arg0.images_urls, v0),
            rarity     : v2,
            attributes : v3,
        };
        let (v5, v6) = 0x2::kiosk::new(arg3);
        let v7 = v6;
        let v8 = v5;
        let v9 = NFTMinted{
            object_id : 0x2::object::id<NordicLegends>(&v4),
            creator   : arg1,
            name      : v1,
        };
        0x2::event::emit<NFTMinted>(v9);
        0x2::kiosk::lock<NordicLegends>(&mut v8, &v7, arg2, v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
        arg0.minted = arg0.minted + 1;
    }

    public entry fun mutate_owner(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    public entry fun public_mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<NordicLegends>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + 1 <= arg0.supply, 7);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.public_list, v0)) {
            assert!(*0x2::table::borrow<address, u64>(&arg0.public_list, v0) + 1 <= arg0.max_mint_public, 6);
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_list, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.public_list, v0, 1);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.public_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.funds, arg1);
        internal_mint(arg0, v0, arg2, arg3);
    }

    public entry fun update_image_url(arg0: &mut MintConfig, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.images_urls, arg1) = 0x1::string::utf8(arg2);
    }

    public entry fun update_nordic_legends_wl_nft(arg0: &mut MintConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.nordic_legends_wl_nft_type = 0x1::string::utf8(arg1);
    }

    public entry fun update_public_max(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.max_mint_public = arg1;
    }

    public entry fun update_public_price(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.public_price = arg1;
    }

    public entry fun update_rarity(arg0: &mut MintConfig, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.rarities, arg1) = 0x1::string::utf8(arg2);
    }

    public entry fun update_token_name(arg0: &mut MintConfig, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.tokens_names, arg1) = 0x1::string::utf8(arg2);
    }

    public entry fun update_whitelist_price(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.whitelist_price = arg1;
    }

    public entry fun whitelist_mint<T0: store + key>(arg0: &mut MintConfig, arg1: &T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<NordicLegends>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + 1 <= arg0.supply, 7);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::string::to_ascii(arg0.nordic_legends_wl_nft_type), 2);
        0x2::table::add<address, u64>(&mut arg0.whitelist, 0x2::object::id_address<T0>(arg1), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.whitelist_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.funds, arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        internal_mint(arg0, v0, arg3, arg4);
    }

    public entry fun withdraw_royalties(arg0: &mut MintConfig, arg1: &mut 0x2::transfer_policy::TransferPolicy<NordicLegends>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<NordicLegends>(arg1, &arg0.transfer_policy_cap, 0x1::option::none<u64>(), arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

