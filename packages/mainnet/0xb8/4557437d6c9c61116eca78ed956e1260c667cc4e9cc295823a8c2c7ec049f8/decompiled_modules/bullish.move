module 0xb84557437d6c9c61116eca78ed956e1260c667cc4e9cc295823a8c2c7ec049f8::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 9, b"Bullish", b"Bullish", b"Bullish is Just Holy =D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLISH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

