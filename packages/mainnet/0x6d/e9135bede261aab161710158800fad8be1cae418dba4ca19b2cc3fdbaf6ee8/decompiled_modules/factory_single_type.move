module 0x6de9135bede261aab161710158800fad8be1cae418dba4ca19b2cc3fdbaf6ee8::factory_single_type {
    struct TokenMarker has drop, store {
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

    public entry fun buy_token(arg0: &mut Token, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(0x2::coin::from_balance<TokenMarker>(0x2::balance::split<TokenMarker>(&mut arg0.treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_token(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::TreasuryCap<TokenMarker>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 1000000000 * 0x1::u64::pow(10, (arg3 as u8));
        let v2 = Token{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg1),
            symbol       : 0x1::string::utf8(arg2),
            decimals     : arg3,
            total_supply : v1,
            creator      : v0,
            treasury     : 0x2::coin::into_balance<TokenMarker>(0x2::coin::mint<TokenMarker>(&mut arg4, v1, arg5)),
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            total_tokens : 0,
            registry     : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public entry fun mint_to(arg0: &mut Token, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(0x2::coin::mint<TokenMarker>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public entry fun sell_token(arg0: &mut Token, arg1: 0x2::coin::Coin<TokenMarker>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<TokenMarker>(&arg1);
        0x2::balance::join<TokenMarker>(&mut arg0.treasury, 0x2::coin::into_balance<TokenMarker>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun transfer_token(arg0: &Token, arg1: 0x2::coin::Coin<TokenMarker>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenMarker>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

