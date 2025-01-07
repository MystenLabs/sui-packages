module 0x72f2f634732b586ed2c57e50824552afaae0bcfa7f0b492339d06ed364dce2d0::wow_wewe {
    struct WOW_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW_WEWE>(arg0, 9, b"WOW_WEWE", b"Wowwewe", x"f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f660973-f69e-4d7f-9638-d5e9cc080d71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

