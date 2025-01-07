module 0xb49674614fe085ff5c155dfdcca785d9cccdaa78e5faacc1e960e16ea8594d9d::ptree {
    struct PTREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTREE>(arg0, 6, b"PTREE", b"Just A Pudgy Christmas Tree", b" to bring the jolly gains! Just a Pudgy Christmas Tree is the real decoration your wallet needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241220_193116_777_251c146b3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

