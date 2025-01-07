module 0x4674b2691cf448d4046dbb4bb37fd597d82f2026a7d5520fcd3a9c4db975c2c5::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"BLUECATSUI", b"cute cat from sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956908370.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

