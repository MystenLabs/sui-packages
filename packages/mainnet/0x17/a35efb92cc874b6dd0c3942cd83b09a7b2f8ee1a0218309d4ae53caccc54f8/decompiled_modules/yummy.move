module 0x17a35efb92cc874b6dd0c3942cd83b09a7b2f8ee1a0218309d4ae53caccc54f8::yummy {
    struct YUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMMY>(arg0, 6, b"Yummy", b"Yummy ", x"59756d207468652066636b206f7574202459554d0a707574206f6e20796f757220535549676c6173736573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955370163.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

