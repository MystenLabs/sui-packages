module 0x7a180fd41cc4e81deb4c7719eb4f3b2cbdd7988d436ff34d49feed3bdf82f75e::yiy {
    struct YIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIY>(arg0, 9, b"YIY", b"YiYis", b"My little daughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96718a23-c9f5-4881-a870-b26316b1060f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

