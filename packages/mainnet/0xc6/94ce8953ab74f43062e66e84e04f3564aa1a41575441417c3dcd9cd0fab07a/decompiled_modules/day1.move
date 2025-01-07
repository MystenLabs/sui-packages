module 0xc694ce8953ab74f43062e66e84e04f3564aa1a41575441417c3dcd9cd0fab07a::day1 {
    struct DAY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAY1>(arg0, 6, b"DAY1", b"Day 1 on suu", b"Day1 Of The Craziest Crypto Year Run Ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250101_075650_886_24bfb0037f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

