module 0xa9705232dad07c81299fc537521918e01a1fe7980e21659defb6ffe328bfc3e::darggg {
    struct DARGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARGGG>(arg0, 6, b"DARGGG", b"Darggg", b"Ahoy matey! Darggg be here to plunder all of yer sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_2_76b6454aa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

