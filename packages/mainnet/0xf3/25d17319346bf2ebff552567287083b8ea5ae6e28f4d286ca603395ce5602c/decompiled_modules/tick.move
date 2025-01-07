module 0xf325d17319346bf2ebff552567287083b8ea5ae6e28f4d286ca603395ce5602c::tick {
    struct TICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICK>(arg0, 6, b"Tick", b"Blue Tick", x"6c6f6f6b21204b6f6c7320616c6c206861766520626c7565207469636b730a74686579206172652063616c6c696e67207573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1131728830790_pic_d6582824dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

