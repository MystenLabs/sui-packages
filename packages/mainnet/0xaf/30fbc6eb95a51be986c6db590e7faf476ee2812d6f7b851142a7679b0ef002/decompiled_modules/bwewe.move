module 0xaf30fbc6eb95a51be986c6db590e7faf476ee2812d6f7b851142a7679b0ef002::bwewe {
    struct BWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWEWE>(arg0, 9, b"BWEWE", b"Baby Wewe", b"The channel is dedicated to the cute baby wewe for joy and fun. May baby wewe bring good luck and happiness to everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27073dbe-55ce-4a7f-9a8b-f13cae1705e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

