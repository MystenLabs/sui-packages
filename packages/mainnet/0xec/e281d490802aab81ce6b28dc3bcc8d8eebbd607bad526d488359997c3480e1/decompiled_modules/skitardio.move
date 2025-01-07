module 0xece281d490802aab81ce6b28dc3bcc8d8eebbd607bad526d488359997c3480e1::skitardio {
    struct SKITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITARDIO>(arg0, 6, b"SKITARDIO", b"SKI TARDIO", b"Skitardio Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6631_8b03c51a5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

