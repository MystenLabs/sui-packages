module 0x8103e625b1a22c5653aedd273628b1024e324997c4a9c35e0159610b86737a59::kv {
    struct KV has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV>(arg0, 6, b"kv", b"kuntoria", b"kuntoria forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPwfdEkFo8pfNF5GDqUpa6tWQcJwSARFdStDZqcURWysN?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KV>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV>>(v2, @0xb2fc918160dcd61a2ff60169e0a5407fc8b960fce3f01f4d671983d52025b123);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KV>>(v1);
    }

    // decompiled from Move bytecode v6
}

