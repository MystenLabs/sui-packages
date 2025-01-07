module 0x3dc7e23c6f039f891a8cd466fbc7f5cae82b1578c5c8a0e9379144ff1e31c1ce::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 9, b"ICE", b"IceTea", b"Meme ice tea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/848894d0-c6bc-4556-861d-c92eba484337.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

