module 0xae4fe9a80837c500527e317c49c1b4641f22b3effa99feafddd233f557ad93e::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"Suirtle", b"Hydropumpin through dips", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirtle_adb42ef6f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

