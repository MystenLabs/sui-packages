module 0x9bc83a5ae89e31178b6973afabdee76a2dbd9adb17411bf00ecff17b4708c8c4::usdtn {
    struct USDTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTN>(arg0, 9, b"USDTN", b"ERRORS", b"404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/958ef527-55e5-4c60-97de-3b4e863057ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

