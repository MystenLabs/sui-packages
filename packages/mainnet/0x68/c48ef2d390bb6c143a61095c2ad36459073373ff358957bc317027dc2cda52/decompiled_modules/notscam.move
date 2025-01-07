module 0x68c48ef2d390bb6c143a61095c2ad36459073373ff358957bc317027dc2cda52::notscam {
    struct NOTSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSCAM>(arg0, 9, b"NOTSCAM", b"notscam", b"Only for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bac6993-c2c9-4424-b8b7-458fbbe741b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTSCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

