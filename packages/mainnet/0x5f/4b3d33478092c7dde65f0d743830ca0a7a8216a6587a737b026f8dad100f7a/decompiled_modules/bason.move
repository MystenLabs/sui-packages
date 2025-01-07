module 0x5f4b3d33478092c7dde65f0d743830ca0a7a8216a6587a737b026f8dad100f7a::bason {
    struct BASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASON>(arg0, 6, b"BASON", b"Bason The Family", b"Revolutionizing the world with abounding nourishment and love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002435_70aeab348c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASON>>(v1);
    }

    // decompiled from Move bytecode v6
}

