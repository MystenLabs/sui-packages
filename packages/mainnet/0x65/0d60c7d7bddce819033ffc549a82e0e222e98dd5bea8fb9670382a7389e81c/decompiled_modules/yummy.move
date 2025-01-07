module 0x650d60c7d7bddce819033ffc549a82e0e222e98dd5bea8fb9670382a7389e81c::yummy {
    struct YUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMMY>(arg0, 6, b"YUMMY", b"yum", b"pepe noooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_a9ae84bf39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

