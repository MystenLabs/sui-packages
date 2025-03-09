module 0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::candy_machine {
    struct CandyMachine has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        baseuri: 0x1::string::String,
        authority: address,
        phase: u8,
        paused: bool,
        total_supply: u64,
        minted: u64,
        candies: vector<0x1::bit_vector::BitVector>,
        proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
        publisher: 0x2::object::ID,
    }

    struct OGList has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
        remaining_mints: 0x2::table::Table<address, u64>,
    }

    struct Whitelist has store, key {
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

    public entry fun add_to_og_list(arg0: &mut OGList, arg1: vector<address>, arg2: &CandyMachine, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.authority, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.addresses, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.addresses, v1);
                0x2::table::add<address, u64>(&mut arg0.remaining_mints, v1, 1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_whitelist(arg0: &mut Whitelist, arg1: vector<address>, arg2: &CandyMachine, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.authority, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.addresses, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.addresses, v1);
                0x2::table::add<address, u64>(&mut arg0.remaining_mints, v1, 3);
            };
            v0 = v0 + 1;
        };
    }

    fun check_user_status(arg0: address, arg1: &OGList, arg2: &Whitelist) : u8 {
        if (0x1::vector::contains<address>(&arg1.addresses, &arg0)) {
            if (*0x2::table::borrow<address, u64>(&arg1.remaining_mints, arg0) > 0) {
                return 1
            };
        };
        if (0x1::vector::contains<address>(&arg2.addresses, &arg0)) {
            if (*0x2::table::borrow<address, u64>(&arg2.remaining_mints, arg0) > 0) {
                return 2
            };
        };
        3
    }

    public fun create_bit_mask(arg0: u64) : vector<0x1::bit_vector::BitVector> {
        let v0 = arg0 / 1024;
        let v1 = v0;
        let v2 = arg0 - v0 * 1024;
        if (arg0 < 1024) {
            v1 = 0;
            v2 = arg0;
        };
        let v3 = 0x1::vector::empty<0x1::bit_vector::BitVector>();
        while (v1 > 0) {
            0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v3, 0x1::bit_vector::new(1023));
            v1 = v1 - 1;
        };
        0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v3, 0x1::bit_vector::new(v2));
        v3
    }

    fun get_price_for_status(arg0: u8, arg1: u8) : u64 {
        if (arg0 == 1) {
            assert!(arg1 == 1, 4);
            0
        } else if (arg0 == 2) {
            if (arg1 == 1) {
                0
            } else {
                assert!(arg1 == 2, 4);
                5000000000
            }
        } else if (arg1 == 1) {
            0
        } else if (arg1 == 2) {
            5000000000
        } else {
            10000000000
        }
    }

    public fun init_candy(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CandyMachine{
            id                     : 0x2::object::new(arg5),
            collection_name        : arg0,
            collection_description : arg1,
            baseuri                : arg2,
            authority              : 0x2::tx_context::sender(arg5),
            phase                  : 0,
            paused                 : false,
            total_supply           : arg3,
            minted                 : 0,
            candies                : create_bit_mask(arg3),
            proceeds               : 0x2::balance::zero<0x2::sui::SUI>(),
            publisher              : arg4,
        };
        let v1 = OGList{
            id              : 0x2::object::new(arg5),
            addresses       : 0x1::vector::empty<address>(),
            remaining_mints : 0x2::table::new<address, u64>(arg5),
        };
        let v2 = Whitelist{
            id              : 0x2::object::new(arg5),
            addresses       : 0x1::vector::empty<address>(),
            remaining_mints : 0x2::table::new<address, u64>(arg5),
        };
        let v3 = PublicMints{
            id          : 0x2::object::new(arg5),
            mint_counts : 0x2::table::new<address, u64>(arg5),
        };
        0x2::transfer::public_share_object<CandyMachine>(v0);
        0x2::transfer::public_share_object<OGList>(v1);
        0x2::transfer::public_share_object<Whitelist>(v2);
        0x2::transfer::public_share_object<PublicMints>(v3);
    }

    public fun mint_available_number(arg0: u64, arg1: vector<0x1::bit_vector::BitVector>) : (u64, vector<0x1::bit_vector::BitVector>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < arg0) {
            let v3 = *0x1::vector::borrow_mut<0x1::bit_vector::BitVector>(&mut arg1, v1);
            let v4 = 0;
            while (v4 < 0x1::bit_vector::length(&v3)) {
                if (!0x1::bit_vector::is_index_set(&v3, v4)) {
                    v0 = v0 + 1;
                };
                v2 = v2 + 1;
                if (v0 == arg0) {
                    0x1::bit_vector::set(&mut v3, v4);
                    break
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        (v2, arg1)
    }

    public entry fun mint_nft(arg0: &mut CandyMachine, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut OGList, arg3: &mut Whitelist, arg4: &mut PublicMints, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg0.phase > 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x1::vector::contains<address>(&arg2.addresses, &v0)) {
            if (*0x2::table::borrow<address, u64>(&arg2.remaining_mints, v0) > 0) {
                update_og_mint_count(arg2, v0)
            } else if (0x1::vector::contains<address>(&arg3.addresses, &v0)) {
                if (*0x2::table::borrow<address, u64>(&arg3.remaining_mints, v0) > 0) {
                    update_wl_mint_count(arg3, v0)
                } else {
                    update_public_mint_count(arg4, v0)
                }
            } else {
                update_public_mint_count(arg4, v0)
            }
        } else if (0x1::vector::contains<address>(&arg3.addresses, &v0)) {
            if (*0x2::table::borrow<address, u64>(&arg3.remaining_mints, v0) > 0) {
                update_wl_mint_count(arg3, v0)
            } else {
                update_public_mint_count(arg4, v0)
            }
        } else {
            update_public_mint_count(arg4, v0)
        };
        assert!(v1, 5);
        let v2 = get_price_for_status(arg0.phase, check_user_status(v0, arg2, arg3));
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v2, arg5)));
        };
        let (v3, v4) = mint_available_number(pseudo_random(v0, arg0.total_supply - arg0.minted), arg0.candies);
        arg0.candies = v4;
        let (v5, v6) = 0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::kiosk::new_kiosk(arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::nft::create_nft_with_ipfs(arg0.baseuri, v3, 0x2::object::id<0x2::kiosk::Kiosk>(&v8), 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v7), arg5);
        0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::kiosk::place(&mut v8, &v7, v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, v0);
        let v10 = NFTMinted{
            nft_id     : 0x2::object::id<0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::nft::Nft>(&v9),
            creator    : arg0.authority,
            receiver   : v0,
            collection : arg0.collection_name,
            name       : 0x1::string::utf8(b"My NFT #"),
        };
        0x2::event::emit<NFTMinted>(v10);
        arg0.minted = arg0.minted + 1;
    }

    public fun pseudo_random(arg0: address, arg1: u64) : u64 {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = b"";
        let v3 = 24;
        while (v3 < 32) {
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v1, v3));
            0x1::vector::append<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        assert!(arg1 > 0, 999);
        let v5 = to_u64(v2) % arg1 + 1;
        let v6 = v5;
        if (v5 == 0) {
            v6 = 1;
        };
        v6
    }

    public entry fun set_phase(arg0: &mut CandyMachine, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        assert!(arg1 <= 3, 2);
        arg0.phase = arg1;
    }

    fun to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun update_og_mint_count(arg0: &mut OGList, arg1: address) : bool {
        if (!0x1::vector::contains<address>(&arg0.addresses, &arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, u64>(&arg0.remaining_mints, arg1);
        if (*v0 == 0) {
            return false
        };
        let v1 = if (*v0 > 1) {
            *v0 - 1
        } else {
            0
        };
        0x2::table::add<address, u64>(&mut arg0.remaining_mints, arg1, v1);
        true
    }

    fun update_public_mint_count(arg0: &mut PublicMints, arg1: address) : bool {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.mint_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, arg1)
        } else {
            0
        };
        if (v0 >= 3) {
            return false
        };
        0x2::table::add<address, u64>(&mut arg0.mint_counts, arg1, v0 + 1);
        true
    }

    fun update_wl_mint_count(arg0: &mut Whitelist, arg1: address) : bool {
        if (!0x1::vector::contains<address>(&arg0.addresses, &arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, u64>(&arg0.remaining_mints, arg1);
        if (*v0 == 0) {
            return false
        };
        let v1 = if (*v0 > 1) {
            *v0 - 1
        } else {
            0
        };
        0x2::table::add<address, u64>(&mut arg0.remaining_mints, arg1, v1);
        true
    }

    public entry fun withdraw_proceeds(arg0: &mut CandyMachine, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::balance::value<0x2::sui::SUI>(&arg0.proceeds), arg1), arg0.authority);
    }

    // decompiled from Move bytecode v6
}

