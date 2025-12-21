module 0xbc0c3c2d5df99933570781c2e84f0ef1c91e3d14d054e65b7bb386ff5d21951::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Bookie has store, key {
        id: 0x2::object::UID,
        number: u64,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct BookieRegistry has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        minted: u64,
        collection_size: u64,
        can_mint: bool,
        require_signature: bool,
        max_nfts_per_address: u64,
        addresses_minted: 0x2::table::Table<address, u64>,
        mint_price: u64,
        usdc_mint_price: u64,
        treasury: address,
        signer_public_key: vector<u8>,
        random_pool: vector<u64>,
        random_min: u64,
        random_max: u64,
    }

    struct BookieAttributes has key {
        id: 0x2::object::UID,
        nft_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        nft_urls: 0x2::table::Table<u64, 0x2::url::Url>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TradeDisabledRule has drop {
        dummy_field: bool,
    }

    public fun balance(arg0: &BookieRegistry) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.balance
    }

    public fun url(arg0: &Bookie) : &0x2::url::Url {
        &arg0.url
    }

    fun add_addresses_minted(arg0: &mut BookieRegistry, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.addresses_minted, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.addresses_minted, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.addresses_minted, arg1, arg2);
        };
    }

    public entry fun add_attributes(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.nft_attributes, arg2), 9223374278828359691);
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.nft_attributes, arg2, 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4));
    }

    public entry fun add_to_random_pool(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        while (arg2 <= arg3) {
            0x1::vector::push_back<u64>(&mut arg1.random_pool, arg2);
            arg2 = arg2 + 1;
        };
    }

    public entry fun add_url(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, 0x2::url::Url>(&arg1.nft_urls, arg2), 9223374416267313163);
        0x2::table::add<u64, 0x2::url::Url>(&mut arg1.nft_urls, arg2, 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg3)));
    }

    public fun addresses_minted(arg0: &BookieRegistry) : &0x2::table::Table<address, u64> {
        &arg0.addresses_minted
    }

    fun admin_mint(arg0: &mut BookieRegistry, arg1: &BookieAttributes, arg2: u64, arg3: &0x2::transfer_policy::TransferPolicy<Bookie>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0.random_pool) >= arg2, 9223375150706327557);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x2::object::new(arg6);
            let v2 = 0x2::object::uid_to_bytes(&v1);
            0x2::object::delete(v1);
            let v3 = 0;
            let v4 = 0;
            while (v4 < 8) {
                let v5 = v3 << 8;
                v3 = v5 | (*0x1::vector::borrow<u8>(&v2, v4) as u64);
                v4 = v4 + 1;
            };
            let v6 = 0x1::vector::swap_remove<u64>(&mut arg0.random_pool, v3 % 0x1::vector::length<u64>(&arg0.random_pool));
            let v7 = if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.nft_attributes, v6)) {
                let v8 = 0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.nft_attributes, v6);
                let v9 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
                let v10 = 0;
                while (v10 < 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(v8)) {
                    let (v11, v12) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v8, v10);
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, *v11, *v12);
                    v10 = v10 + 1;
                };
                v9
            } else {
                0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
            };
            let v13 = if (0x2::table::contains<u64, 0x2::url::Url>(&arg1.nft_urls, v6)) {
                *0x2::table::borrow<u64, 0x2::url::Url>(&arg1.nft_urls, v6)
            } else {
                0x2::url::new_unsafe_from_bytes(b"https://static.tbook.vip/img/45184c00fd9f4efa84d691e80a13ce62")
            };
            let v14 = Bookie{
                id          : 0x2::object::new(arg6),
                number      : v6,
                description : 0x1::string::utf8(b"Forged in the heart of the TBook Kingdom, Bookie NFTs grant their bearers the mantle of guardians, shaping the fate of AI agents on Sui and guiding its next great evolution"),
                url         : v13,
                attributes  : v7,
            };
            arg0.minted = arg0.minted + 1;
            0x2::kiosk::lock<Bookie>(arg4, arg5, arg3, v14);
            v0 = v0 + 1;
        };
        add_addresses_minted(arg0, 0x2::tx_context::sender(arg6), arg2);
    }

    public fun attributes(arg0: &Bookie) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public entry fun bulk_add_attributes(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            add_attributes(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v0), arg5);
            v0 = v0 + 1;
        };
    }

    public entry fun bulk_add_urls(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            add_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<0x1::string::String>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    public fun can_mint(arg0: &BookieRegistry) : &bool {
        &arg0.can_mint
    }

    fun check_max_nfts_per_address(arg0: &BookieRegistry, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.addresses_minted, arg1)) {
            assert!(*0x2::table::borrow<address, u64>(&arg0.addresses_minted, arg1) + arg2 <= arg0.max_nfts_per_address, 9223375404109529095);
        };
    }

    public entry fun clear_random_pool(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.random_pool = 0x1::vector::empty<u64>();
    }

    public fun collection_size(arg0: &BookieRegistry) : &u64 {
        &arg0.collection_size
    }

    public fun description(arg0: &Bookie) : &0x1::string::String {
        &arg0.description
    }

    public entry fun disable_signature_verification(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.require_signature = false;
    }

    public entry fun enable_signature_verification(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.require_signature = true;
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Bookie #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://tbook.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"TBook Labs"));
        let v5 = 0x2::display::new_with_fields<Bookie>(&v0, v1, v3, arg1);
        0x2::display::update_version<Bookie>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Bookie>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = BookieRegistry{
            id                   : 0x2::object::new(arg1),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            minted               : 0,
            collection_size      : 6666,
            can_mint             : false,
            require_signature    : true,
            max_nfts_per_address : 5,
            addresses_minted     : 0x2::table::new<address, u64>(arg1),
            mint_price           : 99000000,
            usdc_mint_price      : 100000,
            treasury             : 0x2::tx_context::sender(arg1),
            signer_public_key    : 0x1::vector::empty<u8>(),
            random_pool          : 0x1::vector::empty<u64>(),
            random_min           : 0,
            random_max           : 6666 - 1,
        };
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Bookie NFT Registry"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://tbook.com/"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"TBook Labs"));
        let v11 = 0x2::display::new_with_fields<BookieRegistry>(&v0, v7, v9, arg1);
        0x2::display::update_version<BookieRegistry>(&mut v11);
        0x2::transfer::public_transfer<0x2::display::Display<BookieRegistry>>(v11, 0x2::tx_context::sender(arg1));
        let v12 = BookieAttributes{
            id             : 0x2::object::new(arg1),
            nft_attributes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            nft_urls       : 0x2::table::new<u64, 0x2::url::Url>(arg1),
        };
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"creator"));
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"Bookie Attributes Registry"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"https://tbook.com/"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"TBook Labs"));
        let v17 = 0x2::display::new_with_fields<BookieAttributes>(&v0, v13, v15, arg1);
        0x2::display::update_version<BookieAttributes>(&mut v17);
        0x2::transfer::public_transfer<0x2::display::Display<BookieAttributes>>(v17, 0x2::tx_context::sender(arg1));
        let v18 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v18, 0x2::tx_context::sender(arg1));
        let (v19, v20) = 0x2::transfer_policy::new<Bookie>(&v0, arg1);
        let v21 = v20;
        let v22 = v19;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Bookie>(&mut v22, &v21);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Bookie>(&mut v22, &v21, 100, 0);
        let v23 = TradeDisabledRule{dummy_field: false};
        0x2::transfer_policy::add_rule<Bookie, TradeDisabledRule, vector<u8>>(v23, &mut v22, &v21, b"no_config");
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Bookie>>(v22);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Bookie>>(v21, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BookieRegistry>(v6);
        0x2::transfer::share_object<BookieAttributes>(v12);
    }

    public entry fun init_random_pool(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.random_pool = 0x1::vector::empty<u64>();
        let v0 = arg1.random_min;
        while (v0 <= arg1.random_max) {
            0x1::vector::push_back<u64>(&mut arg1.random_pool, v0);
            v0 = v0 + 1;
        };
    }

    public fun max_nfts_per_address(arg0: &BookieRegistry) : &u64 {
        &arg0.max_nfts_per_address
    }

    fun mint(arg0: &mut BookieRegistry, arg1: &BookieAttributes, arg2: u64, arg3: &0x2::transfer_policy::TransferPolicy<Bookie>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0.random_pool) >= arg2, 9223375301030182917);
        assert!(arg2 > 0 && arg2 <= arg0.max_nfts_per_address, 9223375313915215879);
        check_max_nfts_per_address(arg0, 0x2::tx_context::sender(arg6), arg2);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x2::object::new(arg6);
            let v2 = 0x2::object::uid_to_bytes(&v1);
            0x2::object::delete(v1);
            let v3 = 0;
            let v4 = 0;
            while (v4 < 8) {
                let v5 = v3 << 8;
                v3 = v5 | (*0x1::vector::borrow<u8>(&v2, v4) as u64);
                v4 = v4 + 1;
            };
            let v6 = 0x1::vector::swap_remove<u64>(&mut arg0.random_pool, v3 % 0x1::vector::length<u64>(&arg0.random_pool));
            let v7 = if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.nft_attributes, v6)) {
                let v8 = 0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.nft_attributes, v6);
                let v9 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
                let v10 = 0;
                while (v10 < 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(v8)) {
                    let (v11, v12) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v8, v10);
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, *v11, *v12);
                    v10 = v10 + 1;
                };
                v9
            } else {
                0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
            };
            let v13 = if (0x2::table::contains<u64, 0x2::url::Url>(&arg1.nft_urls, v6)) {
                *0x2::table::borrow<u64, 0x2::url::Url>(&arg1.nft_urls, v6)
            } else {
                0x2::url::new_unsafe_from_bytes(b"https://static.tbook.vip/img/45184c00fd9f4efa84d691e80a13ce62")
            };
            let v14 = Bookie{
                id          : 0x2::object::new(arg6),
                number      : v6,
                description : 0x1::string::utf8(b"Forged in the heart of the TBook Kingdom, Bookie NFTs grant their bearers the mantle of guardians, shaping the fate of AI agents on Sui and guiding its next great evolution"),
                url         : v13,
                attributes  : v7,
            };
            arg0.minted = arg0.minted + 1;
            0x2::kiosk::lock<Bookie>(arg4, arg5, arg3, v14);
            v0 = v0 + 1;
        };
        add_addresses_minted(arg0, 0x2::tx_context::sender(arg6), arg2);
    }

    public entry fun mint_bookie(arg0: &mut BookieRegistry, arg1: &BookieAttributes, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<Bookie>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.can_mint, 9223374669669859331);
        if (arg0.require_signature) {
            verify_mint_signature(arg0, 0x2::tx_context::sender(arg8), arg2, &arg3);
        };
        let v0 = arg2 * arg0.mint_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 9223373750546726913);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg8)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        mint(arg0, arg1, arg2, arg5, arg6, arg7, arg8);
    }

    public entry fun mint_bookie_admin(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &BookieAttributes, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<Bookie>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        admin_mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun mint_bookie_with_coin<T0>(arg0: &mut BookieRegistry, arg1: &BookieAttributes, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::transfer_policy::TransferPolicy<Bookie>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.can_mint, 9223374669669859331);
        if (arg0.require_signature) {
            verify_mint_signature(arg0, 0x2::tx_context::sender(arg9), arg2, &arg3);
        };
        assert!(0x2::coin::value<T0>(&arg5) >= arg2 * arg4, 9223373750546726913);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg0.treasury);
        mint(arg0, arg1, arg2, arg6, arg7, arg8, arg9);
    }

    public fun mint_price(arg0: &BookieRegistry) : &u64 {
        &arg0.mint_price
    }

    public fun minted(arg0: &BookieRegistry) : &u64 {
        &arg0.minted
    }

    public fun number(arg0: &Bookie) : &u64 {
        &arg0.number
    }

    public fun random_max(arg0: &BookieRegistry) : u64 {
        arg0.random_max
    }

    public fun random_min(arg0: &BookieRegistry) : u64 {
        arg0.random_min
    }

    public fun random_pool_size(arg0: &BookieRegistry) : u64 {
        0x1::vector::length<u64>(&arg0.random_pool)
    }

    public entry fun remove_attributes(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.nft_attributes, *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun remove_urls(arg0: &AdminCap, arg1: &mut BookieAttributes, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x2::table::remove<u64, 0x2::url::Url>(&mut arg1.nft_urls, *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun require_signature(arg0: &BookieRegistry) : &bool {
        &arg0.require_signature
    }

    public entry fun set_mint_price(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_price = arg2;
    }

    public entry fun set_random_range(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.random_min = arg2;
        arg1.random_max = arg3;
    }

    public entry fun set_signer_public_key(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.signer_public_key = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury = arg2;
    }

    public entry fun set_usdc_mint_price(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.usdc_mint_price = arg2;
    }

    public fun signer_public_key(arg0: &BookieRegistry) : &vector<u8> {
        &arg0.signer_public_key
    }

    public entry fun start_minting(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.can_mint = true;
    }

    public entry fun start_trading(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Bookie>, arg2: &0x2::transfer_policy::TransferPolicyCap<Bookie>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer_policy::remove_rule<Bookie, TradeDisabledRule, vector<u8>>(arg1, arg2);
    }

    public entry fun stop_minting(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.can_mint = false;
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury(arg0: &BookieRegistry) : &address {
        &arg0.treasury
    }

    public fun usdc_mint_price(arg0: &BookieRegistry) : &u64 {
        &arg0.usdc_mint_price
    }

    fun verify_mint_signature(arg0: &BookieRegistry, arg1: address, arg2: u64, arg3: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.signer_public_key), 9223375500000000002);
        let v0 = 0x2::bcs::to_bytes<address>(&arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(arg3, &arg0.signer_public_key, &v0), 9223375500000000001);
    }

    public entry fun withdraw_balance(arg0: &AdminCap, arg1: &mut BookieRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_royalties(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Bookie>, arg2: &0x2::transfer_policy::TransferPolicyCap<Bookie>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<Bookie>(arg1, arg2, 0x1::option::none<u64>(), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

