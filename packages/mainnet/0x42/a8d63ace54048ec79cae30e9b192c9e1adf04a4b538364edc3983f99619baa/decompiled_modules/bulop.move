module 0x42a8d63ace54048ec79cae30e9b192c9e1adf04a4b538364edc3983f99619baa::bulop {
    struct BULOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULOP>(arg0, 9, b"BULOP", b"uiop", b"thr new meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca413f91-8492-4235-85c3-512d7fd13de9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

