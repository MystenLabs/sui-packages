module 0xeb222e1c20f82977d0ecd2151f3f91d86489153ddf17bab3d1d41f902189c9f4::gau {
    struct GAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAU>(arg0, 9, b"GAU", b"MINIDOG", b"mischievous adorable dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee5491de-a197-45fb-9438-b2229c548f7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

