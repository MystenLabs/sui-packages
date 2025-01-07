module 0xa631edc94d20b21695fb1149bdb146217e4cf0f5d106f8ee1021e68bcb23bf13::izi {
    struct IZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZI>(arg0, 9, b"IZI", b"Izi CAT", b"This is IZI CAT. Token IZI allows you to feed homeless cats around the world. Bringing goodness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5086ad7a-8f05-4950-98f7-c494c8c0feae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

