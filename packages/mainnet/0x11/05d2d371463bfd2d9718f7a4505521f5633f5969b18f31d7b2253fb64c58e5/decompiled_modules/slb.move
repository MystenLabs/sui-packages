module 0x1105d2d371463bfd2d9718f7a4505521f5633f5969b18f31d7b2253fb64c58e5::slb {
    struct SLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB>(arg0, 6, b"SLB", b"SUILOVESBrazil", b"buy this ti support brazil flooding affected hard situation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmP2G2GZQWxt8mS5AfMbG8B2oWTHsTtVtp9WRkzNoqY4mu?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB>>(v2, @0x4fd8d8c85c9bf680f9dfab5110deec9c642a7ea88f15c918bed5cea422b294fc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

