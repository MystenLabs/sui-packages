module 0x4ee04771f185a3e1754ba9c838254e245b3d7a6a1db1a7211012aa0bc8278b8::richstone {
    struct RICHSTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHSTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHSTONE>(arg0, 9, b"RICHSTONE", b"Rich Stone", b"rich stone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d12a50ce-5260-4f63-9577-b1d8adac7887.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHSTONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHSTONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

