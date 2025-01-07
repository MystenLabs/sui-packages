module 0xb2f5c2c885ccb499680c8e57f5df38a72917c1372acc7df530deb8abdf320476::blackpepe {
    struct BLACKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKPEPE>(arg0, 6, b"Blackpepe", b"blackpepe", b"Just another pepe with a dark side.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blackpepe_3d3b84dbd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

