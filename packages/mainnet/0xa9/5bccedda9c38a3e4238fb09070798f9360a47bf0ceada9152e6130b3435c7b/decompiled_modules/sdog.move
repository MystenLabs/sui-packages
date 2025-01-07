module 0xa95bccedda9c38a3e4238fb09070798f9360a47bf0ceada9152e6130b3435c7b::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SMILEDOG", b"A SMILEDOG memecoin is a token created by a young man called ICT boy in wuro-gude, Mubi, Adamawa state of Ni geria. He want his token 'SMILEDOG' to be widely accepted and traded worldwide. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87b98770-6d50-493d-be18-3b09a6067516.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

