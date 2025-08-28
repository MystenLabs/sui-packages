module 0x6e17d51d9fb3519b874c349b361f10371ad7cf389d9e581c7986df6a425e2de4::Balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 9, b"HARD", b"Balls", b"diamond balls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzYKB4WXkAERYDI?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

