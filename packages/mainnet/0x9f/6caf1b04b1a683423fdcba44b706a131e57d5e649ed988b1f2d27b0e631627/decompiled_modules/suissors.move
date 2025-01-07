module 0x9f6caf1b04b1a683423fdcba44b706a131e57d5e649ed988b1f2d27b0e631627::suissors {
    struct SUISSORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSORS>(arg0, 6, b"SUISSORS", b"SUISSORS on SUI", b"DON'T GET CUT! DON'T GET CUT! DON'T GET CUT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scissors_71f853b391.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSORS>>(v1);
    }

    // decompiled from Move bytecode v6
}

