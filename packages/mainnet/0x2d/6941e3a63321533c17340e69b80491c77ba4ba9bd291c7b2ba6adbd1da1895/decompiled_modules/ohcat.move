module 0x2d6941e3a63321533c17340e69b80491c77ba4ba9bd291c7b2ba6adbd1da1895::ohcat {
    struct OHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHCAT>(arg0, 6, b"OHCAT", b"Oh Cat", b"Oh cat, a cute little kitty cat. Oh, cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Cat_be7bd69be0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

