module 0x493084265c4e34400caa10b55e0f211aa5006ae997c9c07acc4ba7ae48b02c6::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUISUPA", b"SUPA is Coming  SUPA's only goal is popularity on #SUIMEME. HODLERS are needed to become popular. Are you curious about what we can do jn SUI? Just follow Can i get back GM? Something is coming but maybe nothing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018202_569448bc50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

