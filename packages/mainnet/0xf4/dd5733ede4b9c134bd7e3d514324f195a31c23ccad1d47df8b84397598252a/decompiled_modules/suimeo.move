module 0xf4dd5733ede4b9c134bd7e3d514324f195a31c23ccad1d47df8b84397598252a::suimeo {
    struct SUIMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEO>(arg0, 9, b"SUIMEO", b"Suimeo cat", b"Rizz cat sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d945594b-f9da-4bd2-827b-7b1bd66966e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

