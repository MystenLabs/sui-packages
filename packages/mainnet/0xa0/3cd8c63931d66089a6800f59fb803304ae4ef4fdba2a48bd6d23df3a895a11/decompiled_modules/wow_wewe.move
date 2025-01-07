module 0xa03cd8c63931d66089a6800f59fb803304ae4ef4fdba2a48bd6d23df3a895a11::wow_wewe {
    struct WOW_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW_WEWE>(arg0, 9, b"WOW_WEWE", b"Wowwewe", x"f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b01fce5-2a86-4b7e-bb90-a7f2fc159220.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

