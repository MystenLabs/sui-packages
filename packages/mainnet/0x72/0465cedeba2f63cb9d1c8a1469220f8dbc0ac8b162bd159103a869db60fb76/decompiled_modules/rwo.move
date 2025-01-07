module 0x720465cedeba2f63cb9d1c8a1469220f8dbc0ac8b162bd159103a869db60fb76::rwo {
    struct RWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWO>(arg0, 6, b"RWO", b"RETARDIO WORLD ORDER", x"4c45542054484520574f524c44204f4620535549204f5244455220434f4d4d454e434521210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_X5jg_Mr_X_400x400_5e3c3d8bdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

