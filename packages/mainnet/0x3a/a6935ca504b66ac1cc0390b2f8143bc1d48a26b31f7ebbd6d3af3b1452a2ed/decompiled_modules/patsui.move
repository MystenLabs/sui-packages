module 0x3aa6935ca504b66ac1cc0390b2f8143bc1d48a26b31f7ebbd6d3af3b1452a2ed::patsui {
    struct PATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATSUI>(arg0, 6, b"PATSUI", b"PAT on Sui", x"5041542069732061206c6f7661626c6520636172746f6f6e2063617420616e6420746865206c6f79616c20636f6d70616e696f6e206f662050657065207468652046726f672c207769746820686973206f726967696e616c20686f757365206c6f6361746564206174207468652053554920636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_03_12_15_f1aef5448c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

