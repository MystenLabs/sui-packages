module 0x2016ac27ce13da1988352a5702b6ee452a3534f97b5509d843186ea1118ac304::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 9, b"T Coin", b"T", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T>>(0x2::coin::mint<T>(&mut v2, 1000000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T>>(v1);
    }

    // decompiled from Move bytecode v6
}

