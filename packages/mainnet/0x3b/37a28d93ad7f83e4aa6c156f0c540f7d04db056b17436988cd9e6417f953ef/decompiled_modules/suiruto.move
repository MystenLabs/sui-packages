module 0x3b37a28d93ad7f83e4aa6c156f0c540f7d04db056b17436988cd9e6417f953ef::suiruto {
    struct SUIRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUTO>(arg0, 6, b"SUIRUTO", b"Suiruto Meme", x"245355495255202d20546865204e696e6a61206f6620537569204e6574776f726b2e0a0a4275726e656420313025200a426f75676874206261636b203525200a47726f77696e6720636f6d6d756e69747920656163682064617920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_013634_382_removebg_preview_a905cf25b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

