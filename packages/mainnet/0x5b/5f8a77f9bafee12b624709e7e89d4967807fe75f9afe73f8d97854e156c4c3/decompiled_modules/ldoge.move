module 0x5b5f8a77f9bafee12b624709e7e89d4967807fe75f9afe73f8d97854e156c4c3::ldoge {
    struct LDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOGE>(arg0, 9, b"LDOGE", b"LITTLE DOG", b"Little Dog is a meme of the Sui community on WAVE POINT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aff866ea-8cdf-4d4d-8a08-9190752aef60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

