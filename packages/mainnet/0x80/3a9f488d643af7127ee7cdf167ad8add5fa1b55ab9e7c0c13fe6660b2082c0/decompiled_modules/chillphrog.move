module 0x803a9f488d643af7127ee7cdf167ad8add5fa1b55ab9e7c0c13fe6660b2082c0::chillphrog {
    struct CHILLPHROG has drop {
        dummy_field: bool,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<CHILLPHROG>,
        owner: address,
        marketing_wallet: address,
        trading_enabled: bool,
        marketing_balance: 0x2::balance::Balance<CHILLPHROG>,
        total_burned: u64,
        total_supply: u64,
    }

    struct ExtendedMetadata has key {
        id: 0x2::object::UID,
        website: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        discord: 0x1::string::String,
    }

    struct TransferDebugEvent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        fees_applied: bool,
        marketing_fee: u64,
        burn_fee: u64,
    }

    struct DeploymentEvent has copy, drop {
        total_supply: u64,
        timestamp: u64,
    }

    struct TransferCap has key {
        id: 0x2::object::UID,
    }

    struct FeeBypassAttempt has copy, drop {
        sender: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun transfer(arg0: &mut TokenConfig, arg1: &TransferCap, arg2: 0x2::coin::Coin<CHILLPHROG>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_transfer_cap(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (arg0.trading_enabled) {
            true
        } else if (v0 == arg0.owner) {
            true
        } else {
            v0 == arg0.marketing_wallet
        };
        assert!(v1, 2);
        let v2 = 0x2::coin::value<CHILLPHROG>(&arg2);
        let v3 = false;
        let v4 = 0;
        let v5 = 0;
        let v6 = v0 != arg0.owner && v0 != arg0.marketing_wallet;
        let v7 = TransferDebugEvent{
            sender        : v0,
            recipient     : arg3,
            amount        : v2,
            fees_applied  : v6,
            marketing_fee : 0,
            burn_fee      : 0,
        };
        0x2::event::emit<TransferDebugEvent>(v7);
        if (v0 != arg0.owner && v0 != arg0.marketing_wallet) {
            assert!(v2 <= arg0.total_supply * 100 / 10000, 3);
            let (v8, v9) = calculate_fees(v2);
            v4 = v9;
            v5 = v8 - v9;
            v3 = true;
            if (v8 > 0) {
                let v10 = 0x2::coin::split<CHILLPHROG>(&mut arg2, v8, arg4);
                let v11 = 0x2::coin::burn<CHILLPHROG>(&mut arg0.treasury_cap, v10);
                arg0.total_burned = arg0.total_burned + v11;
                arg0.total_supply = arg0.total_supply - v11;
                0x2::balance::join<CHILLPHROG>(&mut arg0.marketing_balance, 0x2::coin::into_balance<CHILLPHROG>(0x2::coin::split<CHILLPHROG>(&mut v10, v9, arg4)));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<CHILLPHROG>>(arg2, arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHILLPHROG>>(arg2, arg3);
        };
        let v12 = TransferDebugEvent{
            sender        : v0,
            recipient     : arg3,
            amount        : v2,
            fees_applied  : v3,
            marketing_fee : v4,
            burn_fee      : v5,
        };
        0x2::event::emit<TransferDebugEvent>(v12);
    }

    public fun assert_transfer_cap(arg0: &TransferCap) {
    }

    fun calculate_fees(arg0: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        (((v0 * (500 as u128) / 10000) as u64), ((v0 * (200 as u128) / 10000) as u64))
    }

    public entry fun claim_marketing_fees(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.marketing_wallet, 1);
        let v0 = 0x2::balance::value<CHILLPHROG>(&arg0.marketing_balance);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLPHROG>>(0x2::coin::from_balance<CHILLPHROG>(0x2::balance::split<CHILLPHROG>(&mut arg0.marketing_balance, v0), arg1), arg0.marketing_wallet);
    }

    public entry fun emergency_pause_trading(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = false;
    }

    public entry fun emergency_resume_trading(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = true;
    }

    public entry fun enable_trading(arg0: &mut TokenConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = true;
    }

    public fun get_discord(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.discord
    }

    public fun get_fee_stats(arg0: &TokenConfig) : (u64, u64, u64) {
        (arg0.total_burned, 0x2::balance::value<CHILLPHROG>(&arg0.marketing_balance), arg0.total_supply)
    }

    public fun get_marketing_balance(arg0: &TokenConfig) : u64 {
        0x2::balance::value<CHILLPHROG>(&arg0.marketing_balance)
    }

    public fun get_telegram(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.telegram
    }

    public fun get_total_burned(arg0: &TokenConfig) : u64 {
        arg0.total_burned
    }

    public fun get_total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_supply
    }

    public fun get_twitter(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.twitter
    }

    public fun get_website(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.website
    }

    fun init(arg0: CHILLPHROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILLPHROG>(arg0, 6, b"CHILLPHROG", b"Chill Phrog", b"The chillest frog meme coin on Sui. Join our vibrant community of chill frogs. Ribbit responsibly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/QfDdxT1/CHILLPHROG.png")), arg1);
        let v3 = TokenConfig{
            id                : 0x2::object::new(arg1),
            treasury_cap      : v1,
            owner             : v0,
            marketing_wallet  : v0,
            trading_enabled   : false,
            marketing_balance : 0x2::balance::zero<CHILLPHROG>(),
            total_burned      : 0,
            total_supply      : 100000000000000000,
        };
        let v4 = TransferCap{id: 0x2::object::new(arg1)};
        let v5 = ExtendedMetadata{
            id       : 0x2::object::new(arg1),
            website  : 0x1::string::utf8(b"https://chillphrog.xyz"),
            twitter  : 0x1::string::utf8(b"https://x.com/chillphrogcoin"),
            telegram : 0x1::string::utf8(b"https://t.me/chillphrog"),
            discord  : 0x1::string::utf8(b"https://discord.gg/jeHhwJfG"),
        };
        let v6 = DeploymentEvent{
            total_supply : 100000000000000000,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DeploymentEvent>(v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPHROG>>(v2);
        0x2::transfer::share_object<ExtendedMetadata>(v5);
        0x2::transfer::share_object<TransferCap>(v4);
        0x2::transfer::share_object<TokenConfig>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLPHROG>>(0x2::coin::mint<CHILLPHROG>(&mut v3.treasury_cap, 100000000000000000, arg1), v0);
    }

    public fun is_trading_enabled(arg0: &TokenConfig) : bool {
        arg0.trading_enabled
    }

    public fun prevent_direct_transfer(arg0: 0x2::coin::Coin<CHILLPHROG>) {
        abort 4
    }

    public fun report_bypass_attempt(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = FeeBypassAttempt{
            sender    : 0x2::tx_context::sender(arg1),
            amount    : arg0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<FeeBypassAttempt>(v0);
    }

    public fun transfer_hook(arg0: &mut TokenConfig, arg1: &mut 0x2::coin::Coin<CHILLPHROG>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg0.trading_enabled) {
            true
        } else if (v0 == arg0.owner) {
            true
        } else {
            v0 == arg0.marketing_wallet
        };
        assert!(v1, 2);
        if (v0 != arg0.owner && v0 != arg0.marketing_wallet) {
            let (v2, v3) = calculate_fees(arg2);
            if (v2 > 0) {
                let v4 = 0x2::coin::split<CHILLPHROG>(arg1, v2, arg3);
                let v5 = 0x2::coin::burn<CHILLPHROG>(&mut arg0.treasury_cap, v4);
                arg0.total_burned = arg0.total_burned + v5;
                arg0.total_supply = arg0.total_supply - v5;
                0x2::balance::join<CHILLPHROG>(&mut arg0.marketing_balance, 0x2::coin::into_balance<CHILLPHROG>(0x2::coin::split<CHILLPHROG>(&mut v4, v3, arg3)));
            };
        };
    }

    public entry fun update_marketing_wallet(arg0: &mut TokenConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.marketing_wallet = arg1;
    }

    // decompiled from Move bytecode v6
}

