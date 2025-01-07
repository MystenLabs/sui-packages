module 0xe078f1ec10c3fccce0a701c05b90fefa9cf0f49b57cacc96fbf0c185f2143d6d::pole {
    struct POLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLE>(arg0, 6, b"POLE", b"POLE on SUI", b"$POLE - A Born in the vast, frosty waters of the Sui with a humor as the pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_232017_6d1dd14ec4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

