module 0xdaa9d6c2507a047b5d7b3187fed759f2d25182f9e2a5745e247911e3e41ddb2f::suidae {
    struct SUIDAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAE>(arg0, 6, b"SUIDAE", b"Suidae Bot", x"48656c6c6f20776f726c64210a0a57652061726520405375696461655f626f74202d20746865206661737465737420616e64207361666573742074656c656772616d20626f7420666f722074726164696e6720616e7920746f6b656e73206f6e20537569206e6574776f726b2e0a0a4f757220626f742063616e3a0af09f9ba0204372656174652c20496d706f727420616e64204d616e61676520796f7572205355492077616c6c6574210af09f92b020547261646520616e7920746f6b656e206f6e20535549210af09fa49d20526566657220667269656e647320616e64206561726e2053554920666f722061206c69666574696d65212028736f6f6e2129", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734910535019.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

