module 0x679e10cefe401da6e8469812f4dcd74b73a348d4090ca2089c7f17ff47ea0fad::tether_factory {
    struct FactoryCap has store, key {
        id: 0x2::object::UID,
        factory_id: address,
    }

    struct TetherFactory has key {
        id: 0x2::object::UID,
        admin: address,
        created_tokens: 0x2::table::Table<0x1::string::String, address>,
        total_tokens_created: u64,
        factory_fee: u64,
    }

    struct TokenCreated has copy, drop {
        token_symbol: 0x1::string::String,
        token_name: 0x1::string::String,
        package_id: address,
        creator: address,
        timestamp: u64,
    }

    struct FactoryStatsUpdated has copy, drop {
        total_tokens: u64,
        new_token_symbol: 0x1::string::String,
    }

    public entry fun create_tether_token<T0: drop>(arg0: &mut TetherFactory, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<vector<u8>>, arg6: u8, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.factory_fee, 2003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg0.admin);
        let v0 = 0x1::string::utf8(arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.created_tokens, v0), 2002);
        assert!(0x1::string::length(&v0) > 0, 2004);
        let v1 = if (0x1::option::is_some<vector<u8>>(&arg5)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg5)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<T0>(arg1, arg6, arg2, arg3, arg4, v1, arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v2, 0x2::tx_context::sender(arg8));
        let v4 = 0x2::tx_context::sender(arg8);
        0x2::table::add<0x1::string::String, address>(&mut arg0.created_tokens, v0, v4);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        let v5 = TokenCreated{
            token_symbol : v0,
            token_name   : 0x1::string::utf8(arg3),
            package_id   : v4,
            creator      : 0x2::tx_context::sender(arg8),
            timestamp    : 0,
        };
        0x2::event::emit<TokenCreated>(v5);
        let v6 = FactoryStatsUpdated{
            total_tokens     : arg0.total_tokens_created,
            new_token_symbol : v0,
        };
        0x2::event::emit<FactoryStatsUpdated>(v6);
    }

    public entry fun create_usdt_token<T0: drop>(arg0: &mut TetherFactory, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        create_tether_token<T0>(arg0, arg1, b"USDT", b"Tether USD", b"Tether USD stablecoin on Sui Network", 0x1::option::some<vector<u8>>(b"https://s2.coinmarketcap.com/static/img/coins/64x64/825.png"), 6, arg2, arg3);
    }

    public fun get_created_tokens_count(arg0: &TetherFactory) : u64 {
        arg0.total_tokens_created
    }

    public fun get_factory_stats(arg0: &TetherFactory) : (u64, u64, address) {
        (arg0.total_tokens_created, arg0.factory_fee, arg0.admin)
    }

    public fun get_token_package_id(arg0: &TetherFactory, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.created_tokens, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.created_tokens, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = TetherFactory{
            id                   : v0,
            admin                : 0x2::tx_context::sender(arg0),
            created_tokens       : 0x2::table::new<0x1::string::String, address>(arg0),
            total_tokens_created : 0,
            factory_fee          : 1000000000,
        };
        let v2 = FactoryCap{
            id         : 0x2::object::new(arg0),
            factory_id : 0x2::object::uid_to_address(&v0),
        };
        0x2::transfer::transfer<FactoryCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TetherFactory>(v1);
    }

    public fun is_token_created(arg0: &TetherFactory, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.created_tokens, arg1)
    }

    public entry fun update_factory_admin(arg0: &FactoryCap, arg1: &mut TetherFactory, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public entry fun update_factory_fee(arg0: &FactoryCap, arg1: &mut TetherFactory, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.factory_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

