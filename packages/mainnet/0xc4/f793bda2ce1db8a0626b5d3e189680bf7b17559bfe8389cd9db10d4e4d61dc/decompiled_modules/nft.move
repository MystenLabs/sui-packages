module 0xc4f793bda2ce1db8a0626b5d3e189680bf7b17559bfe8389cd9db10d4e4d61dc::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct KillaClubNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CollectionData has key {
        id: 0x2::object::UID,
        minted_tokens: vector<u64>,
        remaining_prizes: vector<u64>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        available_tokens: vector<u64>,
        image_base_uri: 0x1::string::String,
        metadata_base_uri: 0x1::string::String,
        total_minted: u64,
        whitelist: 0x2::table::Table<address, bool>,
        vip: 0x2::table::Table<address, bool>,
    }

    struct AddressMintedPool has copy, drop, store {
        pool_whitelist: u64,
        pool_public: u64,
        pool_vip: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        token_id: u64,
        owner: address,
        prize_amount: u64,
    }

    struct PrizeWithdrawn has copy, drop {
        token_id: u64,
        owner: address,
        amount: u64,
    }

    public entry fun add_prize_pool(arg0: &AdminCap, arg1: &mut CollectionData, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(v0) >= arg3, 1);
        arg1.remaining_prizes = 0x1::vector::empty<u64>();
        let v1 = arg3 / 10;
        let v2 = arg3 / 20;
        let v3 = arg3 / 40;
        let v4 = 0;
        while (v4 < 3) {
            0x1::vector::push_back<u64>(&mut arg1.remaining_prizes, v1);
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 6) {
            0x1::vector::push_back<u64>(&mut arg1.remaining_prizes, v2);
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 12) {
            0x1::vector::push_back<u64>(&mut arg1.remaining_prizes, v3);
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 24) {
            0x1::vector::push_back<u64>(&mut arg1.remaining_prizes, (arg3 - v1 * 3 - v2 * 6 - v3 * 12) / 24);
            v4 = v4 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::balance::split<0x2::sui::SUI>(v0, arg3));
    }

    public entry fun add_to_vip(arg0: &mut CollectionData, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::add<address, bool>(&mut arg0.vip, 0x1::vector::pop_back<address>(&mut arg1), true);
        };
    }

    public entry fun add_to_whitelist(arg0: &mut CollectionData, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, 0x1::vector::pop_back<address>(&mut arg1), true);
        };
    }

    fun create_nft(arg0: u64, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &CollectionData, arg3: &mut 0x2::tx_context::TxContext) : KillaClubNFT {
        let v0 = 0x1::string::utf8(b"Killa Club NFT #");
        0x1::string::append(&mut v0, int_to_string(arg0));
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, arg2.image_base_uri);
        0x1::string::append(&mut v1, int_to_string(arg0));
        0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, arg2.metadata_base_uri);
        0x1::string::append(&mut v2, int_to_string(arg0));
        0x1::string::append(&mut v2, 0x1::string::utf8(b".json"));
        KillaClubNFT{
            id           : 0x2::object::new(arg3),
            token_id     : arg0,
            name         : v0,
            description  : 0x1::string::utf8(b"A unique Killa Club NFT with potential prize rewards"),
            image_url    : v1,
            metadata_uri : v2,
            sui_balance  : arg1,
        }
    }

    fun generate_random_seed(arg0: &0x2::clock::Clock, arg1: u64, arg2: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        let v2 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v2));
        let v3 = 0x2::hash::keccak256(&v0);
        *0x1::vector::borrow<u8>(&v3, 0)
    }

    public fun get_remaining_prizes(arg0: &CollectionData) : u64 {
        0x1::vector::length<u64>(&arg0.remaining_prizes)
    }

    public fun get_token_balance(arg0: &KillaClubNFT) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_total_minted(arg0: &CollectionData) : u64 {
        arg0.total_minted
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 1;
        while (v2 <= 2222) {
            0x1::vector::push_back<u64>(&mut v1, v2);
            v2 = v2 + 1;
        };
        let v3 = CollectionData{
            id                : 0x2::object::new(arg1),
            minted_tokens     : 0x1::vector::empty<u64>(),
            remaining_prizes  : 0x1::vector::empty<u64>(),
            prize_pool        : 0x2::balance::zero<0x2::sui::SUI>(),
            available_tokens  : v1,
            image_base_uri    : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmVWn4MPEgh1tbR76XN6riqtKmdBfkcYbZTb7LHCvaAugB/"),
            metadata_base_uri : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmSmRKDsodqgUEEZf9sDGWTi1CPTCe56GmUfjAHRGTXAh4/"),
            total_minted      : 0,
            whitelist         : 0x2::table::new<address, bool>(arg1),
            vip               : 0x2::table::new<address, bool>(arg1),
        };
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"collection_name"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Killa Club NFT #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"A unique Killa Club NFT with potential prize rewards"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmVWn4MPEgh1tbR76XN6riqtKmdBfkcYbZTb7LHCvaAugB/{token_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmSmRKDsodqgUEEZf9sDGWTi1CPTCe56GmUfjAHRGTXAh4/{token_id}.json"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://killaclub.com"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Killa Club"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Killa Club NFT Collection"));
        let v9 = 0x2::display::new_with_fields<KillaClubNFT>(&v4, v5, v7, arg1);
        0x2::display::add<KillaClubNFT>(&mut v9, 0x1::string::utf8(b"category"), 0x1::string::utf8(b"NFT"));
        0x2::display::update_version<KillaClubNFT>(&mut v9);
        let (v10, v11) = 0x2::transfer_policy::new<KillaClubNFT>(&v4, arg1);
        0x2::transfer::share_object<CollectionData>(v3);
        0x2::transfer::public_transfer<0x2::display::Display<KillaClubNFT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<KillaClubNFT>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<KillaClubNFT>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let (v12, v13) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v12);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v13, 0x2::tx_context::sender(arg1));
    }

    fun int_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun is_token_available(arg0: &CollectionData, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.minted_tokens, &arg1)
    }

    public entry fun mint_multiple(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CollectionData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 10, 7);
        assert!(arg1.total_minted + arg2 <= 2222, 6);
        assert!(0x1::vector::length<u64>(&arg1.available_tokens) >= arg2, 8);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg4))) {
            let v0 = &mut 0x2::dynamic_field::borrow_mut<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4)).pool_public;
            assert!(*v0 + arg2 <= 10, 7);
            *v0 = *v0 + arg2;
        } else {
            let v1 = AddressMintedPool{
                pool_whitelist : 0,
                pool_public    : arg2,
                pool_vip       : 0,
            };
            0x2::dynamic_field::add<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4), v1);
        };
        let v2 = 18000000000 * arg2;
        let v3 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(v3) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v3, v2), arg4), @0x5a576f1898c543c12b5c92b9f2d7b5aaf6e8b1c24aa1374406fb92b31dbef307);
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = 0x1::vector::swap_remove<u64>(&mut arg1.available_tokens, (generate_random_seed(arg3, v4, arg4) as u64) % 0x1::vector::length<u64>(&arg1.available_tokens));
            let v6 = if (!0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                let v7 = generate_random_seed(arg3, v5 + v4, arg4);
                if (v7 % 2 == 0 && !0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                    let v8 = 0x1::vector::swap_remove<u64>(&mut arg1.remaining_prizes, (v7 as u64) % 0x1::vector::length<u64>(&arg1.remaining_prizes));
                    assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= v8, 5);
                    0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v8)
                } else {
                    0x2::balance::zero<0x2::sui::SUI>()
                }
            } else {
                0x2::balance::zero<0x2::sui::SUI>()
            };
            let v9 = v6;
            let v10 = create_nft(v5, v9, arg1, arg4);
            0x1::vector::push_back<u64>(&mut arg1.minted_tokens, v5);
            arg1.total_minted = arg1.total_minted + 1;
            let v11 = NFTMinted{
                token_id     : v5,
                owner        : 0x2::tx_context::sender(arg4),
                prize_amount : 0x2::balance::value<0x2::sui::SUI>(&v9),
            };
            0x2::event::emit<NFTMinted>(v11);
            0x2::transfer::transfer<KillaClubNFT>(v10, 0x2::tx_context::sender(arg4));
            v4 = v4 + 1;
        };
    }

    public entry fun mint_multiple_private(arg0: &AdminCap, arg1: &mut CollectionData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x1::vector::swap_remove<u64>(&mut arg1.available_tokens, (generate_random_seed(arg3, v0, arg4) as u64) % 0x1::vector::length<u64>(&arg1.available_tokens));
            let v2 = if (!0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                let v3 = generate_random_seed(arg3, v1 + v0, arg4);
                if (v3 % 2 == 0 && !0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                    let v4 = 0x1::vector::swap_remove<u64>(&mut arg1.remaining_prizes, (v3 as u64) % 0x1::vector::length<u64>(&arg1.remaining_prizes));
                    assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= v4, 5);
                    0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v4)
                } else {
                    0x2::balance::zero<0x2::sui::SUI>()
                }
            } else {
                0x2::balance::zero<0x2::sui::SUI>()
            };
            let v5 = v2;
            0x1::vector::push_back<u64>(&mut arg1.minted_tokens, v1);
            arg1.total_minted = arg1.total_minted + 1;
            let v6 = NFTMinted{
                token_id     : v1,
                owner        : @0x45e9c49a3011a40fc20e413d5fe11339420e7ca9e6da426371d579caf5aaa022,
                prize_amount : 0x2::balance::value<0x2::sui::SUI>(&v5),
            };
            0x2::event::emit<NFTMinted>(v6);
            0x2::transfer::transfer<KillaClubNFT>(create_nft(v1, v5, arg1, arg4), @0x45e9c49a3011a40fc20e413d5fe11339420e7ca9e6da426371d579caf5aaa022);
            v0 = v0 + 1;
        };
    }

    public entry fun mint_multiple_vip(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CollectionData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 10, 7);
        assert!(arg1.total_minted + arg2 <= 2222, 6);
        assert!(0x1::vector::length<u64>(&arg1.available_tokens) >= arg2, 8);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg4))) {
            let v0 = &mut 0x2::dynamic_field::borrow_mut<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4)).pool_vip;
            assert!(*v0 + arg2 <= 2, 7);
            *v0 = *v0 + arg2;
        } else {
            let v1 = AddressMintedPool{
                pool_whitelist : 0,
                pool_public    : 0,
                pool_vip       : arg2,
            };
            0x2::dynamic_field::add<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4), v1);
        };
        let v2 = 11000000000 * arg2;
        let v3 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(v3) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v3, v2), arg4), @0x5a576f1898c543c12b5c92b9f2d7b5aaf6e8b1c24aa1374406fb92b31dbef307);
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = 0x1::vector::swap_remove<u64>(&mut arg1.available_tokens, (generate_random_seed(arg3, v4, arg4) as u64) % 0x1::vector::length<u64>(&arg1.available_tokens));
            let v6 = if (!0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                let v7 = generate_random_seed(arg3, v5 + v4, arg4);
                if (v7 % 2 == 0 && !0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                    let v8 = 0x1::vector::swap_remove<u64>(&mut arg1.remaining_prizes, (v7 as u64) % 0x1::vector::length<u64>(&arg1.remaining_prizes));
                    assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= v8, 5);
                    0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v8)
                } else {
                    0x2::balance::zero<0x2::sui::SUI>()
                }
            } else {
                0x2::balance::zero<0x2::sui::SUI>()
            };
            let v9 = v6;
            let v10 = create_nft(v5, v9, arg1, arg4);
            0x1::vector::push_back<u64>(&mut arg1.minted_tokens, v5);
            arg1.total_minted = arg1.total_minted + 1;
            let v11 = NFTMinted{
                token_id     : v5,
                owner        : 0x2::tx_context::sender(arg4),
                prize_amount : 0x2::balance::value<0x2::sui::SUI>(&v9),
            };
            0x2::event::emit<NFTMinted>(v11);
            0x2::transfer::transfer<KillaClubNFT>(v10, 0x2::tx_context::sender(arg4));
            v4 = v4 + 1;
        };
    }

    public entry fun mint_multiple_whitelist(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CollectionData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 10, 7);
        assert!(arg1.total_minted + arg2 <= 2222, 6);
        assert!(0x1::vector::length<u64>(&arg1.available_tokens) >= arg2, 8);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg4))) {
            let v0 = &mut 0x2::dynamic_field::borrow_mut<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4)).pool_whitelist;
            assert!(*v0 + arg2 <= 4, 7);
            *v0 = *v0 + arg2;
        } else {
            let v1 = AddressMintedPool{
                pool_whitelist : arg2,
                pool_public    : 0,
                pool_vip       : 0,
            };
            0x2::dynamic_field::add<address, AddressMintedPool>(&mut arg1.id, 0x2::tx_context::sender(arg4), v1);
        };
        let v2 = 14000000000 * arg2;
        let v3 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(v3) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v3, v2), arg4), @0x5a576f1898c543c12b5c92b9f2d7b5aaf6e8b1c24aa1374406fb92b31dbef307);
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = 0x1::vector::swap_remove<u64>(&mut arg1.available_tokens, (generate_random_seed(arg3, v4, arg4) as u64) % 0x1::vector::length<u64>(&arg1.available_tokens));
            let v6 = if (!0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                let v7 = generate_random_seed(arg3, v5 + v4, arg4);
                if (v7 % 2 == 0 && !0x1::vector::is_empty<u64>(&arg1.remaining_prizes)) {
                    let v8 = 0x1::vector::swap_remove<u64>(&mut arg1.remaining_prizes, (v7 as u64) % 0x1::vector::length<u64>(&arg1.remaining_prizes));
                    assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= v8, 5);
                    0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v8)
                } else {
                    0x2::balance::zero<0x2::sui::SUI>()
                }
            } else {
                0x2::balance::zero<0x2::sui::SUI>()
            };
            let v9 = v6;
            let v10 = create_nft(v5, v9, arg1, arg4);
            0x1::vector::push_back<u64>(&mut arg1.minted_tokens, v5);
            arg1.total_minted = arg1.total_minted + 1;
            let v11 = NFTMinted{
                token_id     : v5,
                owner        : 0x2::tx_context::sender(arg4),
                prize_amount : 0x2::balance::value<0x2::sui::SUI>(&v9),
            };
            0x2::event::emit<NFTMinted>(v11);
            0x2::transfer::transfer<KillaClubNFT>(v10, 0x2::tx_context::sender(arg4));
            v4 = v4 + 1;
        };
    }

    public entry fun place_in_kiosk(arg0: KillaClubNFT, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::place<KillaClubNFT>(arg1, arg2, arg0);
    }

    public entry fun update_uris(arg0: &AdminCap, arg1: &mut CollectionData, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg1.image_base_uri = arg2;
        arg1.metadata_base_uri = arg3;
    }

    public entry fun withdraw_sui(arg0: &mut KillaClubNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::tx_context::sender(arg2) == v0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 5);
        let v1 = PrizeWithdrawn{
            token_id : arg0.token_id,
            owner    : v0,
            amount   : arg1,
        };
        0x2::event::emit<PrizeWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

