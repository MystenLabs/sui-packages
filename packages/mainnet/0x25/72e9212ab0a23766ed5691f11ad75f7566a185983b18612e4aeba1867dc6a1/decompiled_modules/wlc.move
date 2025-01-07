module 0x2572e9212ab0a23766ed5691f11ad75f7566a185983b18612e4aeba1867dc6a1::wlc {
    struct WLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLC>(arg0, 6, b"WLC", b"WE LOVE COFFEE", x"0a22466f7220636f66666565206c6f766572733a206d6179206561636820637570206265206120627265616b2066756c6c206f662061726f6d612c20666c61766f7220616e6420696e737069726174696f6e2e20416674657220616c6c2c20636f66666565206973206e6f74206a7573742061206472696e6b2c2069742069732061206d6f6d656e74206f6620636f6e6e656374696f6e207769746820796f757273656c6620616e642074686520776f726c642e20e29895efb88fe29da4efb88f22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733380731226.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

