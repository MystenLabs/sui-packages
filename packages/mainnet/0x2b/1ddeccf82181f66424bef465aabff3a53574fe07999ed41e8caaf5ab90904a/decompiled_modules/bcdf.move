module 0x2b1ddeccf82181f66424bef465aabff3a53574fe07999ed41e8caaf5ab90904a::bcdf {
    struct BCDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCDF>(arg0, 9, b"BCDF", b"Bvcd", b" Xxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6efdc62c-5fff-48e6-8fff-86e44ec30647.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

