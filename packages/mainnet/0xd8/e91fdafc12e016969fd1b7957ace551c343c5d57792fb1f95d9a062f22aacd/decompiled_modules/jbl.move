module 0xd8e91fdafc12e016969fd1b7957ace551c343c5d57792fb1f95d9a062f22aacd::jbl {
    struct JBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBL>(arg0, 9, b"JBL", b"Jabulaz", b"Jinggghhkal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8e93e72-6524-4e0e-ae3a-4be5b81981ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

