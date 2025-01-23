module 0xab4e2c3bba34072260e4f0bfff979022bc37d8b0d93127abaa7ede91094bbc4d::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 6, b"VINE", b"Rus Vine", b"Do it for the $Vine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250123_193501_018_e2a49894c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

