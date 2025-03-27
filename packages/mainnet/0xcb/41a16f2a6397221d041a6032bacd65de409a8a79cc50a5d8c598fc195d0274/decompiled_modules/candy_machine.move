module 0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::candy_machine {
    struct CandyMachine has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        base_uri: 0x1::string::String,
        base_image_uri: 0x1::string::String,
        authority: address,
        phase: u8,
        paused: bool,
        total_supply: u64,
        minted: u64,
        total_og_mints: u64,
        proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
        publisher: 0x2::object::ID,
        og_list: List,
        whitelist: List,
        public_mints: PublicMints,
        og_mint_price: u64,
        wl_mint_price: u64,
        public_mint_price: u64,
        og_max_mints: u64,
        wl_max_mints: u64,
        public_max_mints: u64,
        og_mint_cap: u64,
        minted_nfts: vector<0x2::object::ID>,
        original_owners: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct List has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
        remaining_mints: 0x2::table::Table<address, u64>,
    }

    struct PublicMints has store, key {
        id: 0x2::object::UID,
        mint_counts: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        receiver: address,
        collection: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct CANDY_MACHINE has drop {
        dummy_field: bool,
    }

    struct UserMintStatus has copy, drop {
        phase: u8,
        can_mint: bool,
        mints_remaining: u64,
        price_per_mint: u64,
        is_og: bool,
        is_wl: bool,
        og_mints_remaining: u64,
    }

    public entry fun add_to_og_list(arg0: &mut CandyMachine, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.og_list.addresses, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.og_list.addresses, v1);
                0x2::table::add<address, u64>(&mut arg0.og_list.remaining_mints, v1, arg0.og_max_mints);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_whitelist(arg0: &mut CandyMachine, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.whitelist.addresses, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelist.addresses, v1);
                0x2::table::add<address, u64>(&mut arg0.whitelist.remaining_mints, v1, arg0.wl_max_mints);
            };
            v0 = v0 + 1;
        };
    }

    public fun check_og_eligibility(arg0: &CandyMachine, arg1: address) : (bool, u64) {
        if (!0x1::vector::contains<address>(&arg0.og_list.addresses, &arg1)) {
            return (false, 0)
        };
        let v0 = if (arg0.total_og_mints >= arg0.og_mint_cap) {
            0
        } else {
            arg0.og_mint_cap - arg0.total_og_mints
        };
        let v1 = 0x1::u64::min(*0x2::table::borrow<address, u64>(&arg0.og_list.remaining_mints, arg1), v0);
        (v1 > 0, v1)
    }

    public fun check_public_eligibility(arg0: &CandyMachine, arg1: address) : (bool, u64) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.public_mints.mint_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.public_mints.mint_counts, arg1)
        } else {
            0
        };
        let v1 = arg0.public_max_mints - v0;
        (v1 > 0, v1)
    }

    public fun check_wl_eligibility(arg0: &CandyMachine, arg1: address) : (bool, u64) {
        if (!0x1::vector::contains<address>(&arg0.whitelist.addresses, &arg1)) {
            return (false, 0)
        };
        let v0 = *0x2::table::borrow<address, u64>(&arg0.whitelist.remaining_mints, arg1);
        (v0 > 0, v0)
    }

    fun create_nft(arg0: &mut CandyMachine, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::kiosk::new_kiosk(arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = arg0.minted + 1;
        let v5 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v5, arg0.collection_name);
        0x1::string::append(&mut v5, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v5, number_to_string(v4));
        let v6 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v6, arg0.base_image_uri);
        let v7 = 0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::create_nft_with_ipfs(v4, v5, arg0.collection_description, v6, v4, 0x2::tx_context::epoch(arg2), 0x2::object::id<0x2::kiosk::Kiosk>(&v3), 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2), arg0.authority, arg2);
        let v8 = 0x2::object::id<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>(&v7);
        0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::kiosk::place(&mut v3, &v2, v7);
        let v9 = NFTMinted{
            nft_id     : v8,
            creator    : arg0.authority,
            receiver   : arg1,
            collection : arg0.collection_name,
            name       : v5,
        };
        0x2::event::emit<NFTMinted>(v9);
        arg0.minted = arg0.minted + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.minted_nfts, v8);
        (v3, v2)
    }

    public fun get_minted_nft_ids(arg0: &CandyMachine) : vector<0x2::object::ID> {
        arg0.minted_nfts
    }

    public fun get_user_mint_status(arg0: &CandyMachine, arg1: address) : UserMintStatus {
        let v0 = arg0.phase;
        let v1 = 0x1::vector::contains<address>(&arg0.og_list.addresses, &arg1);
        let v2 = 0x1::vector::contains<address>(&arg0.whitelist.addresses, &arg1);
        let (v3, v4, v5) = if (v0 == 1) {
            if (v1) {
                let v6 = if (arg0.total_og_mints >= arg0.og_mint_cap) {
                    0
                } else {
                    arg0.og_mint_cap - arg0.total_og_mints
                };
                (true, 0x1::u64::min(*0x2::table::borrow<address, u64>(&arg0.og_list.remaining_mints, arg1), v6), arg0.og_mint_price)
            } else {
                (false, 0, arg0.og_mint_price)
            }
        } else if (v0 == 2) {
            if (v1) {
                let v7 = if (arg0.total_og_mints >= arg0.og_mint_cap) {
                    0
                } else {
                    arg0.og_mint_cap - arg0.total_og_mints
                };
                let v8 = 0x1::u64::min(*0x2::table::borrow<address, u64>(&arg0.og_list.remaining_mints, arg1), v7);
                let (v9, v10, v11) = if (v8 > 0) {
                    (v8, arg0.og_mint_price, true)
                } else {
                    let (v12, v13, v14) = if (v2) {
                        (true, *0x2::table::borrow<address, u64>(&arg0.whitelist.remaining_mints, arg1), arg0.wl_mint_price)
                    } else {
                        (false, 0, arg0.wl_mint_price)
                    };
                    (v13, v14, v12)
                };
                (v11, v9, v10)
            } else if (v2) {
                (true, *0x2::table::borrow<address, u64>(&arg0.whitelist.remaining_mints, arg1), arg0.wl_mint_price)
            } else {
                (false, 0, arg0.wl_mint_price)
            }
        } else if (v0 == 3) {
            let v15 = if (0x2::table::contains<address, u64>(&arg0.public_mints.mint_counts, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.public_mints.mint_counts, arg1)
            } else {
                0
            };
            (true, arg0.public_max_mints - v15, arg0.public_mint_price)
        } else {
            (false, 0, 0)
        };
        let v16 = if (arg0.total_og_mints >= arg0.og_mint_cap) {
            0
        } else {
            arg0.og_mint_cap - arg0.total_og_mints
        };
        UserMintStatus{
            phase              : v0,
            can_mint           : v3,
            mints_remaining    : 0x1::u64::min(v4, arg0.total_supply - arg0.minted),
            price_per_mint     : v5,
            is_og              : v1,
            is_wl              : v2,
            og_mints_remaining : v16,
        }
    }

    fun init(arg0: CANDY_MACHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<CANDY_MACHINE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>(&v4, v0, v2, arg1);
        0x2::display::update_version<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun init_candy(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = List{
            id              : 0x2::object::new(arg13),
            addresses       : 0x1::vector::empty<address>(),
            remaining_mints : 0x2::table::new<address, u64>(arg13),
        };
        let v1 = List{
            id              : 0x2::object::new(arg13),
            addresses       : 0x1::vector::empty<address>(),
            remaining_mints : 0x2::table::new<address, u64>(arg13),
        };
        let v2 = PublicMints{
            id          : 0x2::object::new(arg13),
            mint_counts : 0x2::table::new<address, u64>(arg13),
        };
        let v3 = CandyMachine{
            id                     : 0x2::object::new(arg13),
            collection_name        : arg0,
            collection_description : arg1,
            base_uri               : arg2,
            base_image_uri         : arg3,
            authority              : 0x2::tx_context::sender(arg13),
            phase                  : 0,
            paused                 : false,
            total_supply           : arg4,
            minted                 : 0,
            total_og_mints         : 0,
            proceeds               : 0x2::balance::zero<0x2::sui::SUI>(),
            publisher              : arg5,
            og_list                : v0,
            whitelist              : v1,
            public_mints           : v2,
            og_mint_price          : arg6,
            wl_mint_price          : arg7,
            public_mint_price      : arg8,
            og_max_mints           : arg9,
            wl_max_mints           : arg10,
            public_max_mints       : arg11,
            og_mint_cap            : arg12,
            minted_nfts            : 0x1::vector::empty<0x2::object::ID>(),
            original_owners        : 0x2::table::new<0x2::object::ID, address>(arg13),
        };
        0x2::transfer::public_share_object<CandyMachine>(v3);
    }

    public fun mint(arg0: &mut CandyMachine, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg0.phase > 0, 2);
        assert!(arg0.phase < 4, 2);
        assert!(arg0.minted + arg2 <= arg0.total_supply, 7);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        if (arg0.phase == 1) {
            v1 = mint_og(arg0, v0, arg2);
        } else if (arg0.phase == 2) {
            let v2 = false;
            if (0x1::vector::contains<address>(&arg0.og_list.addresses, &v0)) {
                if (*0x2::table::borrow<address, u64>(&arg0.og_list.remaining_mints, v0) >= arg2 && arg0.total_og_mints + arg2 <= arg0.og_mint_cap) {
                    v1 = mint_og(arg0, v0, arg2);
                    v2 = true;
                };
            };
            if (!v2) {
                v1 = mint_wl(arg0, v0, arg2);
            };
        } else {
            v1 = mint_public(arg0, v0, arg2);
        };
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v3 >= v1, 6);
        if (v3 == v1) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        };
        let v4 = 0;
        while (v4 < arg2) {
            let (v5, v6) = create_nft(arg0, v0, arg3);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, v0);
            v4 = v4 + 1;
        };
    }

    fun mint_og(arg0: &mut CandyMachine, arg1: address, arg2: u64) : u64 {
        assert!(0x1::vector::contains<address>(&arg0.og_list.addresses, &arg1), 4);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.og_list.remaining_mints, arg1);
        let v1 = if (arg0.total_og_mints >= arg0.og_mint_cap) {
            0
        } else {
            arg0.og_mint_cap - arg0.total_og_mints
        };
        assert!(0x1::u64::min(v0, v1) >= arg2, 5);
        0x2::table::remove<address, u64>(&mut arg0.og_list.remaining_mints, arg1);
        0x2::table::add<address, u64>(&mut arg0.og_list.remaining_mints, arg1, v0 - arg2);
        arg0.total_og_mints = arg0.total_og_mints + arg2;
        0
    }

    fun mint_public(arg0: &mut CandyMachine, arg1: address, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.public_mints.mint_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.public_mints.mint_counts, arg1)
        } else {
            0
        };
        assert!(v0 + arg2 <= arg0.public_max_mints, 5);
        if (0x2::table::contains<address, u64>(&arg0.public_mints.mint_counts, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.public_mints.mint_counts, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.public_mints.mint_counts, arg1, v0 + arg2);
        arg0.public_mint_price * arg2
    }

    fun mint_wl(arg0: &mut CandyMachine, arg1: address, arg2: u64) : u64 {
        assert!(0x1::vector::contains<address>(&arg0.whitelist.addresses, &arg1), 4);
        let v0 = 0x2::table::borrow<address, u64>(&arg0.whitelist.remaining_mints, arg1);
        assert!(*v0 >= arg2, 5);
        0x2::table::remove<address, u64>(&mut arg0.whitelist.remaining_mints, arg1);
        0x2::table::add<address, u64>(&mut arg0.whitelist.remaining_mints, arg1, *v0 - arg2);
        arg0.wl_mint_price * arg2
    }

    fun number_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(&v0) - 1;
        while (v1 < v2) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1) = *0x1::vector::borrow<u8>(&v0, v2);
            *0x1::vector::borrow_mut<u8>(&mut v0, v2) = *0x1::vector::borrow<u8>(&v0, v1);
            v1 = v1 + 1;
            v2 = v2 - 1;
        };
        0x1::string::utf8(v0)
    }

    public entry fun reveal_and_return_nft(arg0: &mut CandyMachine, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 4, 2);
        assert!(0x2::tx_context::sender(arg7) == arg0.authority, 1);
        assert!(!0x1::string::is_empty(&arg6), 8);
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.original_owners, arg3), 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 8);
        let v0 = 0x2::kiosk::take<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>(arg1, &arg2, arg3);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, arg6);
        let v2 = 0x1::vector::empty<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Attribute>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x1::vector::push_back<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Attribute>(&mut v2, 0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::create_attribute(*0x1::vector::borrow<0x1::string::String>(&arg4, v3), *0x1::vector::borrow<0x1::string::String>(&arg5, v3)));
            v3 = v3 + 1;
        };
        0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::update_metadata(&mut v0, v1, v2, arg7);
        0x2::kiosk::place<0xcb41a16f2a6397221d041a6032bacd65de409a8a79cc50a5d8c598fc195d0274::nft::Nft>(arg1, &arg2, v0);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.original_owners, arg3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg2, *0x2::table::borrow<0x2::object::ID, address>(&arg0.original_owners, arg3));
    }

    public entry fun send_nft_and_cap_for_reveal(arg0: &mut CandyMachine, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 4, 2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.minted_nfts, &arg3), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg0.original_owners, arg3), 8);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.original_owners, arg3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg2, arg0.authority);
    }

    public entry fun set_paused(arg0: &mut CandyMachine, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        arg0.paused = arg1;
    }

    public entry fun set_phase(arg0: &mut CandyMachine, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        assert!(arg1 <= 4, 2);
        assert!(arg1 >= arg0.phase, 2);
        arg0.phase = arg1;
    }

    public entry fun withdraw_proceeds(arg0: &mut CandyMachine, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::balance::value<0x2::sui::SUI>(&arg0.proceeds), arg1), arg0.authority);
    }

    // decompiled from Move bytecode v6
}

