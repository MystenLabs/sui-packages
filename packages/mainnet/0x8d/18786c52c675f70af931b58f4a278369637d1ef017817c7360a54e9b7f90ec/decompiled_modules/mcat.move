module 0x8d18786c52c675f70af931b58f4a278369637d1ef017817c7360a54e9b7f90ec::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 9, b"MCAT", b"Meme", b"Hahaha bauiaha. Auajaja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bd0df80-3a1a-4843-a98c-64bd2e2bc519.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

