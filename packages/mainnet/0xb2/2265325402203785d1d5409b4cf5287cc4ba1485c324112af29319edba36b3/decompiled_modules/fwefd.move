module 0xb22265325402203785d1d5409b4cf5287cc4ba1485c324112af29319edba36b3::fwefd {
    struct FWEFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWEFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWEFD>(arg0, 6, b"FWEFD", b"FWEF", b"123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alex_e129a7e323.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWEFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWEFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

