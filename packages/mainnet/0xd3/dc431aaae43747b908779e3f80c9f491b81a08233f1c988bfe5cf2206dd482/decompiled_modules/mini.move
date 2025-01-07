module 0xd3dc431aaae43747b908779e3f80c9f491b81a08233f1c988bfe5cf2206dd482::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"MiniShark", b"MiniShark is a crypto Shark who seeks to made you a crypto millionaire alongside in this bull run!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/512x512_1_1540df8649.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

