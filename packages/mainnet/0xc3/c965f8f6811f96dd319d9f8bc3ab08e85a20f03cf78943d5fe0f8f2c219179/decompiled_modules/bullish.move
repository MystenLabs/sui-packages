module 0xc3c965f8f6811f96dd319d9f8bc3ab08e85a20f03cf78943d5fe0f8f2c219179::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 6, b"BULLISH", b" BULLFLAG ON SUI", x"546865205355492042756c6c20466c6167206973206d6f7265207468616e20612073796d626f6ce280946974e2809973207468652072616c6c79696e672063616c6c20666f72206f757220636f6d6d756e69747920746f20707573682068696768657220616e64207374726f6e6765722e204974206d61726b732074686520636f6e74696e756174696f6e206f6620612062756c6c697368206a6f75726e657920696e20696e6e6f766174696f6e2c20656d706f7765726d656e742c20616e6420756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737461958314.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

