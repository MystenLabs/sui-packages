module 0x93e1ffc9eb0bba5540cd2fef70a13d1bf9dbd07bbf98cc179315415d294d7d90::nigaldo {
    struct NIGALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGALDO>(arg0, 6, b"Nigaldo", b"SUIstiano Nigaldo", b"What if the GOAT is BLACK, did he get Famous as right now ??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046629_a5c92e4bb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

