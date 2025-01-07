module 0x89283452848b57c9048d330715346ab4d32edf7d22049adbf42f4fa5c05d4c01::btp {
    struct BTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTP>(arg0, 9, b"BTP", b"BitPlus", b"Killer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTP>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

