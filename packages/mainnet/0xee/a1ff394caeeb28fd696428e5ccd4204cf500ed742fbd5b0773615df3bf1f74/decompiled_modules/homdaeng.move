module 0xeea1ff394caeeb28fd696428e5ccd4204cf500ed742fbd5b0773615df3bf1f74::homdaeng {
    struct HOMDAENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMDAENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMDAENG>(arg0, 6, b"HOMDAENG", b"Homdaeng on SUI", x"49276d20537570657220484f5420616e64205350494359595921212120f09fa69b20f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957912825.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMDAENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMDAENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

