module 0xcbe24b540c92c6e0d45bb73baf74353652aac4228477b33fbdf24fbfb59d9bb::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZ>(arg0, 9, b"CATZ", b"CAT", b"MMOEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66e3c527-e5f8-4b83-a38c-0debbfa3314d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

