module 0x41b6f99d3d150ec4525da3889b86fe03581aad04e8a23fd420a0663f9a153fc::osuimhen {
    struct OSUIMHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUIMHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUIMHEN>(arg0, 6, b"OSUIMHEN", b"oSUImhen", b"The GOAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3646_5c29401d39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUIMHEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSUIMHEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

