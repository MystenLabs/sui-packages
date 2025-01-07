module 0xc8c532a624e99f4b92ad17c7045939787d83ac135e701db111d05f1727469133::sxrp {
    struct SXRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXRP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SXRP>(arg0, 6, b"SXRP", b"SUIXRP by SuiAI", b"Come I. The world who blockchain goes to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_9308_0f60401479.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SXRP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXRP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

