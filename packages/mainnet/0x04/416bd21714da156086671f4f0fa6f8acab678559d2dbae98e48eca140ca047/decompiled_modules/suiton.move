module 0x4416bd21714da156086671f4f0fa6f8acab678559d2dbae98e48eca140ca047::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Suiton", x"24537569746f6e2073756d6d6f6e656420696e746f202453554920626c6f636b636861696e2054473a2068747470733a2f2f742e6d652f737569746f6e6973740a3078313334613031343264393535393663616266636232353032303832393433373361396566343838396464393761353930636364653831653430303335663463663a3a737569746f6e733a3a535549544f4e53", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734410446812.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

