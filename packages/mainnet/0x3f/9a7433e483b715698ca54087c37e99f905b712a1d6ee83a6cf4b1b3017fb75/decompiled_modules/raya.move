module 0x3f9a7433e483b715698ca54087c37e99f905b712a1d6ee83a6cf4b1b3017fb75::raya {
    struct RAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYA>(arg0, 6, b"RAYA", b"AQUAMANS DOG", b"Raya is a cute German Shephard owned by Aquaman himself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_a595a135ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

