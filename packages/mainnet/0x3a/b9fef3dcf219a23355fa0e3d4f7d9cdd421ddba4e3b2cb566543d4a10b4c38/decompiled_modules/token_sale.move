module 0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::token_sale {
    struct SaleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenSale has key {
        id: 0x2::object::UID,
        tokens_for_sale: 0x2::balance::Balance<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>,
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
        if (!arg0.sale_active || arg0.sold_out) {
            return false
        };
        if (!0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, arg1)) {
            return true
        };
        0x2::table::borrow<address, PurchaseInfo>(&arg0.purchases, arg1).purchase_count < 2
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>>(0x2::coin::from_balance<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(0x2::balance::split<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&mut arg0.tokens_for_sale, v2), arg2), v0);
        let v3 = TokensClaimed{
            claimer : v0,
            amount  : v2,
        };
        0x2::event::emit<TokensClaimed>(v3);
    }

    public entry fun deposit_tokens(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: 0x2::coin::Coin<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>) {
        0x2::balance::join<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&mut arg1.tokens_for_sale, 0x2::coin::into_balance<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(arg2));
        arg1.tokens_remaining = 0x2::balance::value<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&arg1.tokens_for_sale);
        let v0 = TokensDeposited{
            amount          : 0x2::coin::value<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&arg2),
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

    public fun get_purchase_info(arg0: &TokenSale, arg1: address) : (u64, u64, bool) {
        if (0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, arg1)) {
            let v3 = 0x2::table::borrow<address, PurchaseInfo>(&arg0.purchases, arg1);
            (v3.purchase_count, v3.tokens_purchased, v3.claimed)
        } else {
            (0, 0, false)
        }
    }

    public fun get_sale_constants() : (u64, u64, u64, u64, u64) {
        (100000000000000, 10000000000, 2, 40000000000000000, 400)
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SaleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SaleAdminCap>(v1, v0);
        let v2 = TokenSale{
            id                       : 0x2::object::new(arg0),
            tokens_for_sale          : 0x2::balance::zero<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(),
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

    public entry fun mark_liquidity_added(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(arg1.sold_out, 9);
        assert!(!arg1.liquidity_added, 10);
        arg1.liquidity_added = true;
        arg1.distribution_unlock_time = 0x2::clock::timestamp_ms(arg2) + 10800000;
        let v0 = LiquidityMarkedAdded{distribution_unlock_time: arg1.distribution_unlock_time};
        0x2::event::emit<LiquidityMarkedAdded>(v0);
    }

    public entry fun purchase(arg0: &mut TokenSale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.sale_active, 1);
        assert!(!arg0.sold_out, 4);
        assert!(arg0.tokens_remaining >= 100000000000000, 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= 10000000000, 3);
        if (v1 > 10000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - 10000000000, arg2), v0);
        };
        if (!0x2::table::contains<address, PurchaseInfo>(&arg0.purchases, v0)) {
            let v2 = PurchaseInfo{
                purchase_count   : 0,
                tokens_purchased : 0,
                claimed          : false,
            };
            0x2::table::add<address, PurchaseInfo>(&mut arg0.purchases, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, PurchaseInfo>(&mut arg0.purchases, v0);
        assert!(v3.purchase_count < 2, 2);
        v3.purchase_count = v3.purchase_count + 1;
        v3.tokens_purchased = v3.tokens_purchased + 100000000000000;
        arg0.tokens_remaining = arg0.tokens_remaining - 100000000000000;
        arg0.total_sui_raised = arg0.total_sui_raised + 10000000000;
        arg0.total_purchases = arg0.total_purchases + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = TokensPurchased{
            buyer            : v0,
            sui_amount       : 10000000000,
            tokens_amount    : 100000000000000,
            purchase_number  : v3.purchase_count,
            tokens_remaining : arg0.tokens_remaining,
        };
        0x2::event::emit<TokensPurchased>(v4);
        if (arg0.tokens_remaining == 0 || arg0.total_purchases >= 400) {
            arg0.sold_out = true;
            arg0.sale_active = false;
            let v5 = SaleSoldOut{
                total_sui_raised : arg0.total_sui_raised,
                total_purchases  : arg0.total_purchases,
            };
            0x2::event::emit<SaleSoldOut>(v5);
        };
    }

    public entry fun set_treasury_wallet(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: address) {
        arg1.treasury_wallet = arg2;
    }

    public entry fun start_sale(arg0: &SaleAdminCap, arg1: &mut TokenSale, arg2: &0x2::clock::Clock) {
        assert!(!arg1.sale_active, 12);
        assert!(arg1.tokens_remaining >= 40000000000000000, 11);
        arg1.sale_active = true;
        let v0 = SaleStarted{start_time: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<SaleStarted>(v0);
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
        if (0x2::balance::value<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&arg1.tokens_for_sale) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>>(0x2::coin::from_balance<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(0x2::balance::withdraw_all<0x3ab9fef3dcf219a23355fa0e3d4f7d9cdd421ddba4e3b2cb566543d4a10b4c38::shttoken::SHTTOKEN>(&mut arg1.tokens_for_sale), arg2), arg1.treasury_wallet);
        };
    }

    // decompiled from Move bytecode v6
}

