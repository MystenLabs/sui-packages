module 0x6004bc4307432ef2c63d318b628507d0837498eda6f53a34c5a3c262f87ff215::grimmy {
    struct GRIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIMMY>(arg0, 6, b"GRIMMY", b"GRIMMY THE SLUG", b"$GRIMMY THE DIRTY SLUG IS READY TO EXPLORE EARTH's MUDDY PLACES!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1009_9fcc9fc00f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

