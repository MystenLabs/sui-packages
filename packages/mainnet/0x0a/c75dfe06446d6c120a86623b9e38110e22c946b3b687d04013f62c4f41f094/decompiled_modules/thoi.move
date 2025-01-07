module 0xac75dfe06446d6c120a86623b9e38110e22c946b3b687d04013f62c4f41f094::thoi {
    struct THOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOI>(arg0, 9, b"THOI", b"Nhen", b"My love dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b18ce861-c094-48a1-8ec3-a7af371b2984.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

