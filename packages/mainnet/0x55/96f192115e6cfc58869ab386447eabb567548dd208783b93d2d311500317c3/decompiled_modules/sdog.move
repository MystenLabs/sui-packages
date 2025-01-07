module 0x5596f192115e6cfc58869ab386447eabb567548dd208783b93d2d311500317c3::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SMILEDOG", b"A SMILEDOG memecoin is a token created by a young man called ICT boy in wuro-gude, Mubi, Adamawa state of Ni geria. He want his token 'SMILEDOG' to be widely accepted and traded worldwide. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4badc77f-9a28-432b-a02f-9f036f069137.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

