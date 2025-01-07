module 0x794e418f2fe35ee1846253f32b247acd97139850549db71ee8597ac9730bb86a::zitty {
    struct ZITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZITTY>(arg0, 6, b"ZITTY", b"ZITTYS", b"Zitty In Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731868985163.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZITTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZITTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

