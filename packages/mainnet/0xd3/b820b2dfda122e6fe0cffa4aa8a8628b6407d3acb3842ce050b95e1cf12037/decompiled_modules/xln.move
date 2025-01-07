module 0xd3b820b2dfda122e6fe0cffa4aa8a8628b6407d3acb3842ce050b95e1cf12037::xln {
    struct XLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLN>(arg0, 9, b"XLN", b"xinliu", b"XLNNT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb90fe64-f6cd-4b77-871b-320040f92c10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

