module 0x4f278614b37886cea693060efee8779ec20c3e0e2ed47c5667030b6a09e6f11d::nbull {
    struct NBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBULL>(arg0, 9, b"NBULL", b"NOV BULL", b"\"This is just a meme in November.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80bd1ec1-0aeb-4162-815a-21f122a3b7ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

