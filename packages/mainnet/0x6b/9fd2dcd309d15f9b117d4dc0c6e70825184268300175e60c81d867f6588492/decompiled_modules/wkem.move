module 0x6b9fd2dcd309d15f9b117d4dc0c6e70825184268300175e60c81d867f6588492::wkem {
    struct WKEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKEM>(arg0, 9, b"WKEM", b"bdnd", b"djnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3afa05d9-d494-44dd-9d77-0c1143d5c573.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

