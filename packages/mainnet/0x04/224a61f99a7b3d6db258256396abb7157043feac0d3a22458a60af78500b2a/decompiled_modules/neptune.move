module 0x4224a61f99a7b3d6db258256396abb7157043feac0d3a22458a60af78500b2a::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"Neptune Sui", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neptune_513fbab208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPTUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

