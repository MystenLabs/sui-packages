module 0x999747361399646a97befcf78c21a91f91347015825fe0f68c8abf88a693c402::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SMILEDOG", b"A SMILEDOG memecoin is a token created by a young man called ICT boy in wuro-gude, Mubi, Adamawa state of Ni geria. He want his token 'SMILEDOG' to be widely accepted and traded worldwide. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b77cdfe-4fac-49ce-acf9-8ae8638f0a8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

