module 0xe67d103a6ae9bbdd288d6ce82c78a6e623136374afe3fe1efcc0595121bcf0af::llap {
    struct LLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAP>(arg0, 6, b"LLAP", b"Living like a pengui", x"4c6976696e67206c696b6520612070656e6775696e3a20796f75e28099726520616c7761797320726561647920746f207374617274207468652064617920776974682062696720706c616e732c20627574207468656e20796f75206a7573742077616c6b2061726f756e642c20736c697070696e6720696e2074686520636f6c6420776f726c642e205468652062657374207468696e6720697320746f20656e6a6f79207468652070726f636573732c206576656e20696620796f7520646f6ee2809974206163636f6d706c6973682065766572797468696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732382812796.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

