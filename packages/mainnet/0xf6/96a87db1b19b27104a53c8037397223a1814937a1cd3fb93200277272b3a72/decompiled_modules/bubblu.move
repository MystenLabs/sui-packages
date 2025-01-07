module 0xf696a87db1b19b27104a53c8037397223a1814937a1cd3fb93200277272b3a72::bubblu {
    struct BUBBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLU>(arg0, 6, b"BUBBLU", b"Sui bubblu", b"Join $BUBBLU on his adventures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049634_6e875b5539.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

