module 0x3a8734c2f8686077fc0a6373fe387806f30eab2274c7dac20ab1263e71237a96::scraft {
    struct SCRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAFT>(arg0, 6, b"SCRAFT", b"SUICRAFT", b"$SUICRAFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6800_7d1fad9649.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

