module 0xc6b25bce63c7092d2c52a6b127189c9daa21f2faf90047226fbbe23aa76a50b1::fsdg {
    struct FSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDG>(arg0, 9, b"FSDG", b"FD", b"DGSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3119d84-ad98-4bee-9b09-a847cdf3013c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

