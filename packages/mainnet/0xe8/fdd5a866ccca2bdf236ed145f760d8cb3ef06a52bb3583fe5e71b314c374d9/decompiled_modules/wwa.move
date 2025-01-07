module 0xe8fdd5a866ccca2bdf236ed145f760d8cb3ef06a52bb3583fe5e71b314c374d9::wwa {
    struct WWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWA>(arg0, 9, b"WWA", b"Wood", b"Wood the best meme ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7625661-f99f-4dc2-8528-734d37ca6e83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

