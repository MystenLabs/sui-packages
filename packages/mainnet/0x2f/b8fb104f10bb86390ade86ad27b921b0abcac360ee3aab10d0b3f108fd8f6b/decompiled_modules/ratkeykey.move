module 0x2fb8fb104f10bb86390ade86ad27b921b0abcac360ee3aab10d0b3f108fd8f6b::ratkeykey {
    struct RATKEYKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATKEYKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATKEYKEY>(arg0, 9, b"RATKEYKEY", b"RATKEY", b"Rat for the key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9cd21bf-68e6-40c4-882c-7cb4b27cab62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATKEYKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATKEYKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

