module 0xf26c1489e71a803296b8eed274b6f88e6af836b0c0b23369f43746bc879ade7c::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"SUI GAME", b"Squid Games is the most popular tv series in the history of Netflix.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/533mis_SX_400x400_623657c385.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

