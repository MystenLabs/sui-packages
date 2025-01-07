module 0x439f6eb7d3ed96a6b3844a69c70e3838d606e9c52868d47a40c23eacf073ddb9::unix {
    struct UNIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIX>(arg0, 9, b"UNIX", b"Uranix ", b"The ticker is $UNIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1eb97039-e1ce-411c-a267-a18121dc2817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

