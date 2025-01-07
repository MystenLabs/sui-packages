module 0x51259d85176ae26dc02f12be09dda92f0b8a5620e45a3b191c43bed06982bfb8::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL>(arg0, 6, b"POOL", b"Pool on SUI", b"Whether you're here for the tech, the community, $POOL has something for everyone. Dive in and make a splash together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_Yicq0c_400x400_25e20a74d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

