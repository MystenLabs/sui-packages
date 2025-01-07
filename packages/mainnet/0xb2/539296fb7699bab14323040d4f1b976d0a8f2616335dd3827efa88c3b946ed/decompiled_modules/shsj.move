module 0xb2539296fb7699bab14323040d4f1b976d0a8f2616335dd3827efa88c3b946ed::shsj {
    struct SHSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHSJ>(arg0, 9, b"SHSJ", b"Hdj", b"Sjsj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9803e421-a9a5-4077-9cd1-c655b4d613dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

