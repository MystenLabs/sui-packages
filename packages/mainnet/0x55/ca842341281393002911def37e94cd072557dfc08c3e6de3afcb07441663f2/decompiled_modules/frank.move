module 0x55ca842341281393002911def37e94cd072557dfc08c3e6de3afcb07441663f2::frank {
    struct FRANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANK>(arg0, 6, b"FRANK", b"Frank The moke moker", b"Just the frank ourbg guys jdgga shsgwowk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048729_91873a7a59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

