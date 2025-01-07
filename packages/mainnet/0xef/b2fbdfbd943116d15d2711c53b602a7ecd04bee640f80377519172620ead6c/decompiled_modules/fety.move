module 0xefb2fbdfbd943116d15d2711c53b602a7ecd04bee640f80377519172620ead6c::fety {
    struct FETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FETY>(arg0, 9, b"FETY", b"FettyCoin", x"476574206c6f6164656420776974682074686520686f7474657374206e6577206d656d6520636f696e20746f2068697420746865206d61726b65742e20596f75e280996c6c206265206f6e20636c6f756420392077697468207468652046657474792c207768656e20697420676f65732031303030582e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b67e125a-2a59-44ca-a720-edd8d4a2a1c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

