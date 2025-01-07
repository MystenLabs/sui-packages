module 0x180d4897028eeba86adf11156693a38bb68df6d2c717f90340c3f388d9f75df7::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 6, b"SI", b"SUSI", b"Small cute baby Susi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_q_I_3a36b703a5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SI>>(v1);
    }

    // decompiled from Move bytecode v6
}

