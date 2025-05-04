module 0x87b23d57a239e96d36b3758312ded50261c23f4588826e04a9a0fe3ca157abc1::boofus {
    struct BOOFUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOFUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOFUS>(arg0, 9, b"BOOF", b"Boofus", b"The bliss of blissful ignorance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawqb3nbpxlg7rc3k2glxldm5ihmc5cqbtfwiqd6hyqxalcq2owja")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOFUS>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOFUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOFUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

