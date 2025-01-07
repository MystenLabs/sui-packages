module 0xe9d5832d30bff5480f1cf4d86f532007d67d2e0e80d13d751152d80116918c3d::md6900 {
    struct MD6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD6900>(arg0, 6, b"MD6900", b"MOODENG6900", b"Two Legends, One Token  Moo Deng and SPX6900 Unite for $MOODENG6900 Supremacy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moodeng_754c52708a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MD6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

