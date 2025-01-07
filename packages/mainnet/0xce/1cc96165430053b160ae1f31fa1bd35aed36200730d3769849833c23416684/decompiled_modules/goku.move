module 0xce1cc96165430053b160ae1f31fa1bd35aed36200730d3769849833c23416684::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"Goku On Sui", x"476f6b75204a6f696e73207468652053756920426c6f636b636861696e20556e697665727365212057687920476f6b753f20576879205375693f204b612e2e2e204d652e2e2e2048612e2e2e204d652e2e2e204841210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e5c9b275_8018_42c7_9dce_e98b837bf709_8f99a2c7ee_5f9901b0d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

