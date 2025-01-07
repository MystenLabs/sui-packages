module 0x86b0441c094720021db52482771b8fe99da9401a966a38de87c40c1d52c76f89::cindy {
    struct CINDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINDY>(arg0, 6, b"CINDY", b"Cindy Lou", x"57656c636f6d65206f6e2043696e6479204c6f750a5468652062656c6f7665642063757469652077686f20736176656420746865204368726973746d6173206f6e2020737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054533_6e2fc7b41f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CINDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

