module 0xe514736fd4d2a5314f90284c4c69c3aa03a0e5fc1488bae27df29ff1b2163948::slo {
    struct SLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLO>(arg0, 6, b"Slo", b"Sloth", b"We will slowly conquer everywhere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xb9cxz_Wo_AA_Jd_q_4a48c72f54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

