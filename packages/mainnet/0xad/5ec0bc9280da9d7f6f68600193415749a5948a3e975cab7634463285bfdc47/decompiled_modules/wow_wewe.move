module 0xad5ec0bc9280da9d7f6f68600193415749a5948a3e975cab7634463285bfdc47::wow_wewe {
    struct WOW_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW_WEWE>(arg0, 9, b"WOW_WEWE", b"Wowwewe", x"f09f8cb6efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/daf2ea70-9c27-4fa0-af73-0b1f7a70066e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

