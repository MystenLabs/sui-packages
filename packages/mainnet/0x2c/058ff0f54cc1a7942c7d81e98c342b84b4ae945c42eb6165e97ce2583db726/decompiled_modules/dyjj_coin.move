module 0x2c058ff0f54cc1a7942c7d81e98c342b84b4ae945c42eb6165e97ce2583db726::dyjj_coin {
    struct DYJJ_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYJJ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYJJ_COIN>(arg0, 9, b"DYJJ-Cyper", b"One Piece!", b"DYJJ game coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/79622407"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYJJ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYJJ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<DYJJ_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DYJJ_COIN>>(0x2::coin::mint<DYJJ_COIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

