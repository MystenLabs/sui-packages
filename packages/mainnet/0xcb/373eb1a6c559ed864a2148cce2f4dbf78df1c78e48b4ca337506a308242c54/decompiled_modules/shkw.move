module 0xcb373eb1a6c559ed864a2148cce2f4dbf78df1c78e48b4ca337506a308242c54::shkw {
    struct SHKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHKW>(arg0, 9, b"SHKW", b"bdjd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7043f131-0ef7-49fe-b991-f81f2bd3e4e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

