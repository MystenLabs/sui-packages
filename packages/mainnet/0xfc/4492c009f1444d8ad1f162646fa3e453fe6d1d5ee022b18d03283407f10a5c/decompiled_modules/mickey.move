module 0xfc4492c009f1444d8ad1f162646fa3e453fe6d1d5ee022b18d03283407f10a5c::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKEY>(arg0, 6, b"MICKEY", b"MICKEY COIN ON SUI", b"MICKEY is now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Simple_Logo_crypto_coin_with_Mickey_inside_no_b_29da035c53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

