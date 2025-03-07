module 0x890409e3f5450a0f1cb866ad60fbb69ad9f35e3294b5df0a9ab98899e4e40d81::weo {
    struct WEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEO>(arg0, 9, b"WEO", b"Weewoo", b"Weewooweewoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c255cd9-daa3-4f9a-98ea-c03ae6f7aad3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

