module 0xfe31b855cb454e14a95198228fed37b8a5a7789bbea7222e3acba0333316040a::munch {
    struct MUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNCH>(arg0, 9, b"MUNCH", b"MemeMunch", b"a snackable token that keeps the crypto community laughing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47411a68-bd84-4812-afd7-12f7924d0f5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

