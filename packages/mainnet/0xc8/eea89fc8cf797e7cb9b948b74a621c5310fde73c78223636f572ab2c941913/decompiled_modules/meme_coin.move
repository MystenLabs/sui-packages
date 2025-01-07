module 0xc8eea89fc8cf797e7cb9b948b74a621c5310fde73c78223636f572ab2c941913::meme_coin {
    struct MEME_COIN has drop {
        dummy_field: bool,
    }

    struct CreateCurrencyEvent has copy, drop {
        metadata: 0x2::object::ID,
        treasury: 0x2::object::ID,
    }

    struct CreateCoinEvent has copy, drop {
        symbol: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        treasury: 0x2::object::ID,
        metadata: 0x2::object::ID,
        creator: address,
    }

    fun init(arg0: MEME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_COIN>(arg0, 9, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = CreateCurrencyEvent{
            metadata : 0x2::object::id<0x2::coin::CoinMetadata<MEME_COIN>>(&v2),
            treasury : 0x2::object::id<0x2::coin::TreasuryCap<MEME_COIN>>(&v3),
        };
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MEME_COIN>>(v3);
        0x2::event::emit<CreateCurrencyEvent>(v4);
    }

    entry fun init_coin(arg0: &0x2::coin::TreasuryCap<MEME_COIN>, arg1: 0x2::coin::CoinMetadata<MEME_COIN>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0x2::coin::update_symbol<MEME_COIN>(arg0, &mut arg1, 0x1::ascii::string(arg2));
        0x2::coin::update_name<MEME_COIN>(arg0, &mut arg1, 0x1::string::utf8(arg3));
        0x2::coin::update_description<MEME_COIN>(arg0, &mut arg1, 0x1::string::utf8(arg4));
        0x2::coin::update_icon_url<MEME_COIN>(arg0, &mut arg1, 0x1::ascii::string(arg5));
        let v0 = CreateCoinEvent{
            symbol      : 0x2::coin::get_symbol<MEME_COIN>(&arg1),
            name        : 0x2::coin::get_name<MEME_COIN>(&arg1),
            description : 0x2::coin::get_description<MEME_COIN>(&arg1),
            icon_url    : 0x2::coin::get_icon_url<MEME_COIN>(&arg1),
            treasury    : 0x2::object::id<0x2::coin::TreasuryCap<MEME_COIN>>(arg0),
            metadata    : 0x2::object::id<0x2::coin::CoinMetadata<MEME_COIN>>(&arg1),
            creator     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<CreateCoinEvent>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_COIN>>(arg1);
    }

    entry fun init_mint(arg0: &mut 0x2::coin::TreasuryCap<MEME_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_COIN>>(0x2::coin::mint<MEME_COIN>(arg0, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

