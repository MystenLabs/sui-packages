module 0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::token_sale {
    struct SaleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenSale has key {
        id: 0x2::object::UID,
        tokens_for_sale: 0x2::balance::Balance<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>,
        tokens_remaining: u64,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        total_sui_raised: u64,
        sale_active: bool,
        sold_out: bool,
        liquidity_added: bool,
        distribution_unlock_time: u64,
        total_purchases: u64,
        purchases: 0x2::table::Table<address, PurchaseInfo>,
        treasury_wallet: address,
    }

    struct PurchaseInfo has drop, store {
        purchase_count: u64,
        tokens_purchased: u64,
        claimed: bool,
    }

    struct SaleWhitelist has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
        enabled: bool,
    }

    struct SalePhaseConfig has key {
        id: 0x2::object::UID,
        whitelist_phase_active: bool,
        public_phase_active: bool,
        whitelist_start_time: u64,
        whitelist_tokens_remaining: u64,
        public_tokens_remaining: u64,
        whitelist_purchases: 0x2::table::Table<address, bool>,
        public_purchases: 0x2::table::Table<address, bool>,
    }

    struct InitTracker has key {
        id: 0x2::object::UID,
        whitelist_initialized: bool,
        phase_config_initialized: bool,
    }

    struct SaleInitialized has copy, drop {
        total_tokens: u64,
        price_per_100k: u64,
    }

    struct TokensDeposited has copy, drop {
        amount: u64,
        total_deposited: u64,
    }

    struct SaleStarted has copy, drop {
        start_time: u64,
    }

    struct TokensPurchased has copy, drop {
        buyer: address,
        sui_amount: u64,
        tokens_amount: u64,
        purchase_number: u64,
        tokens_remaining: u64,
    }

    struct SaleSoldOut has copy, drop {
        total_sui_raised: u64,
        total_purchases: u64,
    }

    struct LiquidityMarkedAdded has copy, drop {
        distribution_unlock_time: u64,
    }

    struct SuiWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokensClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    struct WhitelistInitialized has copy, drop {
        enabled: bool,
    }

    struct BatchWhitelistAdded has copy, drop {
        count: u64,
    }

    struct PhaseConfigInitialized has copy, drop {
        whitelist_tokens: u64,
        public_tokens: u64,
    }

    struct WhitelistPhaseStarted has copy, drop {
        start_time: u64,
        tokens_available: u64,
    }

    struct WhitelistPhaseEnded has copy, drop {
        end_time: u64,
        tokens_sold: u64,
        tokens_transferred_to_public: u64,
    }

    struct PublicPhaseStarted has copy, drop {
        start_time: u64,
        tokens_available: u64,
    }

    struct InitTrackerCreated has copy, drop {
        created: bool,
    }

    public entry fun batch_add_whitelist(arg0: &SaleAdminCap, arg1: &mut SaleWhitelist, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::table::contains<address, bool>(&arg1.whitelist, v2)) {
                0x2::table::remove<address, bool>(&mut arg1.whitelist, v2);
            };
            0x2::table::add<address, bool>(&mut arg1.whitelist, v2, true);
            v1 = v1 + 1;
        };
        let v3 = BatchWhitelistAdded{count: v0};
        0x2::event::emit<BatchWhitelistAdded>(v3);
    }

    public fun can_claim(arg0: &TokenSale, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.liquidity_added) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg2) < arg0.distribution_unlock_time) {
            return false
        };
        if (!0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, PurchaseInfo>(&arg0.purchases, arg1);
        !v0.claimed && v0.tokens_purchased > 0
    }

    public fun can_purchase(arg0: &TokenSale, arg1: address) : bool {
        arg0.sale_active && !arg0.sold_out
    }

    public fun can_purchase_public(arg0: &SalePhaseConfig, arg1: address) : bool {
        if (!arg0.public_phase_active) {
            return false
        };
        if (0x2::table::contains<address, bool>(&arg0.public_purchases, arg1)) {
            return false
        };
        arg0.public_tokens_remaining >= 100000000000000
    }

    public fun can_purchase_whitelist(arg0: &SaleWhitelist, arg1: &SalePhaseConfig, arg2: address) : bool {
        if (!arg1.whitelist_phase_active) {
            return false
        };
        if (!0x2::table::contains<address, bool>(&arg0.whitelist, arg2) || !*0x2::table::borrow<address, bool>(&arg0.whitelist, arg2)) {
            return false
        };
        if (0x2::table::contains<address, bool>(&arg1.whitelist_purchases, arg2)) {
            return false
        };
        arg1.whitelist_tokens_remaining >= 100000000000000
    }

    public entry fun claim_tokens(arg0: &mut TokenSale, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.liquidity_added, 10);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.distribution_unlock_time, 6);
        assert!(0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, PurchaseInfo>(&mut arg0.purchases, v0);
        assert!(!v1.claimed, 8);
        assert!(v1.tokens_purchased > 0, 7);
        let v2 = v1.tokens_purchased;
        v1.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>>(0x2::coin::from_balance<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(0x2::balance::split<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(&mut arg0.tokens_for_sale, v2), arg2), v0);
        let v3 = TokensClaimed{
            claimer : v0,
            amount  : v2,
        };
        0x2::event::emit<TokensClaimed>(v3);
    }

    public entry fun create_init_tracker(arg0: &SaleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitTracker{
            id                       : 0x2::object::new(arg1),
            whitelist_initialized    : false,
            phase_config_initialized : false,
        };
        0x2::transfer::share_object<InitTracker>(v0);
        let v1 = InitTrackerCreated{created: true};
        0x2::event::emit<InitTrackerCreated>(v1);
    }

    public entry fun deposit_tokens(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: 0x2::coin::Coin<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>) {
        0x2::balance::join<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(&mut arg1.tokens_for_sale, 0x2::coin::into_balance<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(arg2));
        arg1.tokens_remaining = 0x2::balance::value<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(&arg1.tokens_for_sale);
        let v0 = TokensDeposited{
            amount          : 0x2::coin::value<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(&arg2),
            total_deposited : arg1.tokens_remaining,
        };
        0x2::event::emit<TokensDeposited>(v0);
    }

    public entry fun end_sale_early(arg0: &SaleAdminCap, arg1: &mut TokenSale) {
        arg1.sale_active = false;
        arg1.sold_out = true;
        let v0 = SaleSoldOut{
            total_sui_raised : arg1.total_sui_raised,
            total_purchases  : arg1.total_purchases,
        };
        0x2::event::emit<SaleSoldOut>(v0);
    }

    public fun get_phase_constants() : (u64, u64, u64) {
        (38000000000000000, 2000000000000000, 300000)
    }

    public fun get_phase_status(arg0: &SalePhaseConfig, arg1: &0x2::clock::Clock) : (bool, bool, u64, u64, u64) {
        let v0 = if (arg0.whitelist_phase_active) {
            let v1 = arg0.whitelist_start_time + 300000;
            let v2 = 0x2::clock::timestamp_ms(arg1);
            if (v2 >= v1) {
                0
            } else {
                v1 - v2
            }
        } else {
            0
        };
        (arg0.whitelist_phase_active, arg0.public_phase_active, arg0.whitelist_tokens_remaining, arg0.public_tokens_remaining, v0)
    }

    public fun get_purchase_info(arg0: &TokenSale, arg1: address) : (u64, u64, bool) {
        if (0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, arg1)) {
            let v3 = 0x2::table::borrow<address, PurchaseInfo>(&arg0.purchases, arg1);
            (v3.purchase_count, v3.tokens_purchased, v3.claimed)
        } else {
            (0, 0, false)
        }
    }

    public fun get_sale_constants() : (u64, u64, u64, u64, u64) {
        (100000000000000, 10000000000, 1, 40000000000000000, 400)
    }

    public fun get_sale_status(arg0: &TokenSale) : (u64, u64, u64, bool, bool, bool, u64) {
        (arg0.tokens_remaining, arg0.total_sui_raised, arg0.total_purchases, arg0.sale_active, arg0.sold_out, arg0.liquidity_added, arg0.distribution_unlock_time)
    }

    public fun get_time_until_distribution(arg0: &TokenSale, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.liquidity_added) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.distribution_unlock_time) {
            0
        } else {
            arg0.distribution_unlock_time - v0
        }
    }

    public fun get_whitelist_status(arg0: &SaleWhitelist) : bool {
        arg0.enabled
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SaleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SaleAdminCap>(v1, v0);
        let v2 = TokenSale{
            id                       : 0x2::object::new(arg0),
            tokens_for_sale          : 0x2::balance::zero<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(),
            tokens_remaining         : 0,
            sui_raised               : 0x2::balance::zero<0x2::sui::SUI>(),
            total_sui_raised         : 0,
            sale_active              : false,
            sold_out                 : false,
            liquidity_added          : false,
            distribution_unlock_time : 0,
            total_purchases          : 0,
            purchases                : 0x2::table::new<address, PurchaseInfo>(arg0),
            treasury_wallet          : v0,
        };
        0x2::transfer::share_object<TokenSale>(v2);
        let v3 = SaleInitialized{
            total_tokens   : 40000000000000000,
            price_per_100k : 10000000000,
        };
        0x2::event::emit<SaleInitialized>(v3);
    }

    public entry fun initialize_phase_config(arg0: &SaleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SalePhaseConfig{
            id                         : 0x2::object::new(arg1),
            whitelist_phase_active     : false,
            public_phase_active        : false,
            whitelist_start_time       : 0,
            whitelist_tokens_remaining : 38000000000000000,
            public_tokens_remaining    : 2000000000000000,
            whitelist_purchases        : 0x2::table::new<address, bool>(arg1),
            public_purchases           : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<SalePhaseConfig>(v0);
        let v1 = PhaseConfigInitialized{
            whitelist_tokens : 38000000000000000,
            public_tokens    : 2000000000000000,
        };
        0x2::event::emit<PhaseConfigInitialized>(v1);
    }

    public entry fun initialize_phase_config_v2(arg0: &SaleAdminCap, arg1: &mut InitTracker, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.phase_config_initialized, 19);
        let v0 = SalePhaseConfig{
            id                         : 0x2::object::new(arg2),
            whitelist_phase_active     : false,
            public_phase_active        : false,
            whitelist_start_time       : 0,
            whitelist_tokens_remaining : 38000000000000000,
            public_tokens_remaining    : 2000000000000000,
            whitelist_purchases        : 0x2::table::new<address, bool>(arg2),
            public_purchases           : 0x2::table::new<address, bool>(arg2),
        };
        0x2::transfer::share_object<SalePhaseConfig>(v0);
        arg1.phase_config_initialized = true;
        let v1 = PhaseConfigInitialized{
            whitelist_tokens : 38000000000000000,
            public_tokens    : 2000000000000000,
        };
        0x2::event::emit<PhaseConfigInitialized>(v1);
    }

    public entry fun initialize_whitelist(arg0: &SaleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SaleWhitelist{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::table::new<address, bool>(arg1),
            enabled   : true,
        };
        0x2::transfer::share_object<SaleWhitelist>(v0);
        let v1 = WhitelistInitialized{enabled: true};
        0x2::event::emit<WhitelistInitialized>(v1);
    }

    public entry fun initialize_whitelist_v2(arg0: &SaleAdminCap, arg1: &mut InitTracker, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.whitelist_initialized, 19);
        let v0 = SaleWhitelist{
            id        : 0x2::object::new(arg2),
            whitelist : 0x2::table::new<address, bool>(arg2),
            enabled   : true,
        };
        0x2::transfer::share_object<SaleWhitelist>(v0);
        arg1.whitelist_initialized = true;
        let v1 = WhitelistInitialized{enabled: true};
        0x2::event::emit<WhitelistInitialized>(v1);
    }

    public fun is_whitelisted(arg0: &SaleWhitelist, arg1: address) : bool {
        if (!arg0.enabled) {
            return true
        };
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelist, arg1) == true
    }

    public entry fun mark_liquidity_added(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.sold_out, 9);
        assert!(!arg1.liquidity_added, 13);
        arg1.liquidity_added = true;
        arg1.distribution_unlock_time = 0x2::clock::timestamp_ms(arg2) + 60000;
        let v0 = LiquidityMarkedAdded{distribution_unlock_time: arg1.distribution_unlock_time};
        0x2::event::emit<LiquidityMarkedAdded>(v0);
    }

    public entry fun purchase(arg0: &mut TokenSale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public entry fun purchase_v2(arg0: &mut TokenSale, arg1: &mut SaleWhitelist, arg2: &mut SalePhaseConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.sale_active, 1);
        assert!(!arg0.sold_out, 4);
        if (arg2.whitelist_phase_active) {
            if (0x2::clock::timestamp_ms(arg4) >= arg2.whitelist_start_time + 300000) {
                transition_to_public_phase(arg2, arg4);
            };
        };
        assert!(arg2.whitelist_phase_active || arg2.public_phase_active, 18);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 10000000000, 3);
        if (v1 > 10000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - 10000000000, arg5), v0);
        };
        if (arg2.whitelist_phase_active) {
            assert!(0x2::table::contains<address, bool>(&arg1.whitelist, v0) && *0x2::table::borrow<address, bool>(&arg1.whitelist, v0) == true, 14);
            assert!(!0x2::table::contains<address, bool>(&arg2.whitelist_purchases, v0), 17);
            assert!(arg2.whitelist_tokens_remaining >= 100000000000000, 4);
            0x2::table::add<address, bool>(&mut arg2.whitelist_purchases, v0, true);
            arg2.whitelist_tokens_remaining = arg2.whitelist_tokens_remaining - 100000000000000;
            if (arg2.whitelist_tokens_remaining == 0) {
                transition_to_public_phase(arg2, arg4);
            };
        } else {
            assert!(!0x2::table::contains<address, bool>(&arg2.public_purchases, v0), 17);
            assert!(arg2.public_tokens_remaining >= 100000000000000, 4);
            0x2::table::add<address, bool>(&mut arg2.public_purchases, v0, true);
            arg2.public_tokens_remaining = arg2.public_tokens_remaining - 100000000000000;
            if (arg2.public_tokens_remaining == 0) {
                arg0.sold_out = true;
                arg0.sale_active = false;
                arg2.public_phase_active = false;
                let v2 = SaleSoldOut{
                    total_sui_raised : arg0.total_sui_raised + 10000000000,
                    total_purchases  : arg0.total_purchases + 1,
                };
                0x2::event::emit<SaleSoldOut>(v2);
            };
        };
        if (!0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, v0)) {
            let v3 = PurchaseInfo{
                purchase_count   : 0,
                tokens_purchased : 0,
                claimed          : false,
            };
            0x2::table::add<address, PurchaseInfo>(&mut arg0.purchases, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, PurchaseInfo>(&mut arg0.purchases, v0);
        v4.purchase_count = v4.purchase_count + 1;
        v4.tokens_purchased = v4.tokens_purchased + 100000000000000;
        arg0.tokens_remaining = arg0.tokens_remaining - 100000000000000;
        arg0.total_sui_raised = arg0.total_sui_raised + 10000000000;
        arg0.total_purchases = arg0.total_purchases + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v5 = TokensPurchased{
            buyer            : v0,
            sui_amount       : 10000000000,
            tokens_amount    : 100000000000000,
            purchase_number  : v4.purchase_count,
            tokens_remaining : arg0.tokens_remaining,
        };
        0x2::event::emit<TokensPurchased>(v5);
    }

    public entry fun set_treasury_wallet(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: address) {
        arg1.treasury_wallet = arg2;
    }

    public entry fun set_whitelist_enabled(arg0: &SaleAdminCap, arg1: &mut SaleWhitelist, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun start_sale(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(!arg1.sale_active, 12);
        assert!(arg1.tokens_remaining >= 40000000000000000, 11);
        arg1.sale_active = true;
        let v0 = SaleStarted{start_time: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<SaleStarted>(v0);
    }

    public entry fun start_whitelist_phase(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &mut SalePhaseConfig, arg3: &0x2::clock::Clock) {
        assert!(arg1.sale_active, 1);
        assert!(!arg2.whitelist_phase_active, 12);
        assert!(!arg2.public_phase_active, 12);
        arg2.whitelist_phase_active = true;
        arg2.whitelist_start_time = 0x2::clock::timestamp_ms(arg3);
        let v0 = WhitelistPhaseStarted{
            start_time       : arg2.whitelist_start_time,
            tokens_available : arg2.whitelist_tokens_remaining,
        };
        0x2::event::emit<WhitelistPhaseStarted>(v0);
    }

    fun transition_to_public_phase(arg0: &mut SalePhaseConfig, arg1: &0x2::clock::Clock) {
        let v0 = arg0.whitelist_tokens_remaining;
        arg0.public_tokens_remaining = arg0.public_tokens_remaining + v0;
        arg0.whitelist_tokens_remaining = 0;
        arg0.whitelist_phase_active = false;
        arg0.public_phase_active = true;
        let v1 = WhitelistPhaseEnded{
            end_time                     : 0x2::clock::timestamp_ms(arg1),
            tokens_sold                  : 38000000000000000 - arg0.whitelist_tokens_remaining,
            tokens_transferred_to_public : v0,
        };
        0x2::event::emit<WhitelistPhaseEnded>(v1);
        let v2 = PublicPhaseStarted{
            start_time       : 0x2::clock::timestamp_ms(arg1),
            tokens_available : arg0.public_tokens_remaining,
        };
        0x2::event::emit<PublicPhaseStarted>(v2);
    }

    public entry fun withdraw_sui(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_raised);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_raised), arg2), arg1.treasury_wallet);
            let v1 = SuiWithdrawn{
                amount    : v0,
                recipient : arg1.treasury_wallet,
            };
            0x2::event::emit<SuiWithdrawn>(v1);
        };
    }

    public entry fun withdraw_unsold_tokens(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sold_out, 9);
        let v0 = arg1.tokens_remaining;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>>(0x2::coin::from_balance<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(0x2::balance::split<0xeff00d5f2df5a59e7e41dbf14f462c148ef1a25b4d615d7c1e7008125d13daa0::shttoken::SHTTOKEN>(&mut arg1.tokens_for_sale, v0), arg2), arg1.treasury_wallet);
            arg1.tokens_remaining = 0;
        };
    }

    // decompiled from Move bytecode v6
}

