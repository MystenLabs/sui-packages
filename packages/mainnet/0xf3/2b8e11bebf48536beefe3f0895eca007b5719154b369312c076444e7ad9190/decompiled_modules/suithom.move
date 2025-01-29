module 0xf32b8e11bebf48536beefe3f0895eca007b5719154b369312c076444e7ad9190::suithom {
    struct SUITHOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITHOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITHOM>(arg0, 6, b"SUITHOM", b"Sui on Panthom", x"57656c636f6d6520746f202453554954484f4d20e280932054686520467574757265206f662043727970746f206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738161399981.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITHOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITHOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

