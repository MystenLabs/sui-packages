module 0x63243ecbf5d751f2a262c885a6edb9c2c4a9a3c4205e1864004b15c9546b5913::flight {
    struct FLIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT>(arg0, 6, b"FLIGHT", b"Flight  Agent", b"Flight Agent on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029940_e7880a0958.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

