module 0x40b8b86496d355031b0eeb39d3297f52be6cebb55fe301a5761e6d42e6fa9d85::factory_single_type {
    struct FACTORY_SINGLE_TYPE has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        creator: address,
        treasury: 0x2::balance::Balance<FACTORY_SINGLE_TYPE>,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_cap: 0x2::coin::TreasuryCap<FACTORY_SINGLE_TYPE>,
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
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = TokenPurchased{
            token_id  : 0x2::object::id<Token>(arg0),
            buyer     : v0,
            amount    : arg2,
            paid      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenPurchased>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FACTORY_SINGLE_TYPE>>(0x2::coin::from_balance<FACTORY_SINGLE_TYPE>(0x2::balance::split<FACTORY_SINGLE_TYPE>(&mut arg0.treasury, arg2), arg3), v0);
    }

    public entry fun create_token(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::TreasuryCap<FACTORY_SINGLE_TYPE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 1000000000 * 0x1::u64::pow(10, (arg3 as u8));
        let v2 = Token{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg1),
            symbol       : 0x1::string::utf8(arg2),
            decimals     : arg3,
            total_supply : v1,
            creator      : v0,
            treasury     : 0x2::coin::into_balance<FACTORY_SINGLE_TYPE>(0x2::coin::mint<FACTORY_SINGLE_TYPE>(&mut arg4, v1, arg5)),
            sui_treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_cap : arg4,
            is_graduated : false,
        };
        let v3 = 0x2::object::id<Token>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.registry, arg0.total_tokens, v3);
        arg0.total_tokens = arg0.total_tokens + 1;
        0x2::transfer::share_object<Token>(v2);
        let v4 = TokenCreated{
            id        : v3,
            name      : 0x1::string::utf8(arg1),
            symbol    : 0x1::string::utf8(arg2),
            creator   : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<TokenCreated>(v4);
    }

    public fun get_token_info(arg0: &Token) : (0x1::string::String, 0x1::string::String, u8, u64, address, bool) {
        (arg0.name, arg0.symbol, arg0.decimals, arg0.total_supply, arg0.creator, arg0.is_graduated)
    }

    public entry fun graduate(arg0: &mut Token, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        arg0.is_graduated = true;
    }

    fun init(arg0: FACTORY_SINGLE_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACTORY_SINGLE_TYPE>(arg0, 9, b"MTKN", b"TokenMarker", b"TokenMarker for Factory", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACTORY_SINGLE_TYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACTORY_SINGLE_TYPE>>(v1);
        let v2 = Factory{
            id           : 0x2::object::new(arg1),
            admin        : 0x2::tx_context::sender(arg1),
            total_tokens : 0,
            registry     : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Factory>(v2);
    }

    public entry fun sell_token(arg0: &mut Token, arg1: 0x2::coin::Coin<FACTORY_SINGLE_TYPE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::balance::join<FACTORY_SINGLE_TYPE>(&mut arg0.treasury, 0x2::coin::into_balance<FACTORY_SINGLE_TYPE>(arg1));
        let v1 = TokenSold{
            token_id  : 0x2::object::id<Token>(arg0),
            seller    : v0,
            amount    : 0x2::coin::value<FACTORY_SINGLE_TYPE>(&arg1),
            received  : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenSold>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, arg2), arg3), v0);
    }

    public entry fun transfer_token(arg0: &Token, arg1: 0x2::coin::Coin<FACTORY_SINGLE_TYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FACTORY_SINGLE_TYPE>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

