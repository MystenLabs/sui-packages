module 0x2fe8a09e2eb7b168939d7380fca02b590f71d12e33edc17b785234d7637c6b4b::bmj {
    struct BMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMJ>(arg0, 9, b"BMJ", b"Javad", b"For the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bf3fe67-b3a8-4f92-93f2-9300d075dea6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

