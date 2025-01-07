module 0x55077af418fcc80af358cf99a9d439a61c661237b17c373bb64c8191455b5496::izi {
    struct IZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZI>(arg0, 9, b"IZI", b"Izi CAT", b"This is IZI CAT. Token IZI allows you to feed homeless cats around the world. Bringing goodness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c509acfd-43ff-4cd2-a0b9-1f5d71e80528.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

