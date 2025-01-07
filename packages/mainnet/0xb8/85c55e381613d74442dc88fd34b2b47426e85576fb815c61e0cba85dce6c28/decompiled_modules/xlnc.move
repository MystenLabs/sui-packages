module 0xb885c55e381613d74442dc88fd34b2b47426e85576fb815c61e0cba85dce6c28::xlnc {
    struct XLNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLNC>(arg0, 9, b"XLNC", b"EXCELLENCY", b"Coin name traced back to the century of a good man name excellency, he is loved and known for his philanthropy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7291b34f-68e6-477a-b5dc-16b5002eafa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

