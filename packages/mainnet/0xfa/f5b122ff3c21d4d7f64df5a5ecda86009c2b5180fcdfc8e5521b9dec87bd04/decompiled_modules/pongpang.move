module 0xfaf5b122ff3c21d4d7f64df5a5ecda86009c2b5180fcdfc8e5521b9dec87bd04::pongpang {
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

