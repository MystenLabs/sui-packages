module 0x371eaa679b2bc037e0ea4428667d0a785fdb55aceb8c0ae87d3c028c2596a50d::xaug {
    struct XAUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUG>(arg0, 9, b"XAUG", b"Gold", b"New start ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmWxNE56aX4srSfRD18PuirQzEeLxCu6qWhMR8t4i2pbzA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAUG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

