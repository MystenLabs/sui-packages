module 0xdeef2f5fbb40ef083c78cd6c958aeec5e4be6950bd706da17299fa74bdbed89::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 6, b"HOLE", b"BLACK HOLE", b"black hole", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elpuntonegro_c646affbd0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

