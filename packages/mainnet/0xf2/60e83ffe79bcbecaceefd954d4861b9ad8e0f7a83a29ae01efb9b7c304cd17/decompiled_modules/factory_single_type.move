module 0xf260e83ffe79bcbecaceefd954d4861b9ad8e0f7a83a29ae01efb9b7c304cd17::factory_single_type {
    struct TokenMarker has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        creator: address,
        treasury: 0x2::balance::Balance<TokenMarker>,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_cap: 0x2::coin::TreasuryCap<TokenMarker>,
        is_graduated: bool,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        total_tokens: u64,
        registry: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct TokenCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        timestamp: u64,
    }

    struct TokenPurchased has copy, drop {
        token_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        paid: u64,
        timestamp: u64,
    }

    struct TokenSold has copy, drop {
        token_id: 0x2::object::ID,
        seller: address,
        amount: u64,
        received: u64,
        timestamp: u64,
    }

    public entry fun buy_token(arg0: &mut Token, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<TokenMarker>(&arg0.treasury) >= arg2, 1001);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = TokenPurchased{
            token_id  : 0x2::object::id<Token>(arg0),
            buyer     : v0,
            amount    : arg2,
            paid      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenPurchased>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(0x2::coin::from_balance<TokenMarker>(0x2::balance::split<TokenMarker>(&mut arg0.treasury, arg2), arg3), v0);
    }

    public entry fun create_token(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 1000000000 * 0x1::u64::pow(10, (arg3 as u8));
        let v2 = TokenMarker{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<TokenMarker>(v2, arg3, arg2, arg1, b"", 0x1::option::none<0x2::url::Url>(), arg4);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TokenMarker>>(v4);
        let v6 = Token{
            id           : 0x2::object::new(arg4),
            name         : 0x1::string::utf8(arg1),
            symbol       : 0x1::string::utf8(arg2),
            decimals     : arg3,
            total_supply : v1,
            creator      : v0,
            treasury     : 0x2::coin::into_balance<TokenMarker>(0x2::coin::mint<TokenMarker>(&mut v5, v1, arg4)),
            sui_treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_cap : v5,
            is_graduated : false,
        };
        let v7 = 0x2::object::id<Token>(&v6);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.registry, arg0.total_tokens, v7);
        arg0.total_tokens = arg0.total_tokens + 1;
        0x2::transfer::share_object<Token>(v6);
        let v8 = TokenCreated{
            id        : v7,
            name      : 0x1::string::utf8(arg1),
            symbol    : 0x1::string::utf8(arg2),
            creator   : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TokenCreated>(v8);
    }

    public fun get_token_info(arg0: &Token) : (0x1::string::String, 0x1::string::String, u8, u64, address, bool) {
        (arg0.name, arg0.symbol, arg0.decimals, arg0.total_supply, arg0.creator, arg0.is_graduated)
    }

    public entry fun graduate(arg0: &mut Token, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1004);
        arg0.is_graduated = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            total_tokens : 0,
            registry     : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public entry fun mint_to(arg0: &mut Factory, arg1: &mut Token, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.creator, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(0x2::coin::from_balance<TokenMarker>(0x2::balance::split<TokenMarker>(&mut arg1.treasury, arg2), arg4), arg3);
    }

    public entry fun sell_token(arg0: &mut Token, arg1: 0x2::coin::Coin<TokenMarker>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= arg2, 1002);
        0x2::balance::join<TokenMarker>(&mut arg0.treasury, 0x2::coin::into_balance<TokenMarker>(arg1));
        let v1 = TokenSold{
            token_id  : 0x2::object::id<Token>(arg0),
            seller    : v0,
            amount    : 0x2::coin::value<TokenMarker>(&arg1),
            received  : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenSold>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, arg2), arg3), v0);
    }

    public entry fun transfer_token(arg0: &Token, arg1: 0x2::coin::Coin<TokenMarker>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

