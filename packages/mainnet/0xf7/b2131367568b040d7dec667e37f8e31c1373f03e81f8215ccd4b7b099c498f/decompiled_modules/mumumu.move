module 0xf7b2131367568b040d7dec667e37f8e31c1373f03e81f8215ccd4b7b099c498f::mumumu {
    struct MUMUMU has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        token_id: u64,
    }

    struct PriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    struct MaxSupplyUpdated has copy, drop {
        old_max_supply: u64,
        new_max_supply: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct Mumumu has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        price: u64,
        max_supply: u64,
        max_mint_per_wallet: u64,
        total_supply: u64,
        paused: bool,
        mint_counts: 0x2::table::Table<address, u64>,
        image_base: 0x1::string::String,
        character_types: 0x2::table::Table<u64, 0x1::string::String>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        image_base: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct TransferPolicyStorage has key {
        id: 0x2::object::UID,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<NFT>,
        policy: 0x2::transfer_policy::TransferPolicy<NFT>,
    }

    public entry fun airdrop(arg0: &mut Mumumu, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        mint_nft(arg0, arg1, arg2, arg3);
    }

    public entry fun batch_set_character_types(arg0: &mut Mumumu, arg1: vector<u64>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 8);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            set_character_type(arg0, *0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<vector<u8>>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    fun generate_attributes(arg0: u64, arg1: &Mumumu) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = if (0x2::table::contains<u64, 0x1::string::String>(&arg1.character_types, arg0)) {
            *0x2::table::borrow<u64, 0x1::string::String>(&arg1.character_types, arg0)
        } else {
            0x1::string::utf8(b"standard")
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"character"), v1);
        v0
    }

    fun init(arg0: MUMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Mumumu{
            id                  : 0x2::object::new(arg1),
            admin               : v0,
            treasury            : @0x51858cb239bfda3e5be33a946aba334c2e42b1d410c61f528259df40a434f75,
            price               : 6660000000,
            max_supply          : 666,
            max_mint_per_wallet : 10,
            total_supply        : 0,
            paused              : false,
            mint_counts         : 0x2::table::new<address, u64>(arg1),
            image_base          : 0x1::string::utf8(b"https://storage.googleapis.com/mmp-demo/image.png"),
            character_types     : 0x2::table::new<u64, 0x1::string::String>(arg1),
        };
        let v2 = 0x2::package::claim<MUMUMU>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"character"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Mumumu v3 #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_base}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{character}"));
        let v7 = 0x2::display::new_with_fields<NFT>(&v2, v3, v5, arg1);
        0x2::display::update_version<NFT>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<NFT>(&v2, arg1);
        let v10 = v9;
        let v11 = v8;
        0xf7b2131367568b040d7dec667e37f8e31c1373f03e81f8215ccd4b7b099c498f::royalty_rule::add<NFT>(&mut v11, &v10, 1000, 0);
        0xf7b2131367568b040d7dec667e37f8e31c1373f03e81f8215ccd4b7b099c498f::kiosk_lock_rule::add<NFT>(&mut v11, &v10);
        let v12 = TransferPolicyStorage{
            id         : 0x2::object::new(arg1),
            policy_cap : v10,
            policy     : v11,
        };
        0x2::transfer::share_object<TransferPolicyStorage>(v12);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v7, v0);
        0x2::transfer::share_object<Mumumu>(v1);
    }

    public entry fun list_token(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<NFT>(arg0, arg1, arg2, arg3);
    }

    public fun max_mint_per_wallet(arg0: &Mumumu) : u64 {
        arg0.max_mint_per_wallet
    }

    public fun max_supply(arg0: &Mumumu) : u64 {
        arg0.max_supply
    }

    public entry fun mint(arg0: &mut Mumumu, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!arg0.paused, 6);
        assert!(arg0.total_supply + arg1 <= arg0.max_supply, 1);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, v0)
        } else {
            0
        };
        assert!(v1 + arg1 <= arg0.max_mint_per_wallet, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.price * arg1, 4);
        mint_nft(arg0, v0, arg1, arg3);
        if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.mint_counts, v0);
            *v2 = *v2 + arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mint_counts, v0, arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.treasury);
    }

    public fun mint_count_of(arg0: &Mumumu, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mint_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, arg1)
        } else {
            0
        }
    }

    fun mint_nft(arg0: &mut Mumumu, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = arg0.total_supply + 1;
            let v2 = NFT{
                id         : 0x2::object::new(arg3),
                token_id   : v1,
                image_base : arg0.image_base,
                attributes : generate_attributes(v1, arg0),
            };
            arg0.total_supply = v1;
            let v3 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v2),
                minter   : arg1,
                token_id : v1,
            };
            0x2::event::emit<NFTMinted>(v3);
            let (v4, v5) = 0x2::kiosk::new(arg3);
            let v6 = v5;
            let v7 = v4;
            0x2::kiosk::place<NFT>(&mut v7, &v6, v2);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, arg1);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
            v0 = v0 + 1;
        };
    }

    public fun paused(arg0: &Mumumu) : bool {
        arg0.paused
    }

    public fun price(arg0: &Mumumu) : u64 {
        arg0.price
    }

    public entry fun purchase_token(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<NFT>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<NFT>(arg0, arg1, arg2);
        let v2 = v1;
        let (v3, v4) = 0x2::kiosk::new(arg4);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::place<NFT>(&mut v6, &v5, v0);
        0xf7b2131367568b040d7dec667e37f8e31c1373f03e81f8215ccd4b7b099c498f::kiosk_lock_rule::prove<NFT>(&mut v2, &v6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<NFT>(arg3, v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
    }

    public entry fun set_character_type(arg0: &mut Mumumu, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1 > 0 && arg1 <= arg0.max_supply, 7);
        if (0x2::table::contains<u64, 0x1::string::String>(&arg0.character_types, arg1)) {
            *0x2::table::borrow_mut<u64, 0x1::string::String>(&mut arg0.character_types, arg1) = 0x1::string::utf8(arg2);
        } else {
            0x2::table::add<u64, 0x1::string::String>(&mut arg0.character_types, arg1, 0x1::string::utf8(arg2));
        };
    }

    public entry fun set_image_base(arg0: &mut Mumumu, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.image_base = 0x1::string::utf8(arg1);
    }

    public entry fun set_max_mint_per_wallet(arg0: &mut Mumumu, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.max_mint_per_wallet = arg1;
    }

    public entry fun set_max_supply(arg0: &mut Mumumu, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 >= arg0.total_supply, 3);
        arg0.max_supply = arg1;
        let v0 = MaxSupplyUpdated{
            old_max_supply : arg0.max_supply,
            new_max_supply : arg1,
        };
        0x2::event::emit<MaxSupplyUpdated>(v0);
    }

    public entry fun set_paused(arg0: &mut Mumumu, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.paused = arg1;
    }

    public entry fun set_price(arg0: &mut Mumumu, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 > 0, 2);
        arg0.price = arg1;
        let v0 = PriceUpdated{
            old_price : arg0.price,
            new_price : arg1,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun set_treasury(arg0: &mut Mumumu, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.treasury = arg1;
    }

    public fun total_supply(arg0: &Mumumu) : u64 {
        arg0.total_supply
    }

    public entry fun transfer_admin(arg0: &mut Mumumu, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public entry fun update_display(arg0: &Mumumu, arg1: &0x2::package::Publisher, arg2: &mut 0x2::display::Display<NFT>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"character"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg5));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg6));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x2::display::add<NFT>(arg2, *0x1::vector::borrow<0x1::string::String>(&v0, v4), *0x1::vector::borrow<0x1::string::String>(&v2, v4));
            v4 = v4 + 1;
        };
        0x2::display::update_version<NFT>(arg2);
    }

    // decompiled from Move bytecode v6
}

