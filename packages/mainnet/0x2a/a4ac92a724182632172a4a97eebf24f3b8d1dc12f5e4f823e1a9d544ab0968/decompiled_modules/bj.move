module 0x2aa4ac92a724182632172a4a97eebf24f3b8d1dc12f5e4f823e1a9d544ab0968::bj {
    struct BJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BJ>(arg0, 6, b"BJ", b"Blue Jake", b"Every guy loves bjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_C1_A112_A_B68_F_4_B7_A_AB_21_40_C94_E2_E1_DA_6_bc95bb1ca1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

