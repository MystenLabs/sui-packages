module 0x8d20f8fe69216ac73e183b288dae70b387649ad50d9cc51bc3df18f33ab21b0e::suikemon {
    struct SUIKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEMON>(arg0, 6, b"Suikemon", b"Got Catch'em all", b"What Suikmon would you like to catch?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_f005b514f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

