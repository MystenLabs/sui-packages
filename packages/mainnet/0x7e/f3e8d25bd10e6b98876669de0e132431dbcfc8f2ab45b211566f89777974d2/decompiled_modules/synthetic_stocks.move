module 0xee79946cb73446fb82540826caf775c8d3a076646cc17049e3532cc5459d40e8::synthetic_stocks {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
        allowed_backend: address,
    }

    struct SyntheticStock has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        amount: u64,
        backing_id: 0x2::object::ID,
    }

    struct StockMetadata has copy, drop, store {
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        solana_mint: vector<u8>,
        decimals: u8,
        is_active: bool,
    }

    struct BackingProof has store, key {
        id: 0x2::object::UID,
        solana_tx_hash: vector<u8>,
        solana_token_mint: vector<u8>,
        amount: u64,
        timestamp: u64,
        user_address: address,
        symbol: 0x1::string::String,
    }

    struct StockRegistry has key {
        id: 0x2::object::UID,
        paused: bool,
        supported_stocks: 0x2::vec_map::VecMap<0x1::string::String, StockMetadata>,
        backing_proofs: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        user_cooldowns: 0x2::table::Table<address, u64>,
        nonce_tracker: 0x2::table::Table<vector<u8>, bool>,
        total_synthetic_supply: u64,
        total_real_backing: u64,
    }

    struct StockMinted has copy, drop {
        token_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        amount: u64,
        recipient: address,
        solana_tx: vector<u8>,
    }

    struct StockBurned has copy, drop {
        token_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        amount: u64,
        burner: address,
    }

    struct StockAdded has copy, drop {
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        solana_mint: vector<u8>,
    }

    struct RegistryPaused has copy, drop {
        paused: bool,
    }

    public entry fun add_supported_stock(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg2)) {
            let v4 = *0x1::vector::borrow<u8>(&arg2, v3);
            0x1::vector::push_back<u8>(&mut v0, v4);
            0x1::vector::push_back<u8>(&mut v1, v4);
            0x1::vector::push_back<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&arg3)) {
            let v8 = *0x1::vector::borrow<u8>(&arg3, v7);
            0x1::vector::push_back<u8>(&mut v5, v8);
            0x1::vector::push_back<u8>(&mut v6, v8);
            v7 = v7 + 1;
        };
        let v9 = 0x1::vector::empty<u8>();
        let v10 = 0x1::vector::empty<u8>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<u8>(&arg4)) {
            let v12 = *0x1::vector::borrow<u8>(&arg4, v11);
            0x1::vector::push_back<u8>(&mut v9, v12);
            0x1::vector::push_back<u8>(&mut v10, v12);
            v11 = v11 + 1;
        };
        let v13 = 0x1::string::utf8(v0);
        assert!(!0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg1.supported_stocks, &v13), 10);
        let v14 = StockMetadata{
            symbol      : 0x1::string::utf8(v1),
            name        : 0x1::string::utf8(v5),
            solana_mint : v9,
            decimals    : arg5,
            is_active   : true,
        };
        0x2::vec_map::insert<0x1::string::String, StockMetadata>(&mut arg1.supported_stocks, v13, v14);
        let v15 = StockAdded{
            symbol      : 0x1::string::utf8(v2),
            name        : 0x1::string::utf8(v6),
            solana_mint : v10,
        };
        0x2::event::emit<StockAdded>(v15);
    }

    public entry fun burn_synthetic_stock(arg0: &mut StockRegistry, arg1: SyntheticStock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::object::id<SyntheticStock>(&arg1);
        let v1 = arg1.amount;
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.backing_proofs, v0)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.backing_proofs, v0);
        };
        assert!(arg0.total_synthetic_supply >= v1, 12);
        assert!(arg0.total_real_backing >= v1, 12);
        arg0.total_synthetic_supply = arg0.total_synthetic_supply - v1;
        arg0.total_real_backing = arg0.total_real_backing - v1;
        let v2 = StockBurned{
            token_id : v0,
            symbol   : arg1.symbol,
            amount   : v1,
            burner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<StockBurned>(v2);
        let SyntheticStock {
            id         : v3,
            symbol     : _,
            amount     : _,
            backing_id : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    public fun get_stock_metadata(arg0: &StockRegistry, arg1: &0x1::string::String) : &StockMetadata {
        0x2::vec_map::get<0x1::string::String, StockMetadata>(&arg0.supported_stocks, arg1)
    }

    public fun get_supplies(arg0: &StockRegistry) : (u64, u64) {
        (arg0.total_synthetic_supply, arg0.total_real_backing)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MinterCap{
            id              : 0x2::object::new(arg0),
            allowed_backend : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<MinterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = StockRegistry{
            id                     : 0x2::object::new(arg0),
            paused                 : false,
            supported_stocks       : 0x2::vec_map::empty<0x1::string::String, StockMetadata>(),
            backing_proofs         : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            user_cooldowns         : 0x2::table::new<address, u64>(arg0),
            nonce_tracker          : 0x2::table::new<vector<u8>, bool>(arg0),
            total_synthetic_supply : 0,
            total_real_backing     : 0,
        };
        0x2::transfer::share_object<StockRegistry>(v2);
    }

    public fun is_paused(arg0: &StockRegistry) : bool {
        arg0.paused
    }

    public fun is_stock_supported(arg0: &StockRegistry, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg0.supported_stocks, arg1)
    }

    public entry fun mint_synthetic_stock(arg0: &MinterCap, arg1: &mut StockRegistry, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(0x2::tx_context::sender(arg8) == arg0.allowed_backend, 2);
        assert!(arg3 > 0, 9);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg2)) {
            let v5 = *0x1::vector::borrow<u8>(&arg2, v4);
            0x1::vector::push_back<u8>(&mut v0, v5);
            0x1::vector::push_back<u8>(&mut v1, v5);
            0x1::vector::push_back<u8>(&mut v2, v5);
            0x1::vector::push_back<u8>(&mut v3, v5);
            v4 = v4 + 1;
        };
        let v6 = 0x1::string::utf8(v0);
        assert!(0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg1.supported_stocks, &v6), 3);
        let v7 = 0x2::vec_map::get<0x1::string::String, StockMetadata>(&arg1.supported_stocks, &v6);
        assert!(v7.is_active, 4);
        assert!(arg5 == v7.solana_mint, 5);
        assert!(arg3 <= 100000000000, 6);
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 0x1::vector::empty<u8>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<u8>(&arg4)) {
            let v11 = *0x1::vector::borrow<u8>(&arg4, v10);
            0x1::vector::push_back<u8>(&mut v8, v11);
            0x1::vector::push_back<u8>(&mut v9, v11);
            v10 = v10 + 1;
        };
        0x1::vector::append<u8>(&mut v8, 0x2::address::to_bytes(arg7));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.nonce_tracker, v8), 8);
        if (0x2::table::contains<address, u64>(&arg1.user_cooldowns, arg7)) {
            assert!(0x2::tx_context::epoch_timestamp_ms(arg8) - *0x2::table::borrow<address, u64>(&arg1.user_cooldowns, arg7) >= 5000, 7);
        };
        if (0x2::table::contains<address, u64>(&arg1.user_cooldowns, arg7)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.user_cooldowns, arg7) = 0x2::tx_context::epoch_timestamp_ms(arg8);
        } else {
            0x2::table::add<address, u64>(&mut arg1.user_cooldowns, arg7, 0x2::tx_context::epoch_timestamp_ms(arg8));
        };
        0x2::table::add<vector<u8>, bool>(&mut arg1.nonce_tracker, v8, true);
        let v12 = BackingProof{
            id                : 0x2::object::new(arg8),
            solana_tx_hash    : arg4,
            solana_token_mint : arg5,
            amount            : arg3,
            timestamp         : arg6,
            user_address      : arg7,
            symbol            : 0x1::string::utf8(v1),
        };
        let v13 = 0x2::object::id<BackingProof>(&v12);
        let v14 = SyntheticStock{
            id         : 0x2::object::new(arg8),
            symbol     : 0x1::string::utf8(v2),
            amount     : arg3,
            backing_id : v13,
        };
        let v15 = 0x2::object::id<SyntheticStock>(&v14);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.backing_proofs, v15, v13);
        let v16 = arg1.total_synthetic_supply + arg3;
        let v17 = arg1.total_real_backing + arg3;
        assert!(v16 >= arg1.total_synthetic_supply, 11);
        assert!(v17 >= arg1.total_real_backing, 11);
        arg1.total_synthetic_supply = v16;
        arg1.total_real_backing = v17;
        0x2::transfer::public_share_object<BackingProof>(v12);
        let v18 = StockMinted{
            token_id  : v15,
            symbol    : 0x1::string::utf8(v3),
            amount    : arg3,
            recipient : arg7,
            solana_tx : v9,
        };
        0x2::event::emit<StockMinted>(v18);
        0x2::transfer::transfer<SyntheticStock>(v14, arg7);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = RegistryPaused{paused: arg2};
        0x2::event::emit<RegistryPaused>(v0);
    }

    public entry fun toggle_stock_status(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg1.supported_stocks, &v0), 3);
        let (_, v2) = 0x2::vec_map::remove<0x1::string::String, StockMetadata>(&mut arg1.supported_stocks, &v0);
        let v3 = v2;
        let v4 = StockMetadata{
            symbol      : v3.symbol,
            name        : v3.name,
            solana_mint : v3.solana_mint,
            decimals    : v3.decimals,
            is_active   : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, StockMetadata>(&mut arg1.supported_stocks, v0, v4);
    }

    public entry fun transfer_minter_cap(arg0: &AdminCap, arg1: MinterCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<MinterCap>(arg1, arg2);
    }

    public entry fun update_minter_backend(arg0: &AdminCap, arg1: &mut MinterCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.allowed_backend = arg2;
    }

    // decompiled from Move bytecode v6
}

