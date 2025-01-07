module 0xdb493743c52ee75f48fda7ee0b80004734c8cb27b16b4a627e6232a7f2293499::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"URC7", x"555220c2b720437269737469616e6f", b"UR Cristiano is Cristiano Ronaldo's official YouTube channel. He created this channel to share moments from his personal life, training sessions, and other activities outside of the football field.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/Qmdqm_PAQ_9_Tc9ip6_P3i_MSN_Dz7g1y_Jo_Bpt6b2xi_A_Nz4_J_Fir_C_b44c840c69.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

