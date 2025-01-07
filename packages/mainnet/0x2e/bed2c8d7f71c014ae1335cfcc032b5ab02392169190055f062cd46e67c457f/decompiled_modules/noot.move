module 0x2ebed2c8d7f71c014ae1335cfcc032b5ab02392169190055f062cd46e67c457f::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"Noot Coin", x"48692c2049276d204e4f4f542e0a0a496d207468652077696c646573742c20736c69636b6573742c20616e64206d6f7374206c6567656e646172792070656e6775696e20696e207468652077686f6c6520416e746172637469632e2057656c636f6d6520746f206d792069676c6f6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_V4_Rt_PR_Hd_Aju_SE_5c_Pij_Yo_An_TE_Uk3_NH_Jp3_Rox_C_Cqppump_7_a91504c226.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

