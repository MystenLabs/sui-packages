module 0xa83ca3f07f71a305b103483399cf6b38576adb97800e8f33faf9199ba01dd34c::pusa {
    struct PUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSA>(arg0, 9, b"PUSA", b"PepeUSA", b"Pepe USA stands guard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06b5a4e7-4497-4684-8d5b-be162b3afbec-IMG_1345.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

