module 0xfad188c0d98e4232c6f08b5c7115c805225fa9a3017701d62863be700d4bd70f::zhot {
    struct ZHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHOT>(arg0, 6, b"ZHOT", b"ZHOT TM", b"Meet Zhot, the digital sensation capturing hearts and views. With an astounding 5 billion views.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1937_7c00d63909.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

