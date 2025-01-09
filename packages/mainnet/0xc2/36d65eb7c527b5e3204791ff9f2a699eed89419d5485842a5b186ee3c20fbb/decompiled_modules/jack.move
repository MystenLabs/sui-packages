module 0xc236d65eb7c527b5e3204791ff9f2a699eed89419d5485842a5b186ee3c20fbb::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 6, b"JACK", b"Captain Jack", b"I am Captain Jack, and behold my new treasure: Captain Jack memecoin! This coin, like me, is full of adventures and romance of the seven seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_237bec2e8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

