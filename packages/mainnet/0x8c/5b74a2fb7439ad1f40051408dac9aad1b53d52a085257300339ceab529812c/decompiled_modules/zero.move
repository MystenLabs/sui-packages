module 0x8c5b74a2fb7439ad1f40051408dac9aad1b53d52a085257300339ceab529812c::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO>(arg0, 6, b"ZERO", b"Zero Coin", b"$ZERO coin will go to zero. It will be worthless. Do not buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1219_067ab29ee9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

