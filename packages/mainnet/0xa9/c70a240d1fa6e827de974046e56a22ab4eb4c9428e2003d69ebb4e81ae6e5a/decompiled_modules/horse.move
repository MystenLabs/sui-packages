module 0xa9c70a240d1fa6e827de974046e56a22ab4eb4c9428e2003d69ebb4e81ae6e5a::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 9, b"HORSE", b"Hrs", b"horse meme is the first memecoin  that is 100% community oriented", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22c57172-2758-4b46-9dd9-00b6764824c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

