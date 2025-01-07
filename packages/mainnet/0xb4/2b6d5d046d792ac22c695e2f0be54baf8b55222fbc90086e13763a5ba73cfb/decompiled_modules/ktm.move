module 0xb42b6d5d046d792ac22c695e2f0be54baf8b55222fbc90086e13763a5ba73cfb::ktm {
    struct KTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTM>(arg0, 9, b"KTM", b"Katome", b"Katome Ritsu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/690deece-92ec-428f-8445-3817e32a45a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

