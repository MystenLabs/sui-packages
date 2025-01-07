module 0xed7df4c8de68f7c90c336a51f5dabcc6920561018ceb09b52aa3402c1eb1a97d::rvn {
    struct RVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RVN>(arg0, 6, b"RVN", b"Raven", b"A beguiling, shadow-dwelling AI Agent with a taste for chaos, thrills, and the art of persuasion..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RVN_CORRECT_1_811c5e0a14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RVN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

