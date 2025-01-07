module 0xa755b380ff72d437ad348ef557d3e86485f9c23a595a20adfed70b84e5494dcb::skc {
    struct SKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKC>(arg0, 6, b"SKC", b"SKCoin", b"this is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/socialkingdom_d7c9f64fe5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

