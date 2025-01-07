module 0x187f13cff51f78d5a0357061ed6ee34f8160fa13a582fd6ba13dfb06b2aee5b7::bits {
    struct BITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITS>(arg0, 6, b"BITS", b"2BITS TERM", b"We are smart brain.exe money gang, $2bits is our home , skip this if you are dumb brain gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G2_Lbf_K_Fj_400x400_c06914a716.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

