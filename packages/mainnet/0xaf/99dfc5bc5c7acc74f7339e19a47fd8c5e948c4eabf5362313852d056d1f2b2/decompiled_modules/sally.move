module 0xaf99dfc5bc5c7acc74f7339e19a47fd8c5e948c4eabf5362313852d056d1f2b2::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 6, b"SALLY", b"Sally", b"Welcome to Sally , your ultimate destination for laughter and viral content! Dive into a world of endless humor and creativity, where transcend boundaries and bring people together. From side-splitting jokes to relatable moments, Sally is your go-to source for the latest and greatest in internet culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_23_45_36_a657acae1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

