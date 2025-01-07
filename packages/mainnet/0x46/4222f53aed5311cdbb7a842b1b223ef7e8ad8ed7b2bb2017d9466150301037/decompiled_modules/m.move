module 0x464222f53aed5311cdbb7a842b1b223ef7e8ad8ed7b2bb2017d9466150301037::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 6, b"M", b"Ming", b"Ming Ming Ming Ming Ming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4023_80a6e3303e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M>>(v1);
    }

    // decompiled from Move bytecode v6
}

