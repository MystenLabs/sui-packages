module 0xbc2c776594e8b73c2707a064bd0cb790df58bf8988e95561daf4bd8fd80c4658::pkh {
    struct PKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKH>(arg0, 9, b"PKH", b"HDA", b"EU and I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ccf46bd-0825-40b5-ba0e-eb59b2417f3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

