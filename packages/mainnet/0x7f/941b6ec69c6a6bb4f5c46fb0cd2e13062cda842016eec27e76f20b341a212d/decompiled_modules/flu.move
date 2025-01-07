module 0x7f941b6ec69c6a6bb4f5c46fb0cd2e13062cda842016eec27e76f20b341a212d::flu {
    struct FLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLU>(arg0, 6, b"FLU", b"Fluioki", b"https://t.me/fluioki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_02_56_50_d06bc53587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

