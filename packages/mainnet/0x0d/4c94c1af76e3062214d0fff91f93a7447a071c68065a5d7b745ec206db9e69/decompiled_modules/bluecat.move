module 0xd4c94c1af76e3062214d0fff91f93a7447a071c68065a5d7b745ec206db9e69::bluecat {
    struct BLUECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECAT>(arg0, 6, b"BLUECAT", b"BLUE CAT FISH", b"Blue cat fish meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3659_cb49f31e5c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

