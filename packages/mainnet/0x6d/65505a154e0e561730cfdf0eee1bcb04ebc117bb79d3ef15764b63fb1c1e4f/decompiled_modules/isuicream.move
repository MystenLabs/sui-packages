module 0x6d65505a154e0e561730cfdf0eee1bcb04ebc117bb79d3ef15764b63fb1c1e4f::isuicream {
    struct ISUICREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUICREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUICREAM>(arg0, 6, b"ISUICREAM", b"Isuicream", b"Get ready for a burst of flavor and fun on the SUI network with $ISUICREAM! This token is the perfect blend of the smoothness of ice cream and the innovation of cryptocurrencies. With $ISUICREAM, you not only invest but also enjoy a refreshing experience, just like ice cream on a hot summer day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_14_44_47_bd7dea673f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUICREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUICREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

