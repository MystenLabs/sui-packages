module 0x6564b9301dd71fdc55f1a202763441783d2b6130315e4ca71a1e87b3c1980e41::foxitup {
    struct FOXITUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXITUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXITUP>(arg0, 6, b"FOXITUP", b"FuddingFOX", b"What does the fox say on SUI?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img2_9cc990a735.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXITUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXITUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

