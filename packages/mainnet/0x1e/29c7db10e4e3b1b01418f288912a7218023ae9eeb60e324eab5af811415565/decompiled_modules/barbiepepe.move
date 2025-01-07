module 0x1e29c7db10e4e3b1b01418f288912a7218023ae9eeb60e324eab5af811415565::barbiepepe {
    struct BARBIEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARBIEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARBIEPEPE>(arg0, 6, b"BARBIEPEPE", b"Barbie Pepe", b"your dreams are full of pink | $BARBIEPEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051340_8c06321eb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARBIEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARBIEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

