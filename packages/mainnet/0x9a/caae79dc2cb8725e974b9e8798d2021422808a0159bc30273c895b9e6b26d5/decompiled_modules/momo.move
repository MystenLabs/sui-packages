module 0x9acaae79dc2cb8725e974b9e8798d2021422808a0159bc30273c895b9e6b26d5::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"MOMO on SUI", x"4f6e6520244d4f4d4f2073746f7279206f6620686f772068652067657473206869732073756363657373206261636b21200a0a486f7720746f2066696e64204d6f6d6f3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_VHCY_Wj_N_400x400_c24b814d20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

