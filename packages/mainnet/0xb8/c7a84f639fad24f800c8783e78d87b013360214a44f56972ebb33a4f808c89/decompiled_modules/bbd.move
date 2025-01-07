module 0xb8c7a84f639fad24f800c8783e78d87b013360214a44f56972ebb33a4f808c89::bbd {
    struct BBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBD>(arg0, 9, b"BBD", b"Baby Dog", x"4261627920446f67206861686120f09f90b6f09f90b6f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/196c550b-f821-4772-9162-43644aab8c7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

