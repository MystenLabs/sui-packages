module 0x4303f3129f54e20f23b76e4fc070ae2d68866675e1e9f62900315b837b078ee5::macke {
    struct MACKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACKE>(arg0, 6, b"MACKE", b"Mackerel", b"$MACKE is Pepe of the Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mautache_1d0964b9d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

