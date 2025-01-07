module 0x39115405f883d852a21c6c68f170cf0ff60329d8751e54124ae2b64efe487db3::bfrog {
    struct BFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFROG>(arg0, 6, b"BFROG", b"Blue Frog", b"Blue Frog | The rarest frog on the block, bringing cool vibes and big leaps!  Hop into the world of fun, fortune, and frog-filled adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2c2o_GO_Ts_S0ehfv_E8_P_Erz8_A_52f3886b59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

