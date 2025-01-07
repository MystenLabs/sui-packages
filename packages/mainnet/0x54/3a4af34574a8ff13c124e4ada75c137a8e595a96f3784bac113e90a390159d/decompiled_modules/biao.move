module 0x543a4af34574a8ff13c124e4ada75c137a8e595a96f3784bac113e90a390159d::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"BIAO ON SUI", b"ANY HOW BIAO (PUMP)  $BIAO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Biao_pfp_271698dc89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

