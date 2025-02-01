module 0x5b590a2cc4857f69c6424b7c82fd857042bbf72d1dfd6f85f7f2e88e88076ab3::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 6, b"FLOP", b"Sui Flop", b"BELIEVE IN FLOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000170134_b483c754f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

