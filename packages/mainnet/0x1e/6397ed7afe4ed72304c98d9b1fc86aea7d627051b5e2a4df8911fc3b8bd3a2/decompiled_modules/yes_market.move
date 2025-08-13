module 0x1e6397ed7afe4ed72304c98d9b1fc86aea7d627051b5e2a4df8911fc3b8bd3a2::yes_market {
    struct YES_MARKET has drop {
        dummy_field: bool,
    }

    struct ShortKey has copy, drop, store {
        owner: address,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        description: vector<u8>,
        admin: address,
        yes_usdc_pool: 0x2::object::ID,
        escrow_usdc: 0x2::balance::Balance<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>,
        treasury_cap: 0x2::coin::TreasuryCap<YES_MARKET>,
        outcome: u8,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        yes_usdc_pool: 0x2::object::ID,
        description: vector<u8>,
    }

    struct Minted has copy, drop {
        market_id: 0x2::object::ID,
        minter: address,
        amount: u64,
    }

    struct Redeemed has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        amount: u64,
        post_resolution: bool,
    }

    struct NoClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    fun add_short(arg0: &mut Market, arg1: address, arg2: u64) {
        let v0 = ShortKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<ShortKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<ShortKey, u64>(&mut arg0.id, v0, arg2);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<ShortKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + arg2;
        };
    }

    public fun admin(arg0: &Market) : address {
        arg0.admin
    }

    entry fun burn_worthless_yes(arg0: &mut Market, arg1: 0x2::coin::Coin<YES_MARKET>) {
        assert!(arg0.outcome == 2, 4);
        0x2::coin::burn<YES_MARKET>(&mut arg0.treasury_cap, arg1);
    }

    entry fun claim_no(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.outcome == 2, 4);
        assert!(arg1 > 0, 5);
        sub_short(arg0, 0x2::tx_context::sender(arg2), arg1);
        let v0 = NoClaimed{
            market_id : 0x2::object::id<Market>(arg0),
            claimer   : 0x2::tx_context::sender(arg2),
            amount    : arg1,
        };
        0x2::event::emit<NoClaimed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>>(0x2::coin::from_balance<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(0x2::balance::split<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(&mut arg0.escrow_usdc, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun create_market_admin(arg0: &mut 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::registry::Registry, arg1: &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::registry::DeepbookAdminCap, arg2: 0x2::coin::TreasuryCap<YES_MARKET>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::pool::create_pool_admin<YES_MARKET, 0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(arg0, 10000000, 1000, 10000, true, false, arg1, arg3);
        let v1 = Market{
            id            : 0x2::object::new(arg3),
            description   : b"Will Trump Win?",
            admin         : 0x2::tx_context::sender(arg3),
            yes_usdc_pool : v0,
            escrow_usdc   : 0x2::balance::zero<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(),
            treasury_cap  : arg2,
            outcome       : 0,
        };
        let v2 = MarketCreated{
            market_id     : 0x2::object::id<Market>(&v1),
            yes_usdc_pool : v0,
            description   : v1.description,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market>(v1);
    }

    public fun escrow_amount(arg0: &Market) : u64 {
        0x2::balance::value<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(&arg0.escrow_usdc)
    }

    fun init(arg0: YES_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YES_MARKET>(arg0, 6, b"YES", b"YES Token", b"Will Trump Win?", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YES_MARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YES_MARKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_yes(arg0: &mut Market, arg1: 0x2::coin::Coin<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.outcome == 0, 2);
        let v0 = 0x2::coin::value<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(&arg1);
        assert!(v0 > 0, 5);
        0x2::balance::join<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(&mut arg0.escrow_usdc, 0x2::coin::into_balance<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(arg1));
        add_short(arg0, 0x2::tx_context::sender(arg2), v0);
        let v1 = Minted{
            market_id : 0x2::object::id<Market>(arg0),
            minter    : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YES_MARKET>>(0x2::coin::mint<YES_MARKET>(&mut arg0.treasury_cap, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun outcome(arg0: &Market) : u8 {
        arg0.outcome
    }

    public fun pool_id_yes_usdc(arg0: &Market) : 0x2::object::ID {
        arg0.yes_usdc_pool
    }

    entry fun redeem_yes_winner(arg0: &mut Market, arg1: 0x2::coin::Coin<YES_MARKET>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.outcome == 1, 3);
        let v0 = 0x2::coin::value<YES_MARKET>(&arg1);
        0x2::coin::burn<YES_MARKET>(&mut arg0.treasury_cap, arg1);
        let v1 = Redeemed{
            market_id       : 0x2::object::id<Market>(arg0),
            redeemer        : 0x2::tx_context::sender(arg2),
            amount          : v0,
            post_resolution : true,
        };
        0x2::event::emit<Redeemed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>>(0x2::coin::from_balance<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(0x2::balance::split<0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc::PINATA_USDC>(&mut arg0.escrow_usdc, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun resolve_invalid(arg0: &mut Market, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(arg0.outcome == 0, 2);
        arg0.outcome = 3;
    }

    entry fun resolve_no(arg0: &mut Market, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(arg0.outcome == 0, 2);
        arg0.outcome = 2;
    }

    entry fun resolve_yes(arg0: &mut Market, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(arg0.outcome == 0, 2);
        arg0.outcome = 1;
    }

    public fun short_of(arg0: &Market, arg1: address) : u64 {
        let v0 = ShortKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<ShortKey>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<ShortKey, u64>(&arg0.id, v0)
    }

    fun sub_short(arg0: &mut Market, arg1: address, arg2: u64) {
        let v0 = ShortKey{owner: arg1};
        assert!(0x2::dynamic_field::exists_<ShortKey>(&arg0.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow_mut<ShortKey, u64>(&mut arg0.id, v0);
        assert!(*v1 >= arg2, 6);
        *v1 = *v1 - arg2;
        if (*v1 == 0) {
            0x2::dynamic_field::remove<ShortKey, u64>(&mut arg0.id, v0);
        };
    }

    // decompiled from Move bytecode v6
}

