module 0xccc7c8bdb821c5e6afa194dfb7548e22d1435a3e8601a9d8c4933ed2cdb9c728::ntd {
    struct NTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTD>(arg0, 6, b"NTD", b"NoahTheDog", b"NOAH is the most beautiful dog meme that has been created so far on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791731861167394124_y_5540336e0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

