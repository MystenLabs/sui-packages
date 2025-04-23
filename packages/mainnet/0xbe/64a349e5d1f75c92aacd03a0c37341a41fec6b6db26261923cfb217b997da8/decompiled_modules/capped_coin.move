module 0xbe64a349e5d1f75c92aacd03a0c37341a41fec6b6db26261923cfb217b997da8::capped_coin {
    struct CAPPED_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPED_COIN>(arg0, 9, b"CAP", b"Capped Coin", b"A coin with a fixed 1 billion supply", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPPED_COIN>>(0x2::coin::from_balance<CAPPED_COIN>(0x2::coin::mint_balance<CAPPED_COIN>(&mut v2, 1000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPPED_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPPED_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

