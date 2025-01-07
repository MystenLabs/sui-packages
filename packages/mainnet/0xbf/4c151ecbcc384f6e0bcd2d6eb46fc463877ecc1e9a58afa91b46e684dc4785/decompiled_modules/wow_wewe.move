module 0xbf4c151ecbcc384f6e0bcd2d6eb46fc463877ecc1e9a58afa91b46e684dc4785::wow_wewe {
    struct WOW_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW_WEWE>(arg0, 9, b"WOW_WEWE", b"Wowwewe", x"f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da00e253-ae03-4589-8ed1-c7d1ab292ab5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

