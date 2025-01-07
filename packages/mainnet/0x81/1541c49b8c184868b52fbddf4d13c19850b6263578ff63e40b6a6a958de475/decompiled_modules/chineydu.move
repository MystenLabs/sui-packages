module 0x811541c49b8c184868b52fbddf4d13c19850b6263578ff63e40b6a6a958de475::chineydu {
    struct CHINEYDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINEYDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINEYDU>(arg0, 9, b"CHINEYDU", b"Chipunk", b"Friendly guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d4f1ec0-1bea-42c1-a57a-e3b27bbc6ea8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINEYDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINEYDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

