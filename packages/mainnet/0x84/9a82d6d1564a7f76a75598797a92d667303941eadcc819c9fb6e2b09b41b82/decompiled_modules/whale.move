module 0x849a82d6d1564a7f76a75598797a92d667303941eadcc819c9fb6e2b09b41b82::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Blue Whale", b"Only Whales Allowed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5796430216086798790_ab397bdc32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

