module 0x8fd67739502f9cdceb87ef751755a512e08bcaf8a90522f6ff4c332fc76cf7fe::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"tremp", b"TREMP", b"we spread only false information $TREMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmUfJduMWY7q1akCJcb5zqAwxU6vikJdjstjm5nP6kg2Ww?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TREMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v2, @0x8665194c037e0b51c25bfdd033c04de44232d394947f49f748211af5699d9a64);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

