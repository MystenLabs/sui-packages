module 0x3d00c38d84dae9843788f44b69c2ffb7ac2d63a3dff1531d2c508afdfae87970::pongpang {
    struct PONGPANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONGPANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONGPANG>(arg0, 6, b"PongPang", b"Pong Pang", b" Friends Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020698_c38e231650.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONGPANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONGPANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

