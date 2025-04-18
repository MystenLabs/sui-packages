module 0x892674cb975920a2a3193e6587fa60c428b2b6ac70cf12d09ae490f892978e83::dems {
    struct DEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMS>(arg0, 9, b"DEMS", b"DeMS-13", b"So we're calling them \"DeMS-13\" now, right?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8a6b5ed-51e2-4b42-8796-04e88a7400d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

