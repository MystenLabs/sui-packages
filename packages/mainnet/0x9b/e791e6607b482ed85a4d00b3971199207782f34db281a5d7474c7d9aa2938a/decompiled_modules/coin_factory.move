module 0x9be791e6607b482ed85a4d00b3971199207782f34db281a5d7474c7d9aa2938a::coin_factory {
    struct COIN_FACTORY has drop {
        dummy_field: bool,
    }

    struct CoinFactory has key {
        id: 0x2::object::UID,
        coins: 0x2::table::Table<0x1::string::String, 0x2::coin::TreasuryCap<CoinFactoryCoin>>,
    }

    struct CoinFactoryCoin has drop {
        dummy_field: bool,
    }

    struct CoinInfo has drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        decimals: u8,
    }

    public entry fun create_coin(arg0: &mut CoinFactory, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFactoryCoin{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<CoinFactoryCoin>(v0, arg4, arg2, arg1, arg3, 0x1::option::none<0x2::url::Url>(), arg5);
        0x2::table::add<0x1::string::String, 0x2::coin::TreasuryCap<CoinFactoryCoin>>(&mut arg0.coins, 0x1::string::utf8(arg2), v1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CoinFactoryCoin>>(v2, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: COIN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFactory{
            id    : 0x2::object::new(arg1),
            coins : 0x2::table::new<0x1::string::String, 0x2::coin::TreasuryCap<CoinFactoryCoin>>(arg1),
        };
        0x2::transfer::share_object<CoinFactory>(v0);
        0x2::package::claim_and_keep<COIN_FACTORY>(arg0, arg1);
    }

    public entry fun mint_coin(arg0: &mut CoinFactory, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinFactoryCoin>>(0x2::coin::mint<CoinFactoryCoin>(0x2::table::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<CoinFactoryCoin>>(&mut arg0.coins, 0x1::string::utf8(arg1)), arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

