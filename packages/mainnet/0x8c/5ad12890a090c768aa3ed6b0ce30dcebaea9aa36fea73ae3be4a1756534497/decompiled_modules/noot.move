module 0x8c5ad12890a090c768aa3ed6b0ce30dcebaea9aa36fea73ae3be4a1756534497::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"Noot Coin", x"48692c2049276d204e4f4f542e20496d207468652077696c646573742c20736c69636b6573742c20616e64206d6f7374206c6567656e646172792070656e6775696e20696e207468652077686f6c6520416e746172637469632e2057656c636f6d6520746f206d792069676c6f6f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_V4_Rt_PR_Hd_Aju_SE_5c_Pij_Yo_An_TE_Uk3_NH_Jp3_Rox_C_Cqppump_7_a91504c226_ef239e94d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

