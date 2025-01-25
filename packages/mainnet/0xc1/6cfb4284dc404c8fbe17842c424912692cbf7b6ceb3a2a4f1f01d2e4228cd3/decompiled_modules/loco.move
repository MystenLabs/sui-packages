module 0xc16cfb4284dc404c8fbe17842c424912692cbf7b6ceb3a2a4f1f01d2e4228cd3::loco {
    struct LOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCO>(arg0, 6, b"LOCO", b"Loco", b"Only invest your sui on Loco!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047550_658c80e87b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

