module 0x50c388e9e2bd949f664dddcff1f5fc6cf9d29499235517c6b311cd3cc063237b::pxsui {
    struct PXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXSUI>(arg0, 9, b"PXSUI", b"Pixel Sui", b"Pixel life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24413d27-8a1b-4cec-ad4a-714da82699e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

