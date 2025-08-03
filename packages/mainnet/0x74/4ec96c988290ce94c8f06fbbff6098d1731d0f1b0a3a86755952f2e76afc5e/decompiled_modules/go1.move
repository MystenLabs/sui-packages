module 0x744ec96c988290ce94c8f06fbbff6098d1731d0f1b0a3a86755952f2e76afc5e::go1 {
    struct GO1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO1>(arg0, 6, b"Go1", b"Go1 robot", b"Sui dog robot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053265_0d5d9017ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GO1>>(v1);
    }

    // decompiled from Move bytecode v6
}

