module 0xf27b7a737dbf08d82d98685196d1b016a60344dc3c4eed7cbda6858b2cf0bc16::yoona333Coin {
    struct YOONA333COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOONA333COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOONA333COIN>(arg0, 8, b"YOONA333COIN", b"YOONA333COIN", b"This is YOONA333COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167958904?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOONA333COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOONA333COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

