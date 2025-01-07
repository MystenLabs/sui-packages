module 0x2d18912a026e0d1670184ed1b2bdf1f1fa28e8253685b054d7a34127b03d1594::tone {
    struct TONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONE>(arg0, 6, b"TONE", b"Tone AI", x"546f6e6520416c20656d657267657320617320612070696f6e656572696e6720666f7263652c207265766f6c7574696f6e697a696e6720686f77206172746966696369616c20696e74656c6c6967656e636520696e746567726174657320696e746f206f7572206c697665732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736061172708.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

