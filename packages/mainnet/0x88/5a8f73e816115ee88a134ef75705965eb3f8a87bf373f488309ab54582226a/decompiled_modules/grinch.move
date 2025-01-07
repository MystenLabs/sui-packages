module 0x885a8f73e816115ee88a134ef75705965eb3f8a87bf373f488309ab54582226a::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"Grinch", b"Sui Grinch", x"4772696e6368206e6f77206f6e207375690a0a74686520626c7565206772696e636820746861742073746f6c65206368726973746d6173", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1662_39552a689e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

