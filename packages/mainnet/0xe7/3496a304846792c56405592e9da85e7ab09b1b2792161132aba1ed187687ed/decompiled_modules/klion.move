module 0xe73496a304846792c56405592e9da85e7ab09b1b2792161132aba1ed187687ed::klion {
    struct KLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLION>(arg0, 6, b"KLion", b"KingLion", x"546865206e6f7374616c67696320726f626f74204b696e67204c696f6e207265666c6563747320612066757475726520776865726520726f626f747320706c617920616e20696e74656772616c20726f6c6520696e206f7572207265616c6974792e0a4c6574732070726f74656374204561727468207769746820726f626f7473210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_19_13_53_49_7318eae0b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

