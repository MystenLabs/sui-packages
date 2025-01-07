module 0xcb0fa73e9894c7bb093604aa454014ceaba003d7882caa25c4e52451166df756::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 9, b"FF", b"FutureFi", b"FutureFi is a vibrant and futuristic meme coin with a cosmic design, symbolizing the synergy between technology and financial innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c17dfab-0e57-4393-99a7-3efde0e64859.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FF>>(v1);
    }

    // decompiled from Move bytecode v6
}

