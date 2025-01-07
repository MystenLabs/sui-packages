module 0xb431d235dff5bc478f4753514f8a7a8cf1a263a9e13b9ca2b67b921f9fab1c9b::macke {
    struct MACKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACKE>(arg0, 6, b"MACKE", b"Mackerel", b"$MACKE is Pepe of the Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mautache_a2221309ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

