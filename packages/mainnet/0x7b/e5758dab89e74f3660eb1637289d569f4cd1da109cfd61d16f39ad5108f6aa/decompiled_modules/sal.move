module 0x7be5758dab89e74f3660eb1637289d569f4cd1da109cfd61d16f39ad5108f6aa::sal {
    struct SAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL>(arg0, 9, b"SAL", b"SALAMANDER", b"Axiloti the Salamander on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2d64c05-ac71-4c59-84bc-4cfdb2b6f852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

