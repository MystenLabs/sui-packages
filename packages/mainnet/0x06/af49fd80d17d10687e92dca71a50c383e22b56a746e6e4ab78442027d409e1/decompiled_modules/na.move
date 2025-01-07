module 0x6af49fd80d17d10687e92dca71a50c383e22b56a746e6e4ab78442027d409e1::na {
    struct NA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NA>(arg0, 9, b"NA", b"Nude ai", b"Introducing the advanced feature of our merger of blockchain with AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/358ab569-184e-4c5f-8b29-4026724490ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NA>>(v1);
    }

    // decompiled from Move bytecode v6
}

