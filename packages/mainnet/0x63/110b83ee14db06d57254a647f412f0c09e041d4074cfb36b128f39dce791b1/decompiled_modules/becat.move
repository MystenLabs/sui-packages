module 0x63110b83ee14db06d57254a647f412f0c09e041d4074cfb36b128f39dce791b1::becat {
    struct BECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BECAT>(arg0, 6, b"beCAT", b"blue eyed Cat", b"A blue-eyed cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/this_cats_mesmerizing_ice_blue_eyes_v0_e6uydylsh4b81_8e6a5ef655.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

