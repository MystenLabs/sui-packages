module 0x8c8bf767af4d466ba8b2336d975ed6f1951ee5e81cc594ee8bbc6165977da8b1::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TEST", b"Wow, It's test.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Anna_Wintour_Coin_db60cbf64c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST>>(v1);
    }

    // decompiled from Move bytecode v6
}

