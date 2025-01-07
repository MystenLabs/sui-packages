module 0x4769b07403b8cb1b931a903d6d32dbc81d22c0097497c6ad3df2d49a4eeca250::mok {
    struct MOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOK>(arg0, 9, b"MOK", b"Monkey", b"naughty monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee9af9ad-36cc-4d25-83ae-2c4c5950c7c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

