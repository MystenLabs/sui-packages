module 0xe9ec9eee8908cd6c3e4d0f24660c61ea504a04c2adba16b37d1091187e8d255a::wtr {
    struct WTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTR>(arg0, 9, b"WTR", b"Water", b"The next 1000x meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a05c3f85-0d43-46ab-ba8e-615006e227ae-1000362514.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

