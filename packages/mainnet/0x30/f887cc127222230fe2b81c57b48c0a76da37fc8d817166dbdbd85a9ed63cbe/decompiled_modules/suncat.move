module 0x30f887cc127222230fe2b81c57b48c0a76da37fc8d817166dbdbd85a9ed63cbe::suncat {
    struct SUNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNCAT>(arg0, 6, b"SunCat", b"Sui Cat", b"The original cat-themed meme coin on the Sui blockchain! As the first of its kind,  When it comes to cat coins on Sui, were the trailblazers setting the trend. Get in on the ground floor with Sui Cat and be part of the OG cat coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_and_photos_01_dd9e45d79b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

