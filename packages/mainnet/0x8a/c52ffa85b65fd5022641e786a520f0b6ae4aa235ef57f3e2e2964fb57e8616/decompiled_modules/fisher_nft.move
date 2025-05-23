module 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_nft {
    struct FISHER_NFT has drop {
        dummy_field: bool,
    }

    struct FisherNFT has key {
        id: 0x2::object::UID,
        nft_type: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        original_owner: address,
    }

    struct FisherNFTCollection has key {
        id: 0x2::object::UID,
        common_price: u64,
        rare_price: u64,
        epic_price: u64,
        common_supply: u64,
        rare_supply: u64,
        epic_supply: u64,
        common_minted: u64,
        rare_minted: u64,
        epic_minted: u64,
        fisher_payment: bool,
        owner: address,
    }

    struct NFTPurchasedEvent has copy, drop {
        buyer: address,
        nft_type: u8,
        nft_id: 0x2::object::ID,
    }

    public entry fun buy_nft(arg0: &mut FisherNFTCollection, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 2);
        assert!(arg0.fisher_payment == false, 4);
        let v1 = if (arg1 == 1) {
            arg0.common_price
        } else if (arg1 == 2) {
            assert!(arg0.rare_minted < arg0.rare_supply, 0);
            arg0.rare_price
        } else {
            assert!(arg0.epic_minted < arg0.epic_supply, 0);
            arg0.epic_price
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= v1, 1);
        if (arg1 == 1) {
            arg0.common_minted = arg0.common_minted + 1;
        } else if (arg1 == 2) {
            arg0.rare_minted = arg0.rare_minted + 1;
        } else {
            arg0.epic_minted = arg0.epic_minted + 1;
        };
        let v3 = 0x2::tx_context::sender(arg3);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2 - v1, arg3), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fee_receiver());
        let (v4, v5, v6) = get_nft_details(arg1);
        let v7 = FisherNFT{
            id             : 0x2::object::new(arg3),
            nft_type       : arg1,
            name           : v4,
            description    : v5,
            image_url      : v6,
            original_owner : v3,
        };
        let v8 = NFTPurchasedEvent{
            buyer    : v3,
            nft_type : arg1,
            nft_id   : 0x2::object::id<FisherNFT>(&v7),
        };
        0x2::event::emit<NFTPurchasedEvent>(v8);
        0x2::transfer::transfer<FisherNFT>(v7, v3);
    }

    public entry fun buy_nft_with_fisher(arg0: &mut FisherNFTCollection, arg1: u8, arg2: 0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fisher_payment == true, 4);
        let v0 = if (arg1 == 1) {
            arg0.common_price
        } else if (arg1 == 2) {
            assert!(arg0.rare_minted < arg0.rare_supply, 0);
            arg0.rare_price
        } else {
            assert!(arg0.epic_minted < arg0.epic_supply, 0);
            arg0.epic_price
        };
        assert!(0x2::coin::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&arg2) >= v0, 1);
        if (arg1 == 1) {
            arg0.common_minted = arg0.common_minted + 1;
        } else if (arg1 == 2) {
            arg0.rare_minted = arg0.rare_minted + 1;
        } else {
            arg0.epic_minted = arg0.epic_minted + 1;
        };
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>>(arg2, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fee_receiver());
        let (v2, v3, v4) = get_nft_details(arg1);
        let v5 = FisherNFT{
            id             : 0x2::object::new(arg3),
            nft_type       : arg1,
            name           : v2,
            description    : v3,
            image_url      : v4,
            original_owner : v1,
        };
        let v6 = NFTPurchasedEvent{
            buyer    : v1,
            nft_type : arg1,
            nft_id   : 0x2::object::id<FisherNFT>(&v5),
        };
        0x2::event::emit<NFTPurchasedEvent>(v6);
        0x2::transfer::transfer<FisherNFT>(v5, v1);
    }

    public entry fun change_price(arg0: &mut FisherNFTCollection, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        if (arg1 == 1) {
            arg0.common_price = arg2;
        } else if (arg1 == 2) {
            arg0.rare_price = arg2;
        } else {
            arg0.epic_price = arg2;
        };
    }

    fun get_nft_details(arg0: u8) : (0x1::string::String, 0x1::string::String, 0x2::url::Url) {
        if (arg0 == 1) {
            (0x1::string::utf8(b"Common Fisher NFT"), 0x1::string::utf8(b"A common fishing NFT with standard capabilities"), 0x2::url::new_unsafe_from_bytes(b"https://suifisher.games/nft/common.png"))
        } else if (arg0 == 2) {
            (0x1::string::utf8(b"Rare Fisher NFT"), 0x1::string::utf8(b"A rare fishing NFT with enhanced capabilities"), 0x2::url::new_unsafe_from_bytes(b"https://suifisher.games/nft/rare.png"))
        } else {
            (0x1::string::utf8(b"Epic Fisher NFT"), 0x1::string::utf8(b"An epic fishing NFT with premium capabilities"), 0x2::url::new_unsafe_from_bytes(b"https://suifisher.games/nft/epic.png"))
        }
    }

    public entry fun increase_supply(arg0: &mut FisherNFTCollection, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        if (arg1 == 1) {
            arg0.common_supply = arg0.common_supply + arg2;
        } else if (arg1 == 2) {
            arg0.rare_supply = arg0.rare_supply + arg2;
        } else {
            arg0.epic_supply = arg0.epic_supply + arg2;
        };
    }

    fun init(arg0: FISHER_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FisherNFTCollection{
            id             : 0x2::object::new(arg1),
            common_price   : 15000000000,
            rare_price     : 35000000000,
            epic_price     : 70000000000,
            common_supply  : 750,
            rare_supply    : 200,
            epic_supply    : 50,
            common_minted  : 0,
            rare_minted    : 0,
            epic_minted    : 0,
            fisher_payment : false,
            owner          : 0x2::tx_context::sender(arg1),
        };
        let v1 = 0x2::package::claim<FISHER_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"type"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{nft_type}"));
        let v6 = 0x2::display::new_with_fields<FisherNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<FisherNFT>(&mut v6);
        0x2::transfer::public_freeze_object<0x2::package::Publisher>(v1);
        0x2::transfer::public_freeze_object<0x2::display::Display<FisherNFT>>(v6);
        0x2::transfer::share_object<FisherNFTCollection>(v0);
    }

    public entry fun mint_by_admin(arg0: &mut FisherNFTCollection, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        if (arg1 == 1) {
            arg0.common_minted = arg0.common_minted + 1;
        } else if (arg1 == 2) {
            arg0.rare_minted = arg0.rare_minted + 1;
        } else {
            arg0.epic_minted = arg0.epic_minted + 1;
        };
        let (v0, v1, v2) = get_nft_details(arg1);
        let v3 = FisherNFT{
            id             : 0x2::object::new(arg3),
            nft_type       : arg1,
            name           : v0,
            description    : v1,
            image_url      : v2,
            original_owner : arg2,
        };
        let v4 = NFTPurchasedEvent{
            buyer    : arg2,
            nft_type : arg1,
            nft_id   : 0x2::object::id<FisherNFT>(&v3),
        };
        0x2::event::emit<NFTPurchasedEvent>(v4);
        0x2::transfer::transfer<FisherNFT>(v3, arg2);
    }

    public entry fun set_fisher_payment(arg0: &mut FisherNFTCollection, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        arg0.fisher_payment = arg1;
    }

    // decompiled from Move bytecode v6
}

