module 0xd0c09d325df7a7bf3b5d54bc6e848185d7b87a1ddb7669be110dd6e4763318aa::avi {
    struct AVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVI>(arg0, 9, b"AVI", b"Avijit", b"Hi wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/801e2068-656f-44d5-9e5e-bdedda171e4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

