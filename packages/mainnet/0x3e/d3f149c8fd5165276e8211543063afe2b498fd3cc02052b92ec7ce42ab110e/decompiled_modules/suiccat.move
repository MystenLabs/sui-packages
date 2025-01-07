module 0x3ed3f149c8fd5165276e8211543063afe2b498fd3cc02052b92ec7ce42ab110e::suiccat {
    struct SUICCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICCAT>(arg0, 9, b"SUICCAT", b"Sui Cutest Cat", b"The original cat-themed meme coin on the Sui blockchain! As the first of its kind, When it comes to cat coins on Sui, were the trailblazers setting the trend. Get in on the ground floor with Sui Cat and be part of the OG cat coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Flogo_and_photos_01_812caab3d3.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICCAT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

