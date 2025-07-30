module 0x93399b3dda8c66afa77885352ba46d3bbe53be4f4ce4559ed7ea3f0fb4ed2469::factory_no_treasury {
    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        creator: address,
        available_tokens: u64,
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
        sui_paid: u64,
        timestamp: u64,
    }

    struct TokenSold has copy, drop {
        token_id: 0x2::object::ID,
        seller: address,
        amount: u64,
        sui_received: u64,
        timestamp: u64,
    }

    public entry fun buy_token(arg0: &mut Token, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.available_tokens >= arg2, 1);
        arg0.available_tokens = arg0.available_tokens - arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = TokenPurchased{
            token_id  : 0x2::object::id<Token>(arg0),
            buyer     : 0x2::tx_context::sender(arg3),
            amount    : arg2,
            sui_paid  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenPurchased>(v0);
    }

    public entry fun create_token(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 1000000000 * 0x1::u64::pow(10, (arg3 as u8));
        let v2 = Token{
            id               : 0x2::object::new(arg4),
            name             : 0x1::string::utf8(arg1),
            symbol           : 0x1::string::utf8(arg2),
            decimals         : arg3,
            total_supply     : v1,
            creator          : v0,
            available_tokens : v1,
            sui_treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            is_graduated     : false,
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
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TokenCreated>(v4);
    }

    public fun get_available_tokens(arg0: &Token) : u64 {
        arg0.available_tokens
    }

    public fun get_sui_treasury_value(arg0: &Token) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury)
    }

    public fun get_tokens_sold(arg0: &Token) : u64 {
        arg0.total_supply - arg0.available_tokens
    }

    public fun get_total_supply(arg0: &Token) : u64 {
        arg0.total_supply
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

    public entry fun sell_token(arg0: &mut Token, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= arg2, 2);
        arg0.available_tokens = arg0.available_tokens + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, arg2), arg3), v0);
        let v1 = TokenSold{
            token_id     : 0x2::object::id<Token>(arg0),
            seller       : v0,
            amount       : arg1,
            sui_received : arg2,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenSold>(v1);
    }

    // decompiled from Move bytecode v6
}

