module 0x1af573ceac0f17e6939f308aff46b652321bdc417b537a55e2a2e32a7fac2b2d::chb_1234 {
    struct CHB_1234 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHB_1234, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHB_1234>(arg0, 9, b"CHB_1234", b"CHB", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e218527-24f1-4a22-93b9-e43b7aad5eeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHB_1234>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHB_1234>>(v1);
    }

    // decompiled from Move bytecode v6
}

