module 0x408060099e7931e70cb0c11292ca3185177e78e56b2ce853b8eb9bbc7102b315::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"lololol", b"laughter is fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9120f0ca-c112-4b6c-8d85-f75009246cda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

