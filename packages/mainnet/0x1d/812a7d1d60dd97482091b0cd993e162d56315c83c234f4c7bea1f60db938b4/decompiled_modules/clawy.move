module 0x1d812a7d1d60dd97482091b0cd993e162d56315c83c234f4c7bea1f60db938b4::clawy {
    struct CLAWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWY>(arg0, 6, b"CLAWY", b"CRAB CLAW", x"4920414d204d454d4520544f4b454e20494e2053554920574f524c4420414e44204f4e4c5920554e495155450a0a435245415455524520494e2054484520574f524c442046554c4c204f4620444f4749454553202f20434154532f204649534849454553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SEC_Pc9_Sf_400x400_50e1be8524.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

