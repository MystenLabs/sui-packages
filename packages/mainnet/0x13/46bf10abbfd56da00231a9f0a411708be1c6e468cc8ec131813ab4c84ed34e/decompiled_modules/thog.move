module 0x1346bf10abbfd56da00231a9f0a411708be1c6e468cc8ec131813ab4c84ed34e::thog {
    struct THOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOG>(arg0, 6, b"THOG", b"Theory Of Gravity", b"Sir Froggy Newtons Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/THOG_17c1ee15e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

