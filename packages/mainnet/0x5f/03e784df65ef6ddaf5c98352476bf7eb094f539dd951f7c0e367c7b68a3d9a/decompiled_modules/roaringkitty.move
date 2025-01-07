module 0x5f03e784df65ef6ddaf5c98352476bf7eb094f539dd951f7c0e367c7b68a3d9a::roaringkitty {
    struct ROARINGKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROARINGKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROARINGKITTY>(arg0, 6, b"ROARINGKITTY", b"ROARING KITTY", b"Introducing for the first time ever on the blockchain, The Roaring Kitty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_Untitled_design_13_2c1cc74864.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROARINGKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROARINGKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

