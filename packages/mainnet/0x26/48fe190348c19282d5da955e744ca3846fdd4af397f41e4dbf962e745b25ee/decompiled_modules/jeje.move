module 0x2648fe190348c19282d5da955e744ca3846fdd4af397f41e4dbf962e745b25ee::jeje {
    struct JEJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEJE>(arg0, 6, b"JEJE", b"JEJE TOKEN", x"4a6f696e204e6f772e68747470733a2f2f6a656a65636f696e7375692e7669700a68747470733a2f2f782e636f6d2f4a656a65436f696e5f5375690a68747470733a2f2f742e6d652f4a656a655375695f506f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_3_9ed79c1b24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

