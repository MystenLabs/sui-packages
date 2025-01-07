module 0x1745252b4c5a7d914036fbbebb125359d1a869cb2f31c760fe982f354650ebe1::movedog {
    struct MOVEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDOG>(arg0, 6, b"MOVEDOG", b"MOVE SCUBA DOG", b"SCUBA DOG IS $MOVEDOG, dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3767_5b1499902b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

