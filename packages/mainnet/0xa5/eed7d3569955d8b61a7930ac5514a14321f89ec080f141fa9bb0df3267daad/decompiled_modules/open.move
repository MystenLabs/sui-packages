module 0xa5eed7d3569955d8b61a7930ac5514a14321f89ec080f141fa9bb0df3267daad::open {
    struct OPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPEN>(arg0, 6, b"OPEN", b"OPEN THE MILK", b"$OPEN THE MILK...............PLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_21_00_19_b5817ecb21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

