module 0xed5120f5c1edad2eb6bb9cdf20c301ed953717d0cb85548686aea8db7fd141a9::babybtc {
    struct BABYBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBTC>(arg0, 6, b"BabyBTC", b"Baby BTC", b"Baby Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babybtc_6ec9a66f04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

