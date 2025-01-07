module 0x7b5442caec5594199256b91a213d08642e90029d334659dd0ad7d3a1019ccb76::jeff {
    struct JEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFF>(arg0, 6, b"JEFF", b"Jeff", b"Hi im JEFF, yeah that fking duck, Im an og duck who only cares about its holders and will do whatever it takes for every single one of $JEFF Holders to win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_07_T235410_645_098de30f44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

