module 0xd18a4e5c400991c2d38f97c0bd79181a7f8be678824bea9d4fa15fb0ee1e3470::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 6, b"SPACEX", b"SpaceX", b"SpaceX sends meme coins to Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731797238693.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

