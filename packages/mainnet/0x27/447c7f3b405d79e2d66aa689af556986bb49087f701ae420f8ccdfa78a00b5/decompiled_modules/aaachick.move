module 0x27447c7f3b405d79e2d66aa689af556986bb49087f701ae420f8ccdfa78a00b5::aaachick {
    struct AAACHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACHICK>(arg0, 6, b"aaaChick", b"AAACHICK", b"cheep cheep cheep cheepAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_3_3ba884d696.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

