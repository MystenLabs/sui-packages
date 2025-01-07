module 0xc4f0bac8e2b0d9c9b83b5fb4ce4b5c178f5e887461d3caac97f95aa5114d0ba8::archi {
    struct ARCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCHI>(arg0, 6, b"Archi", b"ART OF CHILDREN", b"every child has skills, and often we see how random children's paintings are, and here we are, supporting children's unlimited creativity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046612_ff3733f7a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

