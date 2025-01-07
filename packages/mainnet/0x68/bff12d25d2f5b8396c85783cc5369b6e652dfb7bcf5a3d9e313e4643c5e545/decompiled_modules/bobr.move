module 0x68bff12d25d2f5b8396c85783cc5369b6e652dfb7bcf5a3d9e313e4643c5e545::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"Bobr", x"42c3b3626572204b55525741", x"42c3b3626572204b555257412069732074686520666972737420706f6c697368206d656d6520636f696e206261736564206f6e202242c3b36272204b75727761204a612050696572646f6c652220696e7465726e6574206d656d652e0a436865636b2069743a2068747470733a2f2f7777772e796f75747562652e636f6d2f73686f7274732f5767593551356439534e51", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731622483916.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

