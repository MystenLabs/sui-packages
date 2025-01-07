module 0x2777a5fd01baf11e5cbe5db0b44ac5a49a01a7c2372c41e996eac37a9d37a13f::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"GIA", b"The world is for digital currency So invest wisely Together! Because \"GIA\" will be a part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/747345b9-47e3-4f48-bea1-ca3f7f60c1f8-1000504028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

