module 0xb9f434758b240cfe8ed1a855dda1c4fcc93561235beeaec4c55272b8b74f86bd::pole {
    struct POLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLE>(arg0, 6, b"POLE", b"POLESUI", b"Hi im $POLE - A born in the vast, frosty waters of the Sui with a humor as the pepe , Pole embodies the chill vibe of his icy home, bringing joy and laughter wherever he goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3548_b104672447.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

