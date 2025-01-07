module 0x61b8b61844f2b63c3ce82264770ba78e32f5e7744459ddae09611b1865c932be::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUI CAT", b"The original cat-themed meme coin on the Sui blockchain! As the first of its kind, When it comes to cat coins on Sui, were the trailblazers setting the trend. Get in on the ground floor with Sui Cat and be part of the OG cat coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicat_d8b639c5b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

