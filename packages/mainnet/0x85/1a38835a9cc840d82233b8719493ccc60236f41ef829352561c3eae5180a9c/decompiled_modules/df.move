module 0x851a38835a9cc840d82233b8719493ccc60236f41ef829352561c3eae5180a9c::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 9, b"DF", b"KJH", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a83b1a1-01e5-40d4-91da-6b32f3f77644.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
    }

    // decompiled from Move bytecode v6
}

