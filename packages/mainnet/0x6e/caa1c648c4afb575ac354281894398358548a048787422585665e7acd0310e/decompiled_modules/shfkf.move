module 0x6ecaa1c648c4afb575ac354281894398358548a048787422585665e7acd0310e::shfkf {
    struct SHFKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHFKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHFKF>(arg0, 9, b"SHFKF", b"Susjw", b"Lvjdjdk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecc2fb58-1734-46e0-9958-374dff618629.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHFKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHFKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

