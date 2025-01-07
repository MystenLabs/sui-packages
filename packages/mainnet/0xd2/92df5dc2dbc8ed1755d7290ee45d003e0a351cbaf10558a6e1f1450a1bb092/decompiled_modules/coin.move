module 0xd292df5dc2dbc8ed1755d7290ee45d003e0a351cbaf10558a6e1f1450a1bb092::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"GOOFY", b"Goofy the KING", b"Unleash the fun with Goofy Doge Coin, the wacky memecoin that celebrates all things goofy and canine! Inspired by the playful spirit of our four-legged friends, GOOFY combines humor, community, and cryptocurrency in a delightful package.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/010218goofy_3965c1d516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

