module 0x8e9187b49143e6071d8bdee63e34224a8e79fdaa6207d2d2ed54007c45936e0b::aya {
    struct AYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYA>(arg0, 6, b"AYA", b"Aya Asagiri", x"4179612041736167697269202d20616e2049636f6e6963204d656d6520616e64204368617261637465722066726f6d204d61676963616c204769726c2053697465202d205465617273206172652057617465722c204d616e6761206973204a6170616e6573652c20537569206973204a6170616e65736520666f72205761746572200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aya_with_sui_tear_aa38eb3d00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

