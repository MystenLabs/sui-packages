module 0x8e6ea41b5bcaaa63604c2307a7b72dbb3771d4cc6a6e10a546073fd1fe396292::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 6, b"GCat", b"GoldCat", x"476f6c644361742066726f6d20736f6c20746f205375692e0a4c61756e6368206e6f7721204a6f696e2075732066616d696c7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4030_97a15b3c1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

