module 0x3a140edd6307cf467abfd96958c5dfef7247f62eb15253deddf6a240c436ba71::micdog {
    struct MICDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MICDOG>(arg0, 6, b"MICDOG", b"Micdog by SuiAI", b"Migdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2025_01_05_10_09_17_23ed9f80f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MICDOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICDOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

