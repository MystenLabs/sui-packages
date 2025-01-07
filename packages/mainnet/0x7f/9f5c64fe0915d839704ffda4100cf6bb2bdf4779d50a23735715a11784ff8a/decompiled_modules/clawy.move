module 0x7f9f5c64fe0915d839704ffda4100cf6bb2bdf4779d50a23735715a11784ff8a::clawy {
    struct CLAWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWY>(arg0, 6, b"CLAWY", b"SUI CLAW", x"4920414d204d454d4520544f4b454e20494e2053554920574f524c4420414e44204f4e4c5920554e495155450a0a435245415455524520494e2054484520574f524c442046554c4c204f4620444f4749454553202f20434154532f204649534849454553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_claw_623f936cb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

