module 0x4b41d8a5304ea10d31eb4753c58f1b3de23947d65d29cc933561d297455a9675::ryp {
    struct RYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYP>(arg0, 6, b"RYP", b"Retire Your Parents", b"Have you ever wanted to make your parents proud? Have you ever wanted to be rich? Look no more. $RETIRE will change your life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i4q_Wb_S9_400x400_29fa629f94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

