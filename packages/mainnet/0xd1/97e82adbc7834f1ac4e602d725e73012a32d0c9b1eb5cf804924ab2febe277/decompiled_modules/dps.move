module 0xd197e82adbc7834f1ac4e602d725e73012a32d0c9b1eb5cf804924ab2febe277::dps {
    struct DPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPS>(arg0, 6, b"DPS", b"Depressed", b"Do not buy and do not check the twitter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_black_image_ed20649339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

