module 0x4a89767129ba1dc8fc2f1c48df2a9633631d13cae74b8fb826dd4edfb02c00e0::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 9, b"MOO", b"MooDeng", b"1000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b60cb764-ba10-41d8-b4e4-b01e3375d648.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

