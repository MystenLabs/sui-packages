module 0x27c7ae4f24429af0a043770fe8259d119a0977e715350438c39ad0e95c05fa5c::fasui {
    struct FASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASUI>(arg0, 6, b"FASui", b"Football Arena Sui", b"Combination of Football and Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BA_4_E96_E8_84_F0_47_F2_A92_A_9995_AC_118_AFD_f9ca5f15dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

