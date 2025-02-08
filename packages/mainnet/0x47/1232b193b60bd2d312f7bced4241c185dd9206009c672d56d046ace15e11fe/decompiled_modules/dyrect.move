module 0x471232b193b60bd2d312f7bced4241c185dd9206009c672d56d046ace15e11fe::dyrect {
    struct DYRECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYRECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYRECT>(arg0, 6, b"Dyrect", b"Dyrect AI", b"Transform Your Videos Without Limits with DYRECT Looking to edit videos in an easier, faster, and more advanced way? DYRECT is here to change the way you create and edit videos. With the latest AI technology, DYRECT allows you to craft high-quality videos in just minuteswithout needing complicated editing skills!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2421_d46f5f8df3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYRECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DYRECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

