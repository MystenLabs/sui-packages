module 0x727de7bf7baa807b951a52da436daadde0368282b6e1db026840b7585494800::cobra {
    struct COBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBRA>(arg0, 9, b"COBRA", b"CobraFi", b"Pump first, Pump hard, No mercy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dfaa32b-6c09-483a-be29-f4bfa9458b61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

