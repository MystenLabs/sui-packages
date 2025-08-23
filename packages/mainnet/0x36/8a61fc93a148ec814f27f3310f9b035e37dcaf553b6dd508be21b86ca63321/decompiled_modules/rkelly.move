module 0x368a61fc93a148ec814f27f3310f9b035e37dcaf553b6dd508be21b86ca63321::rkelly {
    struct RKELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKELLY>(arg0, 6, b"RKelly", b"Dri_Pee", b"Pee on you . Drip drip drip. OG Move pump is back !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1232_b1056f98d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

