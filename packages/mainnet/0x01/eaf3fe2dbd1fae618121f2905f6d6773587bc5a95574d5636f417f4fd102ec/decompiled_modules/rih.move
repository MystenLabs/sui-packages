module 0x1eaf3fe2dbd1fae618121f2905f6d6773587bc5a95574d5636f417f4fd102ec::rih {
    struct RIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIH>(arg0, 9, b"RIH", b"RIPHAMSTER", x"536b616d20f09f90b968616d7374657220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b066624-33ea-42f6-90a7-f12683a0cae0-IMG_1066.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIH>>(v1);
    }

    // decompiled from Move bytecode v6
}

