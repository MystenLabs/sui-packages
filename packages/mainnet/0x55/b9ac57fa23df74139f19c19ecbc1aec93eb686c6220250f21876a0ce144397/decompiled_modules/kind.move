module 0x55b9ac57fa23df74139f19c19ecbc1aec93eb686c6220250f21876a0ce144397::kind {
    struct KIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIND>(arg0, 9, b"KIND", b"Kindly tok", b"This token is created to help the poor. Be kind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eb1efde-df61-4dc2-976b-d09b671ad6fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

