module 0xa00a485b4b0ba1b801beed86e7fe3d5acd6dea5f3582ed5640f3a4a57f0ca6c2::tebc_a80 {
    struct TEBC_A80 has drop {
        dummy_field: bool,
    }

    struct A80VN has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFT_Metadata has copy, drop, store {
        image_hash: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct TEBC_A80_COLLECTION has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
        public_minted_wallets: 0x2::table::Table<address, bool>,
        remaining_nfts: vector<NFT_Metadata>,
        minted_count: u64,
        creator: address,
        minting_paused: bool,
        whitelist_mint_start_time: u64,
        public_mint_start_time: u64,
        version: u64,
    }

    struct NFT_MINTED_EVENT has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun add_nft_metadata(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION, arg2: vector<0x1::string::String>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>) {
        versionChecking(arg1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg3) == v0, 0);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg4) == v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1);
            let v3 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1);
            let v4 = 0x1::vector::length<0x1::string::String>(v2);
            assert!(0x1::vector::length<0x1::string::String>(v3) == v4, 2);
            let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v6 = 0;
            while (v6 < v4) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, *0x1::vector::borrow<0x1::string::String>(v2, v6), *0x1::vector::borrow<0x1::string::String>(v3, v6));
                v6 = v6 + 1;
            };
            let v7 = NFT_Metadata{
                image_hash : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                attributes : v5,
            };
            0x1::vector::push_back<NFT_Metadata>(&mut arg1.remaining_nfts, v7);
            v1 = v1 + 1;
        };
    }

    public fun add_to_whitelist(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        versionChecking(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::add<address, bool>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0), false);
            v0 = v0 + 1;
        };
    }

    public fun get_mint_stage(arg0: &TEBC_A80_COLLECTION, arg1: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.public_mint_start_time > 0 && v0 >= arg0.public_mint_start_time) {
            return 2
        };
        if (arg0.whitelist_mint_start_time > 0 && v0 >= arg0.whitelist_mint_start_time) {
            return 1
        };
        0
    }

    public fun get_mint_times(arg0: &TEBC_A80_COLLECTION) : (u64, u64) {
        (arg0.whitelist_mint_start_time, arg0.public_mint_start_time)
    }

    public fun has_minted(arg0: &TEBC_A80_COLLECTION, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.public_minted_wallets, arg1)
    }

    fun init(arg0: TEBC_A80, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = TEBC_A80_COLLECTION{
            id                        : 0x2::object::new(arg1),
            whitelist                 : 0x2::table::new<address, bool>(arg1),
            public_minted_wallets     : 0x2::table::new<address, bool>(arg1),
            remaining_nfts            : 0x1::vector::empty<NFT_Metadata>(),
            minted_count              : 0,
            creator                   : 0x2::tx_context::sender(arg1),
            minting_paused            : false,
            whitelist_mint_start_time : 0,
            public_mint_start_time    : 0,
            version                   : 1,
        };
        0x2::transfer::share_object<TEBC_A80_COLLECTION>(v1);
        let v2 = 0x2::package::claim<TEBC_A80>(arg0, arg1);
        let v3 = 0x2::display::new<A80VN>(&v2, arg1);
        0x2::display::add<A80VN>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{number}"));
        0x2::display::add<A80VN>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus.atalma.io/v1/blobs/{image_hash}"));
        0x2::display::add<A80VN>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<A80VN>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://theemptyboxclub.com/"));
        0x2::display::add<A80VN>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<A80VN>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<A80VN>(&v2, arg1);
        let v6 = v5;
        let v7 = v4;
        0xa00a485b4b0ba1b801beed86e7fe3d5acd6dea5f3582ed5640f3a4a57f0ca6c2::rules::add_personal_kiosk_rule<A80VN>(&mut v7, &v6);
        0xa00a485b4b0ba1b801beed86e7fe3d5acd6dea5f3582ed5640f3a4a57f0ca6c2::rules::add_kiosk_lock_rule<A80VN>(&mut v7, &v6);
        0xa00a485b4b0ba1b801beed86e7fe3d5acd6dea5f3582ed5640f3a4a57f0ca6c2::rules::add_royalty_rule<A80VN>(&mut v7, &v6, 0xa00a485b4b0ba1b801beed86e7fe3d5acd6dea5f3582ed5640f3a4a57f0ca6c2::rules::new_royalty_config(500, 0));
        0x2::transfer::public_transfer<0x2::display::Display<A80VN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<A80VN>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<A80VN>>(v7);
    }

    public fun is_in_whitelist(arg0: &TEBC_A80_COLLECTION, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun mint(arg0: &mut TEBC_A80_COLLECTION, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &0x2::transfer_policy::TransferPolicy<A80VN>, arg6: &mut 0x2::tx_context::TxContext) {
        versionChecking(arg0);
        assert!(!arg0.minting_paused, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::vector::length<NFT_Metadata>(&arg0.remaining_nfts);
        assert!(v2 > 0, 3);
        if (v1 >= arg0.public_mint_start_time && arg0.public_mint_start_time > 0) {
            assert!(!0x2::table::contains<address, bool>(&arg0.public_minted_wallets, v0), 8);
            0x2::table::add<address, bool>(&mut arg0.public_minted_wallets, v0, true);
        } else {
            assert!(v1 >= arg0.whitelist_mint_start_time && arg0.whitelist_mint_start_time > 0, 7);
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 1);
            assert!(!*0x2::table::borrow<address, bool>(&arg0.whitelist, v0), 2);
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, v0) = true;
            0x2::table::add<address, bool>(&mut arg0.public_minted_wallets, v0, true);
        };
        let v3 = 0x2::random::new_generator(arg1, arg6);
        let v4 = 0x1::vector::swap_remove<NFT_Metadata>(&mut arg0.remaining_nfts, 0x2::random::generate_u64_in_range(&mut v3, 0, v2 - 1));
        let v5 = A80VN{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(b"A80VN Odyssey"),
            description : 0x1::string::utf8(b"A80VN Odyssey is a non-commercial on-chain art collection celebrating Vietnamese culture, bridging heritage and Web3 on the Sui blockchain."),
            image_hash  : v4.image_hash,
            number      : arg0.minted_count + 1,
            attributes  : v4.attributes,
        };
        arg0.minted_count = arg0.minted_count + 1;
        let v6 = NFT_MINTED_EVENT{
            object_id : 0x2::object::id<A80VN>(&v5),
            creator   : v0,
            name      : v5.name,
        };
        0x2::event::emit<NFT_MINTED_EVENT>(v6);
        0x2::kiosk::lock<A80VN>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg5, v5);
    }

    public fun remaining_supply(arg0: &TEBC_A80_COLLECTION) : u64 {
        0x1::vector::length<NFT_Metadata>(&arg0.remaining_nfts)
    }

    public fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION, arg2: address) {
        versionChecking(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.whitelist, arg2), 4);
        0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
    }

    public fun remove_nft_metadata(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION, arg2: 0x1::string::String) {
        versionChecking(arg1);
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        while (v0 < 0x1::vector::length<NFT_Metadata>(&arg1.remaining_nfts)) {
            if (0x1::vector::borrow<NFT_Metadata>(&arg1.remaining_nfts, v0).image_hash == arg2) {
                v1 = v0;
                v2 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v2, 5);
        0x1::vector::swap_remove<NFT_Metadata>(&mut arg1.remaining_nfts, v1);
    }

    public fun set_mint_times(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION, arg2: u64, arg3: u64) {
        versionChecking(arg1);
        arg1.whitelist_mint_start_time = arg2;
        arg1.public_mint_start_time = arg2 + arg3 * 3600000;
    }

    public fun toggle_minting_state(arg0: &AdminCap, arg1: &mut TEBC_A80_COLLECTION) {
        versionChecking(arg1);
        arg1.minting_paused = !arg1.minting_paused;
    }

    public fun total_supply(arg0: &TEBC_A80_COLLECTION) : u64 {
        arg0.minted_count + 0x1::vector::length<NFT_Metadata>(&arg0.remaining_nfts)
    }

    fun versionChecking(arg0: &TEBC_A80_COLLECTION) {
        assert!(arg0.version == 1, 0);
    }

    // decompiled from Move bytecode v6
}

