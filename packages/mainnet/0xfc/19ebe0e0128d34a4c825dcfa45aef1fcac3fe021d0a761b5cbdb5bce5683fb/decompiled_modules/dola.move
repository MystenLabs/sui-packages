module 0xfc19ebe0e0128d34a4c825dcfa45aef1fcac3fe021d0a761b5cbdb5bce5683fb::dola {
    struct DOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLA>(arg0, 6, b"DOLA", b"Dolphin Agent", x"32342f37204461746120547261636b696e67200a416c2052616461722053797374656d0a50726f636573736564204461746120416e616c797369732c0a4275696c74204f6e20405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0591_851c83cee1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

