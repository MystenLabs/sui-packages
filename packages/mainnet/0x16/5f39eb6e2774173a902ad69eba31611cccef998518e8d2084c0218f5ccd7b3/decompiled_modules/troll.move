module 0x165f39eb6e2774173a902ad69eba31611cccef998518e8d2084c0218f5ccd7b3::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"Troll", x"54726f6c6c20697320746865206e657765737420616e64206d6f7374206578636974696e67206d656d6520746f6b656e206f6e207468652053554920626c6f636b636861696e2e2044657369676e656420666f722074686f73652077686f206c6f76652068756d6f7220616e642077616e7420746f2062652070617274206f6620612066756e2c20656e676167696e6720636f6d6d756e6974792c202454524f4c4c20636f6d62696e65732074686520737069726974206f6620696e7465726e65742063756c7475726520776974682074686520696e6e6f766174696f6e206f6620626c6f636b636861696e20746563686e6f6c6f67792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/troll_face_44_f6ef4ce49a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

