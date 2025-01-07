module 0x6145f4620f6d14464dfe75b77e19204487ab156f5e1a3f62d400e025816504b8::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SMILEDOG", b"A SMILEDOG memecoin is a token created by a young man called ICT boy in wuro-gude, Mubi, Adamawa state of Ni geria. He want his token 'SMILEDOG' to be widely accepted and traded worldwide. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02f57525-0cd6-4507-baf5-4048eced96c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

