module 0xc3a1248ca14ad1fc980949fa92d5c7452d07840ef6d649daf9c302df0bb2240a::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 6, b"FLOP", b"Fish Flops", b"I once lived in the beautiful Sui Sea, now I'm just a pair of fish flops.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_flop_3deecf7137.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

