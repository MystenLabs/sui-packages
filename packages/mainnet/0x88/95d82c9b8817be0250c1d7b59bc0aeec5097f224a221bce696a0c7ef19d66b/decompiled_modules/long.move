module 0x8895d82c9b8817be0250c1d7b59bc0aeec5097f224a221bce696a0c7ef19d66b::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 6, b"LONG", b"Long Boi", b"Longest fucking pepe in the world oh lawd he long stays long", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014672_569ae933be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

