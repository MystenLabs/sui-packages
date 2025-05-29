module 0x88b02e6d6be72f78f884be960a5df1b3ec91fe2b7f5ce389a2e89db5b61dcef6::popkin {
    struct POPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPKIN>(arg0, 6, b"POPKIN", b"Popkin", b"The almighty SUI mascot, Popkin, has just been unleashed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pop_Kin_988b0ee2c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

