module 0x1ec6b02ff2e398c4bff305279fbd97117b98c0f8419814017d0457a95cdc6886::suimoodeng {
    struct SUIMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOODENG>(arg0, 6, b"SUIMOODENG", b"MOODENG", b"If you didn't know, here are just a few ways you can have a bite of Moo Deng on SUI! The original and biggest Moo Deng community there is! Its no wonder we cross 150M volume daily.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16_5c57962fb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

