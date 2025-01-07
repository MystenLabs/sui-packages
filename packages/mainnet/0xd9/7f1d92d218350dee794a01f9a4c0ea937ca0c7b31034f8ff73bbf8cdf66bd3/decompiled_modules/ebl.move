module 0xd97f1d92d218350dee794a01f9a4c0ea937ca0c7b31034f8ff73bbf8cdf66bd3::ebl {
    struct EBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBL>(arg0, 9, b"EBL", b"EBAL", b"Best token ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f28f5993-753f-4165-95ea-3bb0d23463b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

