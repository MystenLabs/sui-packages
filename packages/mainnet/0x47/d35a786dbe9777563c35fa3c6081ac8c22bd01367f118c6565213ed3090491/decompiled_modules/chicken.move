module 0x47d35a786dbe9777563c35fa3c6081ac8c22bd01367f118c6565213ed3090491::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"Chicken", b"chicken unicorn in the universe", x"49276d20436869636b69636f726e746865206f6e6520616e64206f6e6c7920636869636b656e20756e69636f726e20696e2074686520756e6976657273652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052664_12207551ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

