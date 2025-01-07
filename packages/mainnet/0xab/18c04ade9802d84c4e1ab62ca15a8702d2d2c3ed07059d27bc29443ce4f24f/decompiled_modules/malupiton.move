module 0xab18c04ade9802d84c4e1ab62ca15a8702d2d2c3ed07059d27bc29443ce4f24f::malupiton {
    struct MALUPITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALUPITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALUPITON>(arg0, 6, b"MALUPITON", b"malutpiton", b"letsgo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/459874595_1980484142398013_8246889913126390610_n_7887dcc437.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALUPITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALUPITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

