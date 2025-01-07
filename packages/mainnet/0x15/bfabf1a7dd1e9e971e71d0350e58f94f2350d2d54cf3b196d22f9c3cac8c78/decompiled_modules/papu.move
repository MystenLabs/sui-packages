module 0x15bfabf1a7dd1e9e971e71d0350e58f94f2350d2d54cf3b196d22f9c3cac8c78::papu {
    struct PAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPU>(arg0, 6, b"PAPU", b"PaPU", b"PAPU is a lucky parrot, not much", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914011053_abd69efc96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

