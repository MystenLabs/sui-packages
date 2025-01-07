module 0x2e28ba8189b24b9ce4f8e77a6fa018f857e34f2b7b6e8eec6252be84ad0be14b::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SuiTrump", x"235375695472756d70206f6e20737569206865726520746f206d616b652063727970746f20677265617420616761696e2e0a0a4a6f696e2075732c206f7220646f6e27742e20456974686572207761792c20697427732068617070656e696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/767af5b0_0c32_4bdb_a34d_1ead3b0e7ad9_b094530eb7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

