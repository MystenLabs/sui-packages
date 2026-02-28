module 0xe8bcd496fe88e2cc2a03909e75f74ce9c6e43db73328131199493e60c417ada3::factory_single_type {
    struct FACTORY_SINGLE_TYPE has drop {
        dummy_field: bool,
    }

    struct TokenMarker has drop, store {
        dummy_field: bool,
    }

    struct CapStore has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<FACTORY_SINGLE_TYPE>,
        admin: address,
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

    public entry fun create_token(arg0: &mut Factory, arg1: &mut CapStore, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 1000000000 * 0x1::u64::pow(10, (arg4 as u8));
        let v2 = Token{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg2),
            symbol       : 0x1::string::utf8(arg3),
            decimals     : arg4,
            total_supply : v1,
            creator      : v0,
            treasury     : 0x2::coin::into_balance<FACTORY_SINGLE_TYPE>(0x2::coin::mint<FACTORY_SINGLE_TYPE>(&mut arg1.cap, v1, arg5)),
            sui_treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            is_graduated : false,
        };
        let v3 = 0x2::object::id<Token>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.registry, arg0.total_tokens, v3);
        arg0.total_tokens = arg0.total_tokens + 1;
        0x2::transfer::share_object<Token>(v2);
        let v4 = TokenCreated{
            id        : v3,
            name      : 0x1::string::utf8(arg2),
            symbol    : 0x1::string::utf8(arg3),
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
        let v0 = Factory{
            id           : 0x2::object::new(arg1),
            admin        : 0x2::tx_context::sender(arg1),
            total_tokens : 0,
            registry     : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Factory>(v0);
        let (v1, v2) = 0x2::coin::create_currency<FACTORY_SINGLE_TYPE>(arg0, 6, b"MARKER", b"Token Marker", b"Treasury capability for meme token factory", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = CapStore{
            id    : 0x2::object::new(arg1),
            cap   : v1,
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<CapStore>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACTORY_SINGLE_TYPE>>(v2, 0x2::tx_context::sender(arg1));
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

    public entry fun transfer_capstore_admin(arg0: &mut CapStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public entry fun transfer_token(arg0: &Token, arg1: 0x2::coin::Coin<FACTORY_SINGLE_TYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FACTORY_SINGLE_TYPE>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

