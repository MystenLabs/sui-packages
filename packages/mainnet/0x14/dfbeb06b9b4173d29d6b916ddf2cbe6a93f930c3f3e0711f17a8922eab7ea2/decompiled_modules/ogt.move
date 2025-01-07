module 0x14dfbeb06b9b4173d29d6b916ddf2cbe6a93f930c3f3e0711f17a8922eab7ea2::ogt {
    struct OGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGT>(arg0, 9, b"OGT", b"Old Gate", b"ENTER THE OLD GATE WITH ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5492bf4-f02e-445d-88d8-8d61fa8aeadf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

