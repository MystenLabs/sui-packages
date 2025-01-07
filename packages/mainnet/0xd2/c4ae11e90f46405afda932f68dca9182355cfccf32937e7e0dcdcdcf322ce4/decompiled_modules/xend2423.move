module 0xd2c4ae11e90f46405afda932f68dca9182355cfccf32937e7e0dcdcdcf322ce4::xend2423 {
    struct XEND2423 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEND2423, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEND2423>(arg0, 9, b"XEND2423", b"Xend", b"A native token for xend application ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6db5d64a-9af5-44e0-8b4c-d037c4e68873.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEND2423>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEND2423>>(v1);
    }

    // decompiled from Move bytecode v6
}

