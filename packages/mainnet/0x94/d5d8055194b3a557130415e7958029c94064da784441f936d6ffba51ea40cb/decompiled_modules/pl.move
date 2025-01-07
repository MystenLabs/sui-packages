module 0x94d5d8055194b3a557130415e7958029c94064da784441f936d6ffba51ea40cb::pl {
    struct PL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<PL>(arg0, 2, b"PL", b"PL Token", b"Happy PL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifq6ujjadgiwc24plf2u62jcxxznohf5y3dvr7zyev3ns3pxhfoju.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<PL>>(v1, @0x0);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PL>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PL>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

