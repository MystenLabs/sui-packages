module 0x79e267fa467ecbde120595bb8aa88125f63fd80c26c28634842b6bec78974ec4::moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDAY>(arg0, 6, b"MOONDAY", b"MOON.DAY ON TURBOS", x"4865726520776520676f2c20636f6d6520746f206d616b65204465466920f09f9a80f09f8c91", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972449528.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONDAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

