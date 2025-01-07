module 0xe1222684cf657d96912554ed4025f82c3057471a2fbb72f0e95cd5702e6b674e::suiwolf {
    struct SUIWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOLF>(arg0, 6, b"SUIWOLF", b"Sui Wolf", b"$SUIWOLF - The icon of Sui. Sui Wolf is the most Degenerate character from the Matt Furie's Boy's club comic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_02_27_20_8b26a5aaff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

