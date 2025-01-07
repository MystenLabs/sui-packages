module 0x4bb11426b254295205272cc11a8ef9b00a4b9bf3f0cf7945e3809e030a2d9f18::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"WUT THE SEAL", b"WUT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/awkwar_11518d7d7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

