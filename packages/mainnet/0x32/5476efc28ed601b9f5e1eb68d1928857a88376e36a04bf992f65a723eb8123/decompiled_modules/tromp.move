module 0x325476efc28ed601b9f5e1eb68d1928857a88376e36a04bf992f65a723eb8123::tromp {
    struct TROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROMP>(arg0, 9, b"TROMP", b"Do lund tr", b"This is a meme coin of doland trump. Buy if you support doland trump. Trump 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49c33a6a-1664-4278-9d9b-6f05833f2693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

