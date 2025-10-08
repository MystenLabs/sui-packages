module 0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
        allowed_backend: address,
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
        backing_proofs: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        nonce_tracker: 0x2::table::Table<vector<u8>, bool>,
        total_synthetic_supply: u64,
        total_real_backing: u64,
    }

    struct StockMinted has copy, drop {
        symbol: 0x1::string::String,
        amount: u64,
        recipient: address,
        solana_tx: vector<u8>,
    }

    struct StockBurned has copy, drop {
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
        let v0 = 0x1::string::utf8(arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg1.supported_stocks, &v0), 9);
        let v1 = StockMetadata{
            symbol      : v0,
            name        : 0x1::string::utf8(arg3),
            solana_mint : arg4,
            decimals    : arg5,
            is_active   : true,
        };
        0x2::vec_map::insert<0x1::string::String, StockMetadata>(&mut arg1.supported_stocks, v0, v1);
        let v2 = StockAdded{
            symbol      : v0,
            name        : 0x1::string::utf8(arg3),
            solana_mint : arg4,
        };
        0x2::event::emit<StockAdded>(v2);
    }

    public fun emit_burn_event(arg0: 0x1::string::String, arg1: u64, arg2: address) {
        let v0 = StockBurned{
            symbol : arg0,
            amount : arg1,
            burner : arg2,
        };
        0x2::event::emit<StockBurned>(v0);
    }

    public fun emit_mint_event(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: vector<u8>) {
        let v0 = StockMinted{
            symbol    : arg0,
            amount    : arg1,
            recipient : arg2,
            solana_tx : arg3,
        };
        0x2::event::emit<StockMinted>(v0);
    }

    public fun get_stock_metadata(arg0: &StockRegistry, arg1: &0x1::string::String) : &StockMetadata {
        0x2::vec_map::get<0x1::string::String, StockMetadata>(&arg0.supported_stocks, arg1)
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
            backing_proofs         : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
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

    public fun record_backing_proof(arg0: &mut StockRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg4));
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v0)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v3));
            v3 = v3 + 1;
        };
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.nonce_tracker, v2), 7);
        0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_tracker, v0, true);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&arg1, v5));
            v5 = v5 + 1;
        };
        let v6 = BackingProof{
            id                : 0x2::object::new(arg6),
            solana_tx_hash    : arg1,
            solana_token_mint : arg2,
            amount            : arg3,
            timestamp         : 0x2::tx_context::epoch(arg6),
            user_address      : arg4,
            symbol            : arg5,
        };
        let v7 = 0x2::object::id<BackingProof>(&v6);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.backing_proofs, v4, v7);
        0x2::transfer::public_transfer<BackingProof>(v6, arg4);
        v7
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = RegistryPaused{paused: arg2};
        0x2::event::emit<RegistryPaused>(v0);
    }

    public entry fun update_minter_backend(arg0: &AdminCap, arg1: &mut MinterCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.allowed_backend = arg2;
    }

    public fun update_supply(arg0: &mut StockRegistry, arg1: u64, arg2: bool) {
        if (arg2) {
            let v0 = (arg0.total_synthetic_supply as u128) + (arg1 as u128);
            assert!(v0 <= 18446744073709551615, 10);
            arg0.total_synthetic_supply = (v0 as u64);
            let v1 = (arg0.total_real_backing as u128) + (arg1 as u128);
            assert!(v1 <= 18446744073709551615, 10);
            arg0.total_real_backing = (v1 as u64);
        } else {
            assert!(arg0.total_synthetic_supply >= arg1, 11);
            arg0.total_synthetic_supply = arg0.total_synthetic_supply - arg1;
            assert!(arg0.total_real_backing >= arg1, 11);
            arg0.total_real_backing = arg0.total_real_backing - arg1;
        };
    }

    public fun verify_mint_authorization(arg0: &MinterCap, arg1: &StockRegistry, arg2: &0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.allowed_backend, 2);
        assert!(0x2::vec_map::contains<0x1::string::String, StockMetadata>(&arg1.supported_stocks, arg2), 3);
        assert!(0x2::vec_map::get<0x1::string::String, StockMetadata>(&arg1.supported_stocks, arg2).is_active, 4);
    }

    // decompiled from Move bytecode v6
}

