module 0x21e33552f92751efa6c1371fb15ac929fcbfe2f46a480f74cb6ac6b5bbb61844::iboy {
    struct IBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBOY>(arg0, 6, b"IBOY", b"IBOY CLUB SUI", x"556e69717565206469676974616c20636f6c6c65637469626c6573206c6976696e67206f6e207468652053554920626c6f636b636861696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_6522_b80bf1d568.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

