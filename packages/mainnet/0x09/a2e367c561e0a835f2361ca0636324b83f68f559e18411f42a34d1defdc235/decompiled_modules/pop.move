module 0x9a2e367c561e0a835f2361ca0636324b83f68f559e18411f42a34d1defdc235::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"PopSpheal", x"504f5053504845414c20636f6d65732072696768742066726f6d20506f6b656d6f6e2e204a6f696e2068696d206f6e20686973206a6f75726e657920617320686520636c696d627320616e6420636f6d706574657320616761696e737420424c55422061732053554920636c696d627320746f204154482773210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_21_22b501ddd1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

