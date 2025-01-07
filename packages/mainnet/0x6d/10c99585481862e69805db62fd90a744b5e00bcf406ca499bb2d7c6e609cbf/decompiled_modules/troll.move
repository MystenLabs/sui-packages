module 0x6d10c99585481862e69805db62fd90a744b5e00bcf406ca499bb2d7c6e609cbf::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"TROLLS", b"meme coin revolutionizing crypto! On SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060316_e9998fd261.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

