module 0x2ab4b273fa3902bc8b712a324991156a90da5ecd652c1f4e03c21c9e8da6a12f::dyrect {
    struct DYRECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYRECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYRECT>(arg0, 6, b"DYRECT", b"DYRECT ON SUI", b"Looking to edit videos in an easier, faster, and more advanced way? DYRECT is here to change the way you create and edit videos. With the latest AI technology, DYRECT allows you to craft high-quality videos in just minuteswithout needing complicated editing skills!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_103316_480_1946d32894.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYRECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DYRECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

