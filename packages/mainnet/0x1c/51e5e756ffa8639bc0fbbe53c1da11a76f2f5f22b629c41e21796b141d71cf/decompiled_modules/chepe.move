module 0x1c51e5e756ffa8639bc0fbbe53c1da11a76f2f5f22b629c41e21796b141d71cf::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"Chepe", b"Chad Pepe", b"LAUNCHING TODAY 18:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731387686037.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

