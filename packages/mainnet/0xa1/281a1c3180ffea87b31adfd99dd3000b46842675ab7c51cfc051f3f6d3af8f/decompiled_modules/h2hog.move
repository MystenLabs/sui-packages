module 0xa1281a1c3180ffea87b31adfd99dd3000b46842675ab7c51cfc051f3f6d3af8f::h2hog {
    struct H2HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2HOG>(arg0, 6, b"H2HOG", b"H2O HEDGEHOG", x"48324f202b204845444745484f47203d204832484f470a4865646765686f672074686174206c6f76657320746f207377696d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h2hog_logo_better_71a9fcc4ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H2HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

