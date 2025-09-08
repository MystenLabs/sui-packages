module 0xba618553d1d8afa41230752d01f6319483abd9ea24ed4ff83c98bfae6023d50e::portal {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        version: u64,
    }

    struct MPCCap has store, key {
        id: 0x2::object::UID,
        mpc_address: address,
        version: u64,
    }

    struct StockRegistry has key {
        id: 0x2::object::UID,
        vault_addresses: vector<address>,
        is_paused: bool,
        whitelisted_tokens: vector<0x1::string::String>,
        stocks: 0x2::table::Table<0x1::string::String, StockInfo>,
        nonce_table: 0x2::table::Table<u128, address>,
        current_admin: address,
        current_mpc: address,
        admin_version: u64,
        mpc_version: u64,
    }

    struct StockInfo has copy, drop, store {
        type_name: 0x1::string::String,
        total_minted: u64,
        total_burned: u64,
    }

    struct WrappedTreasuryCap<phantom T0> has key {
        id: 0x2::object::UID,
        authority: address,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct StockRegistered has copy, drop {
        stock_code: 0x1::string::String,
        type_name: 0x1::string::String,
        wrapped_treasury_cap: address,
    }

    struct StockUnregistered has copy, drop {
        stock_code: 0x1::string::String,
    }

    struct StockMinted has copy, drop {
        stock_code: 0x1::string::String,
        to: address,
        amount: u64,
        nonce: u128,
    }

    struct DepositReceived has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
        from: address,
    }

    struct VaultAdded has copy, drop {
        vault_address: address,
    }

    struct VaultRemoved has copy, drop {
        vault_address: address,
    }

    struct StockBurned has copy, drop {
        stock_code: 0x1::string::String,
        amount: u64,
        from: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        new_version: u64,
    }

    struct WhitelistedTokenAdded has copy, drop {
        token_type: 0x1::string::String,
    }

    struct WhitelistedTokenRemoved has copy, drop {
        token_type: 0x1::string::String,
    }

    struct ContractPaused has copy, drop {
        admin: address,
    }

    struct ContractUnpaused has copy, drop {
        admin: address,
    }

    struct MPCTransferred has copy, drop {
        from: address,
        to: address,
        new_version: u64,
    }

    public fun add_vault(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        verify_admin_cap(arg0, arg1, arg3);
        assert!(arg2 != @0x0, 8);
        assert!(0x1::vector::length<address>(&arg1.vault_addresses) < 10, 5);
        assert!(!vault_address_exists(&arg1.vault_addresses, arg2), 7);
        0x1::vector::push_back<address>(&mut arg1.vault_addresses, arg2);
        let v0 = VaultAdded{vault_address: arg2};
        0x2::event::emit<VaultAdded>(v0);
    }

    public fun add_whitelisted_token<T0: drop>(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: &0x2::tx_context::TxContext) {
        verify_admin_cap(arg0, arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)));
        assert!(!is_token_whitelisted(arg1, &v1), 12);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.whitelisted_tokens, v1);
        let v2 = WhitelistedTokenAdded{token_type: v1};
        0x2::event::emit<WhitelistedTokenAdded>(v2);
    }

    fun assert_not_paused(arg0: &StockRegistry) {
        assert!(!arg0.is_paused, 10);
    }

    public fun burn_stock<T0: drop>(arg0: &mut StockRegistry, arg1: &mut WrappedTreasuryCap<T0>, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, v0), 3);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, StockInfo>(&mut arg0.stocks, v0);
        let v2 = 0x2::coin::value<T0>(&arg3);
        0x2::coin::burn<T0>(&mut arg1.cap, arg3);
        v1.total_burned = v1.total_burned + v2;
        let v3 = StockBurned{
            stock_code : v0,
            amount     : v2,
            from       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StockBurned>(v3);
    }

    public fun deposit<T0>(arg0: &mut StockRegistry, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        assert!(arg2 < 0x1::vector::length<address>(&arg0.vault_addresses), 6);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v1)));
        assert!(is_token_whitelisted(arg0, &v2), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::vector::borrow<address>(&arg0.vault_addresses, arg2));
        let v3 = DepositReceived{
            coin_type : v2,
            amount    : v0,
            from      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositReceived>(v3);
    }

    fun find_vault_index(arg0: &vector<address>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x1::vector::length<address>(arg0)
    }

    public fun get_current_admin(arg0: &StockRegistry) : address {
        arg0.current_admin
    }

    public fun get_current_mpc(arg0: &StockRegistry) : address {
        arg0.current_mpc
    }

    public fun get_order_recipient(arg0: &StockRegistry, arg1: u128) : address {
        assert!(0x2::table::contains<u128, address>(&arg0.nonce_table, arg1), 14);
        *0x2::table::borrow<u128, address>(&arg0.nonce_table, arg1)
    }

    public fun get_stock_count(arg0: &StockRegistry) : u64 {
        0x2::table::length<0x1::string::String, StockInfo>(&arg0.stocks)
    }

    public fun get_stock_info(arg0: &StockRegistry, arg1: vector<u8>) : (0x1::string::String, u64, u64, u64) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, v0), 3);
        let v1 = 0x2::table::borrow<0x1::string::String, StockInfo>(&arg0.stocks, v0);
        (v1.type_name, v1.total_minted, v1.total_burned, v1.total_minted - v1.total_burned)
    }

    public fun get_stock_stats(arg0: &StockRegistry, arg1: vector<u8>) : (u64, u64) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, v0), 3);
        let v1 = 0x2::table::borrow<0x1::string::String, StockInfo>(&arg0.stocks, v0);
        (v1.total_minted, v1.total_burned)
    }

    public fun get_vault_addresses(arg0: &StockRegistry) : vector<address> {
        arg0.vault_addresses
    }

    public fun get_vault_count(arg0: &StockRegistry) : u64 {
        0x1::vector::length<address>(&arg0.vault_addresses)
    }

    public fun get_whitelisted_tokens(arg0: &StockRegistry) : vector<0x1::string::String> {
        arg0.whitelisted_tokens
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0);
    }

    fun init_internal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id            : 0x2::object::new(arg0),
            admin_address : @0x1edc108fff0653430f322528e21046ddd1e4ee52638d4f0ebc7f1251bd5e14eb,
            version       : 1,
        };
        let v1 = MPCCap{
            id          : 0x2::object::new(arg0),
            mpc_address : @0x143a4d05c53a73d0f3b6229e9fa02b77f3a43056c9c4643e4a76135380decc7b,
            version     : 1,
        };
        let v2 = StockRegistry{
            id                 : 0x2::object::new(arg0),
            vault_addresses    : 0x1::vector::empty<address>(),
            is_paused          : false,
            whitelisted_tokens : 0x1::vector::empty<0x1::string::String>(),
            stocks             : 0x2::table::new<0x1::string::String, StockInfo>(arg0),
            nonce_table        : 0x2::table::new<u128, address>(arg0),
            current_admin      : @0x1edc108fff0653430f322528e21046ddd1e4ee52638d4f0ebc7f1251bd5e14eb,
            current_mpc        : @0x143a4d05c53a73d0f3b6229e9fa02b77f3a43056c9c4643e4a76135380decc7b,
            admin_version      : 1,
            mpc_version        : 1,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, @0x1edc108fff0653430f322528e21046ddd1e4ee52638d4f0ebc7f1251bd5e14eb);
        0x2::transfer::public_transfer<MPCCap>(v1, @0x143a4d05c53a73d0f3b6229e9fa02b77f3a43056c9c4643e4a76135380decc7b);
        0x2::transfer::share_object<StockRegistry>(v2);
    }

    public fun is_paused(arg0: &StockRegistry) : bool {
        arg0.is_paused
    }

    fun is_token_whitelisted(arg0: &StockRegistry, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.whitelisted_tokens, arg1)
    }

    public fun is_token_whitelisted_public<T0>(arg0: &StockRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)));
        is_token_whitelisted(arg0, &v1)
    }

    public fun is_vault_address(arg0: &StockRegistry, arg1: address) : bool {
        find_vault_index(&arg0.vault_addresses, arg1) != 0x1::vector::length<address>(&arg0.vault_addresses)
    }

    public fun mint_stock<T0: drop>(arg0: &MPCCap, arg1: &mut StockRegistry, arg2: &mut WrappedTreasuryCap<T0>, arg3: vector<u8>, arg4: u64, arg5: address, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        verify_mpc_cap(arg0, arg1, arg7);
        assert!(0x2::tx_context::sender(arg7) == arg2.authority, 1);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::table::contains<0x1::string::String, StockInfo>(&arg1.stocks, v0), 3);
        assert!(arg4 > 0, 4);
        assert!(arg5 != @0x0, 8);
        assert!(!0x2::table::contains<u128, address>(&arg1.nonce_table, arg6), 17);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, StockInfo>(&mut arg1.stocks, v0);
        v1.total_minted = v1.total_minted + arg4;
        0x2::table::add<u128, address>(&mut arg1.nonce_table, arg6, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg2.cap, arg4, arg7), arg5);
        let v2 = StockMinted{
            stock_code : v0,
            to         : arg5,
            amount     : arg4,
            nonce      : arg6,
        };
        0x2::event::emit<StockMinted>(v2);
    }

    public fun mpc_transfer_ownership<T0: drop>(arg0: MPCCap, arg1: &mut StockRegistry, arg2: &mut WrappedTreasuryCap<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        verify_mpc_cap(&arg0, arg1, arg4);
        assert!(arg3 != @0x0, 8);
        assert!(arg3 != arg0.mpc_address, 9);
        arg1.current_mpc = arg3;
        arg1.mpc_version = arg1.mpc_version + 1;
        arg2.authority = arg3;
        let v0 = MPCCap{
            id          : 0x2::object::new(arg4),
            mpc_address : arg3,
            version     : arg1.mpc_version,
        };
        0x2::transfer::public_transfer<MPCCap>(v0, arg3);
        let MPCCap {
            id          : v1,
            mpc_address : _,
            version     : _,
        } = arg0;
        0x2::object::delete(v1);
        let v4 = MPCTransferred{
            from        : arg0.mpc_address,
            to          : arg3,
            new_version : arg1.mpc_version,
        };
        0x2::event::emit<MPCTransferred>(v4);
    }

    public fun order_exists(arg0: &StockRegistry, arg1: u128) : bool {
        0x2::table::contains<u128, address>(&arg0.nonce_table, arg1)
    }

    public fun pause_contract(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: &0x2::tx_context::TxContext) {
        verify_admin_cap(arg0, arg1, arg2);
        assert!(!arg1.is_paused, 10);
        arg1.is_paused = true;
        let v0 = ContractPaused{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ContractPaused>(v0);
    }

    fun register_internal<T0: drop>(arg0: &mut StockRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v1)));
        assert!(!0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, v0), 2);
        let v3 = StockInfo{
            type_name    : v2,
            total_minted : 0,
            total_burned : 0,
        };
        0x2::table::add<0x1::string::String, StockInfo>(&mut arg0.stocks, v0, v3);
        let v4 = WrappedTreasuryCap<T0>{
            id        : 0x2::object::new(arg3),
            authority : arg0.current_mpc,
            cap       : arg1,
        };
        let v5 = 0x2::object::id<WrappedTreasuryCap<T0>>(&v4);
        0x2::transfer::share_object<WrappedTreasuryCap<T0>>(v4);
        let v6 = StockRegistered{
            stock_code           : v0,
            type_name            : v2,
            wrapped_treasury_cap : 0x2::object::id_to_address(&v5),
        };
        0x2::event::emit<StockRegistered>(v6);
    }

    public fun register_stock<T0: drop>(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        verify_admin_cap(arg0, arg1, arg4);
        register_internal<T0>(arg1, arg2, arg3, arg4);
    }

    public fun remove_vault(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        verify_admin_cap(arg0, arg1, arg3);
        assert!(arg2 != @0x0, 8);
        let v0 = find_vault_index(&arg1.vault_addresses, arg2);
        assert!(v0 != 0x1::vector::length<address>(&arg1.vault_addresses), 6);
        0x1::vector::remove<address>(&mut arg1.vault_addresses, v0);
        let v1 = VaultRemoved{vault_address: arg2};
        0x2::event::emit<VaultRemoved>(v1);
    }

    public fun remove_whitelisted_token<T0: drop>(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: &0x2::tx_context::TxContext) {
        verify_admin_cap(arg0, arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)));
        assert!(is_token_whitelisted(arg1, &v1), 11);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg1.whitelisted_tokens)) {
            if (*0x1::vector::borrow<0x1::string::String>(&arg1.whitelisted_tokens, v2) == v1) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.whitelisted_tokens, v2);
                break
            };
            v2 = v2 + 1;
        };
        let v3 = WhitelistedTokenRemoved{token_type: v1};
        0x2::event::emit<WhitelistedTokenRemoved>(v3);
    }

    public fun stock_exists(arg0: &StockRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, 0x1::string::utf8(arg1))
    }

    public fun transfer_admin(arg0: AdminCap, arg1: &mut StockRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 1);
        assert!(arg0.admin_address == arg1.current_admin, 16);
        assert!(arg0.version == arg1.admin_version, 16);
        assert!(arg2 != @0x0, 8);
        assert!(arg2 != arg0.admin_address, 9);
        arg1.current_admin = arg2;
        arg1.admin_version = arg1.admin_version + 1;
        let v0 = AdminCap{
            id            : 0x2::object::new(arg3),
            admin_address : arg2,
            version       : arg1.admin_version,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        let AdminCap {
            id            : v1,
            admin_address : _,
            version       : _,
        } = arg0;
        0x2::object::delete(v1);
        let v4 = AdminTransferred{
            old_admin   : arg0.admin_address,
            new_admin   : arg2,
            new_version : arg1.admin_version,
        };
        0x2::event::emit<AdminTransferred>(v4);
    }

    public fun unpause_contract(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: &0x2::tx_context::TxContext) {
        verify_admin_cap(arg0, arg1, arg2);
        assert!(arg1.is_paused, 15);
        arg1.is_paused = false;
        let v0 = ContractUnpaused{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ContractUnpaused>(v0);
    }

    fun unregister_internal(arg0: &mut StockRegistry, arg1: vector<u8>, arg2: 0x1::string::String) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, StockInfo>(&arg0.stocks, v0), 3);
        let v1 = 0x2::table::remove<0x1::string::String, StockInfo>(&mut arg0.stocks, v0);
        assert!(v1.type_name == arg2, 13);
        let v2 = StockUnregistered{stock_code: v0};
        0x2::event::emit<StockUnregistered>(v2);
    }

    public fun unregister_stock<T0: drop>(arg0: &AdminCap, arg1: &mut StockRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        verify_admin_cap(arg0, arg1, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        unregister_internal(arg1, arg2, 0x1::string::utf8(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v0))));
    }

    fun vault_address_exists(arg0: &vector<address>, arg1: address) : bool {
        find_vault_index(arg0, arg1) != 0x1::vector::length<address>(arg0)
    }

    fun verify_admin_cap(arg0: &AdminCap, arg1: &StockRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1);
        assert!(arg0.admin_address == arg1.current_admin, 16);
        assert!(arg0.version == arg1.admin_version, 16);
    }

    fun verify_mpc_cap(arg0: &MPCCap, arg1: &StockRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.mpc_address, 1);
        assert!(arg0.mpc_address == arg1.current_mpc, 16);
        assert!(arg0.version == arg1.mpc_version, 16);
    }

    // decompiled from Move bytecode v6
}

