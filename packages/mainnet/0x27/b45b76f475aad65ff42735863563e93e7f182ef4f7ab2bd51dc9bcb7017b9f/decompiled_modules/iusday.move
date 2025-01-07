module 0x27b45b76f475aad65ff42735863563e93e7f182ef4f7ab2bd51dc9bcb7017b9f::iusday {
    struct IUSDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSDAY>(arg0, 6, b"IUSDAY", b"IUS DAY", b"The IUS token is a memecoin of Sui Network, mirrors the narrative token of sui that is run by the community. We're building up the future of sui meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/458079976_1481095545875972_1164279931871181120_n_3650eb6126.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUSDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

