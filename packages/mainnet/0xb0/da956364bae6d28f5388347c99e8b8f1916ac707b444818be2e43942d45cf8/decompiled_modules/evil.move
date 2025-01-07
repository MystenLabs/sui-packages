module 0xb0da956364bae6d28f5388347c99e8b8f1916ac707b444818be2e43942d45cf8::evil {
    struct EVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVIL>(arg0, 6, b"EVIL", b"EVIL MONKEY", b"EVIL MONKEY SPOTTED ATTACKING THE BELOVED MOO DENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_00_37_18_1160749ddb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

