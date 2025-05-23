module 0xc49e6d7fb74e221cbd2ca32818a78400c45cbe54ada071ba7bbc564120550043::rsit {
    struct RSIT has drop {
        dummy_field: bool,
    }

    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        profit_taking_period_hours: u64,
        profit_taking_percentage: u64,
        token_account_address: address,
        last_profit_taken_timestamp_ms: u64,
        total_profit_taken: u64,
        total_tokens_sold: u64,
        total_sui_collected: u64,
    }

    struct URSITRADERCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<RSIT>,
        config_id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    struct ProfitClaimableEvent has copy, drop {
        claimable: bool,
        timestamp_ms: u64,
        caller: address,
    }

    struct ConfigUpdatedEvent has copy, drop {
        profit_taking_period_hours: u64,
        profit_taking_percentage: u64,
    }

    struct TokenPurchaseEvent has copy, drop {
        buyer: address,
        sui_amount: u64,
        token_amount: u64,
        timestamp_ms: u64,
    }

    struct TokenConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        token_account_address: address,
        profit_taking_period_hours: u64,
        profit_taking_percentage: u64,
    }

    struct TreasuryCapCreatedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        transfer_address: address,
    }

    public entry fun burn(arg0: &mut URSITRADERCap, arg1: 0x2::coin::Coin<RSIT>) {
        let v0 = 0x2::coin::value<RSIT>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::burn<RSIT>(&mut arg0.treasury, arg1);
        let v1 = BurnEvent{amount: v0};
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun buy_tokens(arg0: &mut TokenConfig, arg1: &mut URSITRADERCap, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = v0 / 10000;
        assert!(v1 > 0, 5);
        let v2 = 0x2::coin::total_supply<RSIT>(&arg1.treasury) * v1 / 100;
        assert!(v2 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.token_account_address);
        0x2::coin::mint_and_transfer<RSIT>(&mut arg1.treasury, v2, 0x2::tx_context::sender(arg4), arg4);
        arg0.total_tokens_sold = arg0.total_tokens_sold + v2;
        arg0.total_sui_collected = arg0.total_sui_collected + v0;
        let v3 = TokenPurchaseEvent{
            buyer        : 0x2::tx_context::sender(arg4),
            sui_amount   : v0,
            token_amount : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenPurchaseEvent>(v3);
    }

    public fun get_profit_config(arg0: &TokenConfig) : (u64, u64, u64, u64) {
        (arg0.profit_taking_period_hours, arg0.profit_taking_percentage, arg0.last_profit_taken_timestamp_ms, arg0.total_profit_taken)
    }

    public fun get_sales_stats(arg0: &TokenConfig) : (u64, u64) {
        (arg0.total_tokens_sold, arg0.total_sui_collected)
    }

    public fun get_token_account_address(arg0: &TokenConfig) : address {
        arg0.token_account_address
    }

    fun init(arg0: RSIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSIT>(arg0, 9, b"RSIT", b"AI Trading Agent", b"An AI-powered trading agent that uses RSI techniques  to execute trades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/token-icon.png")), arg1);
        let v2 = TokenConfig{
            id                             : 0x2::object::new(arg1),
            profit_taking_period_hours     : 24,
            profit_taking_percentage       : 10,
            token_account_address          : @0x61fd91b7a728dbd6a3221e003aca9e307c129621a5d934c5de0f29566ea02922,
            last_profit_taken_timestamp_ms : 0,
            total_profit_taken             : 0,
            total_tokens_sold              : 0,
            total_sui_collected            : 0,
        };
        let v3 = URSITRADERCap{
            id        : 0x2::object::new(arg1),
            treasury  : v0,
            config_id : 0x2::object::new(arg1),
        };
        let v4 = TokenConfigCreatedEvent{
            config_id                  : 0x2::object::uid_to_inner(&v2.id),
            token_account_address      : @0x61fd91b7a728dbd6a3221e003aca9e307c129621a5d934c5de0f29566ea02922,
            profit_taking_period_hours : 24,
            profit_taking_percentage   : 10,
        };
        0x2::event::emit<TokenConfigCreatedEvent>(v4);
        let v5 = TreasuryCapCreatedEvent{
            cap_id           : 0x2::object::uid_to_inner(&v3.id),
            transfer_address : @0x61fd91b7a728dbd6a3221e003aca9e307c129621a5d934c5de0f29566ea02922,
        };
        0x2::event::emit<TreasuryCapCreatedEvent>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSIT>>(v1);
        0x2::transfer::public_share_object<TokenConfig>(v2);
        0x2::coin::mint_and_transfer<RSIT>(&mut v3.treasury, 1000000000000, @0x61fd91b7a728dbd6a3221e003aca9e307c129621a5d934c5de0f29566ea02922, arg1);
        0x2::transfer::public_share_object<URSITRADERCap>(v3);
    }

    public entry fun mark_profit_claimed(arg0: &mut TokenConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.token_account_address, 4);
        arg0.last_profit_taken_timestamp_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.total_profit_taken = arg0.total_profit_taken + 1;
    }

    public entry fun mint(arg0: &mut URSITRADERCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<RSIT>(&mut arg0.treasury, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<RSIT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RSIT>>(arg0, arg1);
    }

    public entry fun update_profit_config(arg0: &mut TokenConfig, arg1: &URSITRADERCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.token_account_address, 4);
        assert!(arg3 <= 50, 3);
        arg0.profit_taking_period_hours = arg2;
        arg0.profit_taking_percentage = arg3;
        let v0 = ConfigUpdatedEvent{
            profit_taking_period_hours : arg2,
            profit_taking_percentage   : arg3,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public entry fun verify_profit_claim(arg0: &TokenConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (arg0.last_profit_taken_timestamp_ms == 0) {
            v0
        } else {
            v0 - arg0.last_profit_taken_timestamp_ms
        };
        let v2 = ProfitClaimableEvent{
            claimable    : v1 >= arg0.profit_taking_period_hours * 3600000,
            timestamp_ms : v0,
            caller       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfitClaimableEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

