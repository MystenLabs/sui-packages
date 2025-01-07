module 0xf8a6a18e5571399c47956cffc5470d7c24de375826326569201cd2f5b89408cf::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"Bitcoin", x"4561726e204672656520426974636f696e20457665727920446179200a68747470733a2f2f656d62657266756e642e6f6e656c696e6b2e6d652f6c6a54492f62636533333239302f3f6d696e696e675f72656665727265725f69643d4d4e474146384d50504841", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Btcpill_dfd8aff1d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

