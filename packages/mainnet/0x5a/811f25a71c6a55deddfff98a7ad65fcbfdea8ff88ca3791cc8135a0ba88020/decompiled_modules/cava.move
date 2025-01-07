module 0x5a811f25a71c6a55deddfff98a7ad65fcbfdea8ff88ca3791cc8135a0ba88020::cava {
    struct CAVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVA>(arg0, 6, b"CAVA", b"Bruxo", x"4e6f2063616c6f7220646520756d206a6f676f20646563697369766f2c20616f73203432206d696e75746f7320646f20736567756e646f2074656d706f2c20526f6e616c64696e686f204761c3ba63686f2066616c61207061726120416c6fc3ad73696f204368756c617061205b204361766120756d612046616c74612c204361766120756d612046616c74612071756520c3a920676f6c205d202c204368756c61706120736f66726520756d612066616c7461206e61206672656e7465206461206772616e646520c3a17265612e20436f6d20612063616c6d6120646520756d204d61676f2c20526f6e616c64696e686f20706f736963696f6e612061", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734141067757.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

