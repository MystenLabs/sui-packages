module 0xdef253780e6d2e8d5b01bb6bf76919df188dec239741c53032a3c09cd9bff072::sui_odyssey {
    struct SUI_ODYSSEY has drop {
        dummy_field: bool,
    }

    struct SuiOdyssey has store, key {
        id: 0x2::object::UID,
        number: u64,
        created_at_ms: u64,
        creator: address,
    }

    struct SuiOdysseyMintGlobal has store, key {
        id: 0x2::object::UID,
        fee: u64,
        whitelist_hash: vector<u8>,
        wminted: 0x2::table::Table<address, bool>,
        minted: 0x2::table::Table<address, bool>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start_time_ms: u64,
        expired_time_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public entry fun withdraw_all(arg0: &mut SuiOdysseyMintGlobal, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg3), arg1);
    }

    fun init(arg0: SUI_ODYSSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Fewchariana Jones - Sui Odyssey NFT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://fewcha.app/fewchariana-jones-sui-odyssey-nft.gif"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Exclusive NFT release to celebrate the monumental launch of Sui Permanent Testnet & Sui Mainnet"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://fewcha.app/"));
        let v5 = 0x2::package::claim<SUI_ODYSSEY>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<SuiOdyssey>(&v5, v1, v3, arg1);
        0x2::display::update_version<SuiOdyssey>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SuiOdyssey>>(v6, v0);
        let v7 = SuiOdysseyMintGlobal{
            id              : 0x2::object::new(arg1),
            fee             : 100000000,
            whitelist_hash  : x"7f9582e5528846cd02a6738cdf5dc0b7ff412055ae3894c1ce6f9177c4287f90",
            wminted         : 0x2::table::new<address, bool>(arg1),
            minted          : 0x2::table::new<address, bool>(arg1),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            start_time_ms   : 1685790000000,
            expired_time_ms : 1686999600000,
        };
        0x2::transfer::share_object<SuiOdysseyMintGlobal>(v7);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, v0);
    }

    fun internal_mint(arg0: &mut SuiOdysseyMintGlobal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 > arg0.start_time_ms, 1);
        assert!(v1 < arg0.expired_time_ms, 2);
        let v2 = SuiOdyssey{
            id            : 0x2::object::new(arg2),
            number        : 0x2::table::length<address, bool>(&arg0.minted) + 0x2::table::length<address, bool>(&arg0.wminted),
            created_at_ms : v1,
            creator       : v0,
        };
        let v3 = MintEvent{object_id: 0x2::object::uid_to_inner(&v2.id)};
        0x2::event::emit<MintEvent>(v3);
        0x2::transfer::transfer<SuiOdyssey>(v2, v0);
    }

    public entry fun public_mint(arg0: &mut SuiOdysseyMintGlobal, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.minted, v0), 3);
        0x2::table::add<address, bool>(&mut arg0.minted, v0, true);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.fee, arg3)));
        internal_mint(arg0, arg2, arg3);
    }

    public entry fun update_conf(arg0: &mut SuiOdysseyMintGlobal, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.fee = arg1;
        arg0.whitelist_hash = arg2;
        arg0.start_time_ms = arg3;
        arg0.expired_time_ms = arg4;
    }

    public entry fun whitelist_mint(arg0: &mut SuiOdysseyMintGlobal, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xdef253780e6d2e8d5b01bb6bf76919df188dec239741c53032a3c09cd9bff072::utils::verify_calldata(arg1, arg0.whitelist_hash, 0x1::bcs::to_bytes<address>(&v0)), 4);
        assert!(!0x2::table::contains<address, bool>(&arg0.wminted, v0), 3);
        0x2::table::add<address, bool>(&mut arg0.wminted, v0, true);
        internal_mint(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

