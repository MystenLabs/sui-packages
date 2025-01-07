module 0x1f6d250bcba658e7d288650d8857648c31ca4aa960d3d958841908c7fe5d3d8::huf {
    struct HUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUF>(arg0, 6, b"HUF", b"Huckleberry Fish", b"Huckleberry Fish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPLUknTRXrwJhafdZHsKGVKT22KLPJoahcPptFvt1K9nx?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUF>>(v2, @0x77c2d8e012cf157b90e8d71cafc72f228d4ac5bbae741cf8a8005535f66e49b1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

