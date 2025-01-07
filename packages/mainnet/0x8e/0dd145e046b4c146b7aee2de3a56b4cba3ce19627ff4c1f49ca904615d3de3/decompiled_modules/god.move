module 0x8e0dd145e046b4c146b7aee2de3a56b4cba3ce19627ff4c1f49ca904615d3de3::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 9, b"GOD", b"AMEN", b"this token is blessed by god", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOD>(&mut v2, 6666666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

