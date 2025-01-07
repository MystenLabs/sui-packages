module 0x81d4c4039e581e81daaf1e2d63d04c0be88b7621c93224d55fb307c3db68d56a::grrr {
    struct GRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRRR>(arg0, 6, b"GRRR", b"GRRR DOG", b"GRRR DOG IS THE NEXT AAA CAT!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/39a8f1bd_db88_4301_8aed_5b4163142063_2_d2c614652a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

