module 0xef477a636c2d4d2c072c817fa367498041d59119be9dff5b78c7e96f6155e7d9::glub {
    struct GLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUB>(arg0, 6, b"GLUB", b"Suimese Fighting Fish", x"45766572796f6e652773206661766f726974652066697368202e6f4f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5429_5c22adf159.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

