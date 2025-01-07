module 0x5cec8f4589d1482f2fdfec93819e66126169a9cff8775c9a036452a172b2a22c::buffneiro {
    struct BUFFNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFNEIRO>(arg0, 6, b"BUFFNEIRO", b"BUFF NEIRO", b"BUFFNEIRO, BUFF IS STRONG DOG WITH NEIRO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C00174_F4_94_C1_4_D7_F_9_E4_E_47948_CE_88_C40_53224b05dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFFNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

