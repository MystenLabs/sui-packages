module 0x2f2eaf7f13f5bead0e8256f9c158ab37510540325953bb635630d186921962fa::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"SUI Neiro", b"Neiro, the sister of the legendary $DOGE, has arrived on Sui chain to make history. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008408_da6f50c870.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

