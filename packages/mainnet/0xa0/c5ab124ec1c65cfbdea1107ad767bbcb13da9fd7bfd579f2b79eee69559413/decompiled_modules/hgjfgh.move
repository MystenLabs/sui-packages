module 0xa0c5ab124ec1c65cfbdea1107ad767bbcb13da9fd7bfd579f2b79eee69559413::hgjfgh {
    struct HGJFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGJFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGJFGH>(arg0, 9, b"HGJFGH", b"ASDASD", b"SDFGSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fdb7b3e-f6b3-4394-aeeb-f46e743f1c8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGJFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGJFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

