module 0x44d35f3cad31836e03efb95e2f92f6fb980a2ff05e1ff61c8bb6b3721454e11a::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"SUITOSHI", x"4465736372696f3a2049276d20535549544f534849210a0a4920646f6e27742073656c6c206d7920626167732e204e4556455221212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000326969_5e275e63a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

