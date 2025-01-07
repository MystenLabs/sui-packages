module 0x48411691d7dac7e38c2e1c7a419c74e851b46918ae2d8e752aa344da5984720c::ddddddd {
    struct DDDDDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDDDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDDDDD>(arg0, 6, b"DDDDDDD", b"DDDDDDDog", b"DDDDDDD4fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241012_231623_30c2bc12e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDDDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDDDDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

