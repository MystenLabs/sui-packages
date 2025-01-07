module 0xfc18e7d4c5a69481f4dc33d3bbe341d702087296ac9cf74e7e212a72265d0821::pepedance {
    struct PEPEDANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDANCE>(arg0, 6, b"PEPEDANCE", b"PEPE DANCE", b"THIS IS THE ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731965490472.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEDANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

