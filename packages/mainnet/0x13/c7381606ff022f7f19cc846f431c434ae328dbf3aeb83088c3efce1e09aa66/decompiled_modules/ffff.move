module 0x13c7381606ff022f7f19cc846f431c434ae328dbf3aeb83088c3efce1e09aa66::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 6, b"FFFF", b"dff", b"fdfff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_1_602322e35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

