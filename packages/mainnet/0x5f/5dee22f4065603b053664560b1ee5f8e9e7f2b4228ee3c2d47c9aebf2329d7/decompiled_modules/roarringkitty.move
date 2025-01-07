module 0x5f5dee22f4065603b053664560b1ee5f8e9e7f2b4228ee3c2d47c9aebf2329d7::roarringkitty {
    struct ROARRINGKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROARRINGKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROARRINGKITTY>(arg0, 6, b"ROARRINGKITTY", b"ROARING KITTY", b"Introducing for the first time ever on the blockchain, The Roaring Kitty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_Untitled_design_13_2c1cc74864_7b1850d563.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROARRINGKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROARRINGKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

