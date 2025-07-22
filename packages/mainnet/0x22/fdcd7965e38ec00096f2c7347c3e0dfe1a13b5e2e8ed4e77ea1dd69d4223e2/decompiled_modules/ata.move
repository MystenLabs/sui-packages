module 0x22fdcd7965e38ec00096f2c7347c3e0dfe1a13b5e2e8ed4e77ea1dd69d4223e2::ata {
    struct ATA has drop {
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

    struct UMyTokenCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<ATA>,
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

    public entry fun burn(arg0: &mut UMyTokenCap, arg1: 0x2::coin::Coin<ATA>) {
        let v0 = 0x2::coin::value<ATA>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::burn<ATA>(&mut arg0.treasury, arg1);
        let v1 = BurnEvent{amount: v0};
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun buy_tokens(arg0: &mut TokenConfig, arg1: &mut UMyTokenCap, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = v0 / 10000;
        assert!(v1 > 0, 5);
        let v2 = 0x2::coin::total_supply<ATA>(&arg1.treasury) * v1 / 100;
        assert!(v2 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.token_account_address);
        0x2::coin::mint_and_transfer<ATA>(&mut arg1.treasury, v2, 0x2::tx_context::sender(arg4), arg4);
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

    fun init(arg0: ATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATA>(arg0, 9, b"ATA", b"AI Trading Agent", b"An AI-powered trading agent that uses market data to execute trades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/token-icon.png")), arg1);
        let v2 = TokenConfig{
            id                             : 0x2::object::new(arg1),
            profit_taking_period_hours     : 24,
            profit_taking_percentage       : 10,
            token_account_address          : @0x8ab72d43e94abc1181006b5bf9dd3d3c60869a661a5be8faa8b05feb673e6a68,
            last_profit_taken_timestamp_ms : 0,
            total_profit_taken             : 0,
            total_tokens_sold              : 0,
            total_sui_collected            : 0,
        };
        let v3 = UMyTokenCap{
            id        : 0x2::object::new(arg1),
            treasury  : v0,
            config_id : 0x2::object::new(arg1),
        };
        let v4 = TokenConfigCreatedEvent{
            config_id                  : 0x2::object::uid_to_inner(&v2.id),
            token_account_address      : @0x8ab72d43e94abc1181006b5bf9dd3d3c60869a661a5be8faa8b05feb673e6a68,
            profit_taking_period_hours : 24,
            profit_taking_percentage   : 10,
        };
        0x2::event::emit<TokenConfigCreatedEvent>(v4);
        let v5 = TreasuryCapCreatedEvent{
            cap_id           : 0x2::object::uid_to_inner(&v3.id),
            transfer_address : @0x8ab72d43e94abc1181006b5bf9dd3d3c60869a661a5be8faa8b05feb673e6a68,
        };
        0x2::event::emit<TreasuryCapCreatedEvent>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATA>>(v1);
        0x2::transfer::public_share_object<TokenConfig>(v2);
        0x2::coin::mint_and_transfer<ATA>(&mut v3.treasury, 1000000000000, @0x8ab72d43e94abc1181006b5bf9dd3d3c60869a661a5be8faa8b05feb673e6a68, arg1);
        0x2::transfer::public_share_object<UMyTokenCap>(v3);
    }

    public entry fun mark_profit_claimed(arg0: &mut TokenConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.token_account_address, 4);
        arg0.last_profit_taken_timestamp_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.total_profit_taken = arg0.total_profit_taken + 1;
    }

    public entry fun mint(arg0: &mut UMyTokenCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<ATA>(&mut arg0.treasury, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<ATA>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ATA>>(arg0, arg1);
    }

    public entry fun update_profit_config(arg0: &mut TokenConfig, arg1: &UMyTokenCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

