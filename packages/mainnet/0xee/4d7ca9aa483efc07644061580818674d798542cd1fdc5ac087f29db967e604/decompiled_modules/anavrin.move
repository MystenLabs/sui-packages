module 0xee4d7ca9aa483efc07644061580818674d798542cd1fdc5ac087f29db967e604::anavrin {
    struct ANAVRIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        enabled: bool,
        treasury: address,
        total_minted: u64,
        royalty_bps: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        base_age_seconds: u64,
        base_mood: u8,
        base_form: u8,
        mutation_seed: u64,
        last_sync_ms: u64,
        evolution_stage: u8,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        price_paid: u64,
        total_minted: u64,
    }

    struct ListEvent has copy, drop {
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct BuyEvent has copy, drop {
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
    }

    struct DelistEvent has copy, drop {
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun buy(arg0: &mut Marketplace, arg1: &MintConfig, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0.price, 5);
        let v1 = v0.seller;
        let v2 = v0.price;
        let v3 = v0.nft_id;
        let v4 = v2 * arg0.fee_bps / 10000;
        let v5 = v2 * arg1.royalty_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4, arg4), arg0.treasury);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4), arg1.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v4 - v5, arg4), v1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v6 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg2);
        let Listing {
            id     : v7,
            nft_id : _,
            seller : _,
            price  : _,
        } = v6;
        0x2::object::delete(v7);
        let v11 = BuyEvent{
            nft_id     : v3,
            listing_id : arg2,
            buyer      : 0x2::tx_context::sender(arg4),
            seller     : v1,
            price      : v2,
        };
        0x2::event::emit<BuyEvent>(v11);
        0x2::transfer::public_transfer<NFT>(0x2::dynamic_object_field::remove<bool, NFT>(&mut v6.id, true), 0x2::tx_context::sender(arg4));
    }

    public fun current_age_seconds(arg0: &NFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.last_sync_ms == 0 || v0 <= arg0.last_sync_ms) {
            arg0.base_age_seconds
        } else {
            arg0.base_age_seconds + (v0 - arg0.last_sync_ms) / 1000
        }
    }

    public fun current_form(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1) / 7;
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        *0x1::vector::borrow<u8>(&v2, 1) % 16
    }

    public fun current_mood(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1);
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        *0x1::vector::borrow<u8>(&v2, 0) % 100
    }

    public fun current_traits(arg0: &NFT, arg1: &0x2::clock::Clock) : (u64, u8, u8, u8, u8, u64) {
        (current_age_seconds(arg0, arg1), current_mood(arg0, arg1), current_form(arg0, arg1), evolution_level(arg0, arg1), species(arg0), mutation_flags(arg0, arg1))
    }

    public entry fun delist(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg2), 3);
        let v1 = v0.nft_id;
        let v2 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let Listing {
            id     : v3,
            nft_id : _,
            seller : v5,
            price  : _,
        } = v2;
        0x2::object::delete(v3);
        let v7 = DelistEvent{
            nft_id     : v1,
            listing_id : arg1,
            seller     : v5,
        };
        0x2::event::emit<DelistEvent>(v7);
        0x2::transfer::public_transfer<NFT>(0x2::dynamic_object_field::remove<bool, NFT>(&mut v2.id, true), 0x2::tx_context::sender(arg2));
    }

    public fun evolution_level(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = current_age_seconds(arg0, arg1);
        if (v0 < 60) {
            0
        } else if (v0 < 600) {
            1
        } else if (v0 < 3600) {
            2
        } else if (v0 < 43200) {
            3
        } else if (v0 < 86400) {
            4
        } else {
            5
        }
    }

    fun init(arg0: ANAVRIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ANAVRIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MintConfig{
            id           : 0x2::object::new(arg1),
            price        : 1000000000,
            enabled      : false,
            treasury     : 0x2::tx_context::sender(arg1),
            total_minted : 0,
            royalty_bps  : 500,
        };
        0x2::transfer::share_object<MintConfig>(v1);
        let v2 = Marketplace{
            id       : 0x2::object::new(arg1),
            fee_bps  : 250,
            treasury : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Marketplace>(v2);
    }

    public entry fun list(arg0: &mut Marketplace, arg1: NFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NFT>(&arg1);
        let v1 = Listing{
            id     : 0x2::object::new(arg3),
            nft_id : v0,
            seller : 0x2::tx_context::sender(arg3),
            price  : arg2,
        };
        let v2 = 0x2::object::id<Listing>(&v1);
        let v3 = ListEvent{
            nft_id     : v0,
            listing_id : v2,
            seller     : 0x2::tx_context::sender(arg3),
            price      : arg2,
        };
        0x2::event::emit<ListEvent>(v3);
        0x2::dynamic_object_field::add<bool, NFT>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v2, v1);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = NFT{
            id               : 0x2::object::new(arg4),
            base_age_seconds : 0,
            base_mood        : 0x2::random::generate_u8_in_range(&mut v0, 0, 99),
            base_form        : 0x2::random::generate_u8_in_range(&mut v0, 0, 15),
            mutation_seed    : 0x2::random::generate_u64(&mut v0),
            last_sync_ms     : 0x2::clock::timestamp_ms(arg2),
            evolution_stage  : 0,
        };
        let v2 = MintEvent{
            nft_id       : 0x2::object::id<NFT>(&v1),
            minter       : 0x2::tx_context::sender(arg4),
            price_paid   : arg0.price,
            total_minted : arg0.total_minted,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun mutation_flags(arg0: &NFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1) / 30;
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        (*0x1::vector::borrow<u8>(&v2, 2) as u64) << 8 | (*0x1::vector::borrow<u8>(&v2, 3) as u64)
    }

    public entry fun set_enabled(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun set_platform_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64) {
        arg1.fee_bps = arg2;
    }

    public entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_royalty_bps(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.royalty_bps = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public entry fun setup_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::string::append(&mut arg1, 0x1::string::utf8(b"{id}.svg"));
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Anavrin"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"48656172746265617420e28692204261627920e2869220437265617475726520e28692204865726f20e28692204d797468696320e2869220436f736d69632e2041206c6976696e67204e4654206f6e205375692e"));
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://anavrin.xyz"));
        let v4 = 0x2::display::new_with_fields<NFT>(arg0, v0, v2, arg2);
        0x2::display::update_version<NFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun species(arg0: &NFT) : u8 {
        ((arg0.mutation_seed % 4) as u8)
    }

    public entry fun sync(arg0: &mut NFT, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.base_age_seconds = current_age_seconds(arg0, arg1);
        arg0.base_mood = current_mood(arg0, arg1);
        arg0.base_form = current_form(arg0, arg1);
        arg0.evolution_stage = evolution_level(arg0, arg1);
        arg0.last_sync_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 99) == 0) {
            arg0.mutation_seed = 0x2::random::generate_u64(&mut v0);
        };
    }

    // decompiled from Move bytecode v6
}

