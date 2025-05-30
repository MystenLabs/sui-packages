module 0x5ebfebc8b6ec2fae6dfabcbaf32a9710f9f1d640e1bd56b4a5792e940702e67a::coin_factory {
    struct CoinCreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
    }

    struct COIN_FACTORY has drop {
        dummy_field: bool,
    }

    struct CoinFactory has key {
        id: 0x2::object::UID,
        coins: 0x2::table::Table<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>,
    }

    struct CoinTypeWrapper has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut CoinFactory, arg1: vector<u8>, arg2: 0x2::coin::Coin<CoinTypeWrapper>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&arg0.coins, v0), 1);
        0x2::coin::burn<CoinTypeWrapper>(0x2::table::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&mut arg0.coins, v0), arg2);
    }

    public entry fun mint(arg0: &mut CoinFactory, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&arg0.coins, v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinTypeWrapper>>(0x2::coin::mint<CoinTypeWrapper>(0x2::table::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&mut arg0.coins, v0), arg2, arg4), arg3);
    }

    public entry fun create_coin(arg0: &mut CoinFactory, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&arg0.coins, v0), 0);
        assert!(0x1::string::length(&v0) <= 10, 2);
        let v1 = if (0x1::vector::is_empty<u8>(&arg5)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg5))
        };
        let v2 = CoinTypeWrapper{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<CoinTypeWrapper>(v2, arg4, arg2, arg1, arg3, v1, arg6);
        0x2::table::add<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(&mut arg0.coins, v0, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CoinTypeWrapper>>(v4);
        let v5 = CoinCreatedEvent{
            name     : 0x1::string::utf8(arg1),
            symbol   : v0,
            decimals : arg4,
        };
        0x2::event::emit<CoinCreatedEvent>(v5);
    }

    public fun get_balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    fun init(arg0: COIN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFactory{
            id    : 0x2::object::new(arg1),
            coins : 0x2::table::new<0x1::string::String, 0x2::coin::TreasuryCap<CoinTypeWrapper>>(arg1),
        };
        0x2::transfer::share_object<CoinFactory>(v0);
        0x2::package::claim_and_keep<COIN_FACTORY>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

