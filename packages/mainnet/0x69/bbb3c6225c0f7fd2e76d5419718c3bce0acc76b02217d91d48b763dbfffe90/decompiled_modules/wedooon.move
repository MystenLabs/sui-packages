module 0x69bbb3c6225c0f7fd2e76d5419718c3bce0acc76b02217d91d48b763dbfffe90::wedooon {
    struct WEDOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOOON>(arg0, 9, b"WEDOOON", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acb6921d-810b-4151-9d87-26ae130cffe4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

