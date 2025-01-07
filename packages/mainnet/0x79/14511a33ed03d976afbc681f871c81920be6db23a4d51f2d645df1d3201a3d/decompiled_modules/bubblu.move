module 0x7914511a33ed03d976afbc681f871c81920be6db23a4d51f2d645df1d3201a3d::bubblu {
    struct BUBBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLU>(arg0, 6, b"BUBBLU", b"Bubblu on Sui", b"Join $BUBBLU on his adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049723_20f2693e88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

