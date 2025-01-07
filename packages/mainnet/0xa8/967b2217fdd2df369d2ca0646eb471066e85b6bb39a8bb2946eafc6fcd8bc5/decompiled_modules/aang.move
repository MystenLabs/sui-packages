module 0xa8967b2217fdd2df369d2ca0646eb471066e85b6bb39a8bb2946eafc6fcd8bc5::aang {
    struct AANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AANG>(arg0, 6, b"AANG", b"AANG SUI", b"Aang Sui:  Bend the market with the power of the Avatar! Join the Sui Chains most promising memecoin. Lets ride this wave together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_0075d34f58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

