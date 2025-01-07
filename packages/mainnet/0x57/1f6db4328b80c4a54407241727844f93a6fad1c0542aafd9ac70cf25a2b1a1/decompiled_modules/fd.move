module 0x571f6db4328b80c4a54407241727844f93a6fad1c0542aafd9ac70cf25a2b1a1::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 9, b"FD", b"Fi de", x"4669646520c491e1baa16920c491e1babf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc30c4c8-dad2-48ce-ad05-3585f9d1189b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

