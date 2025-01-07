module 0x97bc5f8a1873b0e6820554f7982af450e125657292c3c89dc0f0e34c22c9f64b::mudi {
    struct MUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDI>(arg0, 9, b"MUDI", b"Mudi", b"The first Dog memecoin under Sui Ecosystem which is very intelligent and very lively. My Dog lover come support this wonderful community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb3a288b-3188-4f94-b1b1-7923f71abd7b-IMG_6553.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

